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

type abbr struct {
	name      string
	expansion string
	global    bool
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

// parseYAML reads the desired abbreviation state from a YAML file.
func parseYAML(data []byte) ([]abbr, error) {
	var doc yaml.Node
	if err := yaml.Unmarshal(data, &doc); err != nil {
		return nil, err
	}
	if doc.Kind == 0 {
		return nil, nil
	}

	var abbrs []abbr
	root := doc.Content[0]
	for i := 0; i < len(root.Content)-1; i += 2 {
		section := root.Content[i].Value
		entries := root.Content[i+1]
		global := section == "global"
		for j := 0; j < len(entries.Content)-1; j += 2 {
			abbrs = append(abbrs, abbr{
				name:      entries.Content[j].Value,
				expansion: entries.Content[j+1].Value,
				global:    global,
			})
		}
	}
	return abbrs, nil
}

// parseCurrentAbbrs reads the current abbreviation state from the zsh-abbr
// user-abbreviations file. Format: abbr [-g] name='expansion'
func parseCurrentAbbrs() map[string]abbr {
	result := make(map[string]abbr)
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
		global := false
		rest := parts[1:]
		if rest[0] == "-g" {
			global = true
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
		result[name] = abbr{name: name, expansion: expansion, global: global}
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

	hash := currentHash(data)
	if hash == cachedHash() {
		return
	}

	desired, err := parseYAML(data)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error: %v\n", err)
		os.Exit(1)
	}

	current := parseCurrentAbbrs()

	// Build a map of desired abbreviations for quick lookup.
	desiredMap := make(map[string]abbr)
	for _, a := range desired {
		desiredMap[a.name] = a
	}

	// Erase abbreviations that are no longer in the desired state.
	for name := range current {
		if _, ok := desiredMap[name]; !ok {
			fmt.Printf("abbr erase %s\n", name)
		}
	}

	// Add or update abbreviations that are new or have changed.
	for _, a := range desired {
		cur, exists := current[a.name]
		if exists && cur.expansion == a.expansion && cur.global == a.global {
			continue
		}
		// Erase first when updating an existing entry.
		if exists {
			fmt.Printf("abbr erase %s\n", a.name)
		}
		if a.global {
			fmt.Printf("abbr -g %s=%q\n", a.name, a.expansion)
		} else {
			fmt.Printf("abbr %s=%q\n", a.name, a.expansion)
		}
	}

	updateCache(hash)
}
