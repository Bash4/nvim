# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Neovim Configuration Guidelines

### Build/Lint/Test Commands
- Format Lua code: `stylua <filename>`
- Format PHP code: `vendor/bin/pint <filename>` (Laravel projects)
- Format JS/TS: `eslint_d --fix <filename>` or `prettier --write <filename>`
- Format Python: `black <filename>`
- Format Go: `gofmt -w <filename>`

### Code Style Guidelines
- Indentation: 2 spaces (shiftwidth=2)
- Tabs: Expand to spaces (expandtab=true)
- Tab size: 4 spaces (tabstop=4)
- Line numbers enabled (number=true)

### Naming Conventions
- Use snake_case for Lua variables and functions
- Use meaningful names for plugins and configurations
- Group related plugins in separate files under lua/plugins/

### Organization
- Core settings in lua/owls/setup.lua
- Keymaps in lua/owls/remap.lua
- Plugin configurations in lua/plugins/
- LazyVim for plugin management