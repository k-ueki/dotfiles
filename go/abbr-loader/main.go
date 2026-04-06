package main

import (
	"bufio"
	"crypto/md5"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"gopkg.in/yaml.v3"
)

// entryType distinguishes how an entry should be applied.
type entryType int

const (
	entryAbbr   entryType = iota // registered via abbr
	entryAlias                   // registered via alias
	entryGlobal                  // registered via abbr -g
)

type entry struct {
	name      string
	expansion string
	kind      entryType
}

func cacheFile() string {
	home, _ := os.UserHomeDir()
	return filepath.Join(home, ".cache", "abbr-loader.hash")
}

func userAbbrsFile() string {
	home, _ := os.UserHomeDir()
	return filepath.Join(home, ".config", "zsh-abbr", "user-abbreviations")
}

func currentHash(data []byte) string {
	return fmt.Sprintf("%x", md5.Sum(data))
}

func cachedHash() string {
	b, err := os.ReadFile(cacheFile())
	if err != nil {
		return ""
	}
	return strings.TrimSpace(string(b))
}

// singleQuote wraps s in single quotes, escaping any embedded single quotes.
func singleQuote(s string) string {
	return strings.ReplaceAll(s, "'", `'\''`)
}

func updateCache(hash string) {
	dir := filepath.Dir(cacheFile())
	_ = os.MkdirAll(dir, 0755)
	_ = os.WriteFile(cacheFile(), []byte(hash), 0644)
}

// parseYAML reads desired entries from the YAML file.
// Sections named "alias" are applied as shell aliases; "global" as abbr -g;
// all other sections as regular abbr.
func parseYAML(data []byte) ([]entry, error) {
	var doc yaml.Node
	if err := yaml.Unmarshal(data, &doc); err != nil {
		return nil, err
	}
	if doc.Kind == 0 {
		return nil, nil
	}

	var entries []entry
	root := doc.Content[0]
	for i := 0; i < len(root.Content)-1; i += 2 {
		section := root.Content[i].Value
		nodes := root.Content[i+1]

		var kind entryType
		switch section {
		case "alias":
			kind = entryAlias
		case "global":
			kind = entryGlobal
		default:
			kind = entryAbbr
		}

		for j := 0; j < len(nodes.Content)-1; j += 2 {
			entries = append(entries, entry{
				name:      nodes.Content[j].Value,
				expansion: nodes.Content[j+1].Value,
				kind:      kind,
			})
		}
	}
	return entries, nil
}

// parseCurrentAbbrs reads the current abbreviation state from the zsh-abbr
// user-abbreviations file. Format: abbr [-g] name='expansion'
func parseCurrentAbbrs() map[string]entry {
	result := make(map[string]entry)
	f, err := os.Open(userAbbrsFile())
	if err != nil {
		return result
	}
	defer f.Close()

	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}
		parts := strings.Fields(line)
		if len(parts) < 2 || parts[0] != "abbr" {
			continue
		}
		kind := entryAbbr
		rest := parts[1:]
		if rest[0] == "-g" {
			kind = entryGlobal
			rest = rest[1:]
		}
		if len(rest) == 0 {
			continue
		}
		kv := rest[0]
		idx := strings.Index(kv, "=")
		if idx < 0 {
			continue
		}
		name := kv[:idx]
		expansion := strings.Trim(kv[idx+1:], "'\"")
		result[name] = entry{name: name, expansion: expansion, kind: kind}
	}
	return result
}

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "usage: abbr-loader <file.yaml>")
		os.Exit(1)
	}

	data, err := os.ReadFile(os.Args[1])
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}

	desired, err := parseYAML(data)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}

	var aliasEntries []entry
	var abbrEntries []entry
	for _, e := range desired {
		if e.kind == entryAlias {
			aliasEntries = append(aliasEntries, e)
		} else {
			abbrEntries = append(abbrEntries, e)
		}
	}

	// Always emit alias definitions — aliases are not persistent across sessions.
	for _, e := range aliasEntries {
		fmt.Printf("alias %s='%s'\n", e.name, singleQuote(e.expansion))
	}

	// Diff abbr entries against current state, skipping if yaml is unchanged.
	hash := currentHash(data)
	if hash == cachedHash() {
		return
	}

	current := parseCurrentAbbrs()

	desiredAbbrMap := make(map[string]entry)
	for _, e := range abbrEntries {
		desiredAbbrMap[e.name] = e
	}

	// Erase abbreviations no longer in the desired state.
	for name := range current {
		if _, ok := desiredAbbrMap[name]; !ok {
			fmt.Printf("abbr erase %s\n", name)
		}
	}

	// Add or update abbreviations that are new or have changed.
	for _, e := range abbrEntries {
		cur, exists := current[e.name]
		if exists && cur.expansion == e.expansion && cur.kind == e.kind {
			continue
		}
		if exists {
			fmt.Printf("abbr erase %s\n", e.name)
		}
		if e.kind == entryGlobal {
			fmt.Printf("abbr -g %s='%s'\n", e.name, singleQuote(e.expansion))
		} else {
			fmt.Printf("abbr %s='%s'\n", e.name, singleQuote(e.expansion))
		}
	}

	updateCache(hash)
}
