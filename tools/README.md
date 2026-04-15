# Tools

Source code for custom tools. Built binaries are placed in `bin/`.

## abbr-loader

Go tool that reads `zsh/abbr/abbr.yaml` and writes `~/.config/zsh-abbr/user-abbreviations` directly, bypassing the slow `abbr` command. Alias definitions are emitted to stdout for `eval`.

```sh
cd tools/abbr-loader
go build -o ../../bin/abbr-loader .
```
