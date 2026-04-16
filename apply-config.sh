#!/bin/bash
set -e

# Déterminer le répertoire du script et le répertoire cible (parent)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Temp folder cleanup:
# Typical usage is running this script from a clone directory named `.tmp-opencode-config/`.
# This script uses `set -e`, so any early `exit`/failure can skip the manual cleanup block.
# We ensure cleanup always runs on exit via a trap.
TMP_INSTALL_DIR=""
if [[ "$(basename "$SCRIPT_DIR")" == ".tmp-opencode-config" ]]; then
    TMP_INSTALL_DIR="$SCRIPT_DIR"
fi

cleanup() {
    # Only remove the temp clone folder when it matches the expected name.
    if [[ -n "$TMP_INSTALL_DIR" && -d "$TMP_INSTALL_DIR" ]]; then
        # Avoid deleting the directory we're currently in.
        if [[ -n "${TARGET_DIR:-}" && "$TARGET_DIR" != "$TMP_INSTALL_DIR" ]]; then
            cd "$TARGET_DIR" 2>/dev/null || true
        fi
        rm -rf -- "$TMP_INSTALL_DIR" 2>/dev/null || true
    fi
}

trap cleanup EXIT INT TERM

echo "🔧 Applying OpenCode configuration to: $TARGET_DIR"
echo ""

# Helper function to ask for overwrite permission
ask_overwrite() {
    local item="$1"
    read -p "⚠️  $item existe déjà dans $TARGET_DIR. Voulez-vous l'écraser ? (o=oui, n=non, q=quitter): " -n 1 -r
    echo ""

    if [[ $REPLY =~ ^[oO]$ ]]; then
        return 0
    elif [[ $REPLY =~ ^[qQ]$ ]]; then
        echo "❌ Opération annulée."
        exit 1
    else
        echo "⛔ Écrasement refusé. Configuration existante conservée."
        exit 0
    fi
}

# Vérifier si opencode.jsonc existe déjà
if [ -f "$TARGET_DIR/opencode.jsonc" ]; then
    ask_overwrite "opencode.jsonc"
fi

# Vérifier si .opencode/ existe déjà
if [ -d "$TARGET_DIR/.opencode" ]; then
    ask_overwrite ".opencode/"
fi

echo "📦 Copie des fichiers..."

# Copier opencode.jsonc à la racine
cp "$SCRIPT_DIR/opencode.jsonc" "$TARGET_DIR/"
echo "  ✓ opencode.jsonc"

# Copier .opencode/ en entier
if [ -d "$TARGET_DIR/.opencode" ]; then
    rm -rf "$TARGET_DIR/.opencode"
fi
cp -r "$SCRIPT_DIR/.opencode/" "$TARGET_DIR/"
echo "  ✓ .opencode/"

# Copier .qwen/ en entier (config Qwen Code)
if [ -d "$TARGET_DIR/.qwen" ]; then
    rm -rf "$TARGET_DIR/.qwen"
fi
cp -r "$SCRIPT_DIR/.qwen/" "$TARGET_DIR/"
echo "  ✓ .qwen/"

echo ""
echo "✅ OpenCode configuration appliquée avec succès !"
echo ""

echo ""
echo "🎉 Prêt ! Votre OpenCode config est maintenant configuré."
