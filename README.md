# OpenCode Configuration

Dépôt de configuration OpenCode pour reproduction instantanée sur n'importe quel projet.

## Installation

### Linux / macOS

Sur un nouveau projet, exécutez :
```bash
git clone --depth 1 https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config && bash .tmp-opencode-config/apply-config.sh
```

Ou en plusieurs étapes :
```bash
git clone https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config
bash .tmp-opencode-config/apply-config.sh
```

### Windows (PowerShell)

Sur un nouveau projet, exécutez :
```powershell
git clone --depth 1 https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config ; .\tmp-opencode-config\apply-config.bat
```

Ou en plusieurs étapes :
```powershell
git clone https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config
.\tmp-opencode-config\apply-config.bat
```

## Ce que fait le script

1. ✅ Copie `opencode.jsonc` à la racine de votre projet
2. ✅ Copie `.opencode/` à la racine de votre projet
3. ✅ Copie `.qwen/` à la racine de votre projet (config Qwen Code)
4. ⚠️  Demande confirmation avant d'écraser des fichiers existants
5. 🗑️  Supprime automatiquement le dossier `.tmp-opencode-config/` après application

## Fichiers inclus

- `opencode.jsonc` — Configuration principale OpenCode
- `.opencode/` — Dossier de configuration OhMyOpenCode (contient `oh-my-opencode.jsonc`, `package.json`, etc.)
- `.qwen/` — Dossier de configuration Qwen Code (contient `settings.json`)

## Configuration actuelle

- **Modèle principal** : `local-llm/qwen35-moe-35b` (262k context, 32k output)
- **Modèle fallback** : `local-llm/qwen3-coder-next` (262k context, 32k output)
- **Modèle triage** : `local-llm/nemotron-nano-4b` (pour tâches rapides)

API locale : `http://minisforum.tailfe1a8c.ts.net:8080/v1` (ou 1201 pour oh-my-opencode)

## Personnalisation

Après installation, vous pouvez modifier :
- `opencode.jsonc` — URL de l'API, paramètres des modèles
- `.opencode/oh-my-opencode.jsonc` — Agents, catégories, features

## License

MIT — Utilisez librement sur vos projets.
