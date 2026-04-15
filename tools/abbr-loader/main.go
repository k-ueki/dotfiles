package main

import (
	"crypto/md5"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"gopkg.in/yaml.v3"
)

type entryType int

const (
	entryAbbr   entryType = iota // regular abbr
	entryAlias                   // shell alias
	entryGlobal                  // abbr -g
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

func updateCache(hash string) {
	dir := filepath.Dir(cacheFile())
	_ = os.MkdirAll(dir, 0755)
	_ = os.WriteFile(cacheFile(), []byte(hash), 0644)
}

// singleQuote wraps s in single quotes, escaping any embedded single quotes.
func singleQuote(s string) string {
	return strings.ReplaceAll(s, "'", `'\''`)
}

// escapeForAbbr escapes $ and backticks for the user-abbreviations file format.
func escapeForAbbr(s string) string {
	s = strings.ReplaceAll(s, `\`, `\\`)
	s = strings.ReplaceAll(s, `$`, `\$`)
	return s
}

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

// writeUserAbbreviations writes the abbreviation file directly,
// bypassing the slow `abbr` command.
func writeUserAbbreviations(entries []entry) error {
	var abbrEntries []entry
	for _, e := range entries {
		if e.kind != entryAlias {
			abbrEntries = append(abbrEntries, e)
		}
	}

	// Sort by name for stable output
	sort.Slice(abbrEntries, func(i, j int) bool {
		return abbrEntries[i].name < abbrEntries[j].name
	})

	var lines []string
	for _, e := range abbrEntries {
		escaped := escapeForAbbr(e.expansion)
		if e.kind == entryGlobal {
			lines = append(lines, fmt.Sprintf(`abbr -g "%s"="%s"`, e.name, escaped))
		} else {
			lines = append(lines, fmt.Sprintf(`abbr "%s"="%s"`, e.name, escaped))
		}
	}

	dir := filepath.Dir(userAbbrsFile())
	_ = os.MkdirAll(dir, 0755)
	return os.WriteFile(userAbbrsFile(), []byte(strings.Join(lines, "\n")+"\n"), 0644)
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

	// Always emit alias definitions to stdout (aliases are not persistent).
	for _, e := range desired {
		if e.kind == entryAlias {
			fmt.Printf("alias %s='%s'\n", e.name, singleQuote(e.expansion))
		}
	}

	// Skip file write if yaml is unchanged.
	hash := currentHash(data)
	if hash == cachedHash() {
		return
	}

	// Write user-abbreviations file directly (no eval overhead).
	if err := writeUserAbbreviations(desired); err != nil {
		fmt.Fprintf(os.Stderr, "error writing abbreviations: %v\n", err)
		os.Exit(1)
	}

	updateCache(hash)
}
