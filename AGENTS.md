# AGENTS.md — OhMyOpenCode Configuration Repository

This repository provides instant reproduction of OpenCode configuration across any project.

## Purpose

Template repository that copies `opencode.jsonc` and `.opencode/` to target projects via `apply-config.sh` (Linux/macOS) or `apply-config.bat` (Windows).

---

## Build / Lint / Test Commands

**This is a configuration template repository with no build, lint, or test commands.**

- **No package.json scripts** in root (only `.opencode/package.json` with `@opencode-ai/plugin` dependency)
- **No test runner** configured (jest, vitest, etc.)
- **No linting** configured (no .eslintrc, .prettierrc, tsconfig.json)
- **No TypeScript** configuration present

To use this config on a new project:
```bash
# Linux/macOS
git clone --depth 1 https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config
bash .tmp-opencode-config/apply-config.sh
rm -rf .tmp-opencode-config

# Windows PowerShell
git clone --depth 1 https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config
.\tmp-opencode-config\apply-config.bat
rd /s /q .tmp-opencode-config
```

---

## Code Style Guidelines

**This repository contains no source code** — only configuration files. No coding style guidelines apply.

### Files Present

- `opencode.jsonc` — Main OpenCode configuration (model, provider, plugin settings)
- `.opencode/oh-my-opencode.jsonc` — OhMyOpenCode agent/category configuration
- `.opencode/package.json` — Plugin dependency only
- `.opencode/.gitignore` — Excludes `node_modules/` and `bun.lock`
- `apply-config.sh` / `apply-config.bat` — Deployment scripts
- `README.md` — Installation instructions

---

## Cursor / Copilot Rules

**No `.cursor/rules/` or `.cursorrules` files found.**  
**No `.github/copilot-instructions.md` found.**

---

## Key Configuration Details

### Models (Local LLM via llama.cpp)
- **Primary**: `qwen35-moe-35b` (262k context, 32k output)
- **Fallback**: `qwen3-coder-next` (262k context, 32k output)
- **Triage**: `nemotron-nano-4b` for quick tasks (git, writing, explore)

### API Endpoint
- `http://minisforum.tailfe1a8c.ts.net:8080/v1` (browser)
- `http://minisforum.tailfe1a8c.ts.net:1201/v1` (oh-my-opencode)

### Agents & Categories
- **Sisyphus** — Main orchestrator
- **Oracle** — Architecture consultation
- **Librarian/Explore** — Research agents (nano model)
- **Categories**: quick, unspecified-low/high, writing, git, debugging, optimization, code-review, visual-engineering

### Features Enabled
- Task system, skills, hooks, commands, git_master, comment_checker, runtime_fallback, hashline_edit, dynamic_context_pruning
