# OpenCode Configuration

Dépôt de configuration OpenCode pour reproduction instantanée sur n'importe quel projet.

## Installation

Sur un nouveau projet, exécutez :

## Installation

### Linux / macOS

Sur un nouveau projet, exécutez :
```bash
git clone --depth 1 https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config && bash .tmp-opencode-config/apply-config.sh && rm -rf .tmp-opencode-config
```
Ou en plusieurs étapes :
```bash
git clone https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config
bash .tmp-opencode-config/apply-config.sh
rm -rf .tmp-opencode-config
```

### Windows

Sur un nouveau projet, exécutez :
```powershell
git clone --depth 1 https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config && .\tmp-opencode-config\apply-config.bat && rd /s /q .tmp-opencode-config
```
Ou en plusieurs étapes :
```powershell
git clone https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config
.\tmp-opencode-config\apply-config.bat
rd /s /q .tmp-opencode-config
```
git clone --depth 1 https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config && bash .tmp-opencode-config/apply-config.sh && rm -rf .tmp-opencode-config
```

Ou en plusieurs étapes :

```bash
git clone https://github.com/yannassoumou/opencode_config.git .tmp-opencode-config
bash .tmp-opencode-config/apply-config.sh
rm -rf .tmp-opencode-config
```

Le script :
1. Copie `opencode.jsonc` à la racine de votre projet
2. Copie `.opencode/` à la racine de votre projet
3. Demande confirmation avant d'écraser des fichiers existants
4. Supprime automatiquement le dossier temporaire après application

## Fichiers inclus

- `opencode.jsonc` — Configuration principale OpenCode
- `.opencode/oh-my-opencode.jsonc` — Configuration OhMyOpenCode
- `.opencode/.gitignore` — Exclut `node_modules/` et `bun.lock`

## Configuration actuelle

Modèle local : `local-llm/qwen35-moe-35b`
- Context: 131072 tokens
- Output: 32768 tokens

Modèle fallback : `local-llm/qwen3-coder-next`
- Context: 262144 tokens
- Output: 32768 tokens

API locale : `http://minisforum.tailfe1a8c.ts.net:8080/v1` (ou 1201 pour oh-my-opencode)

## Personnalisation

Après installation, vous pouvez modifier :
- `opencode.jsonc` — URL de l'API, paramètres des modèles
- `.opencode/oh-my-opencode.jsonc` — Agents, catégories, features

## License

MIT — Utilisez librement sur vos projets.
