#!/bin/bash
set -e

# Déterminer le répertoire du script et le répertoire cible (parent)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

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

# Nettoyage du dossier temporaire
echo "🗑️  Nettoyage du dossier temporaire..."

# Détecter si on est dans un dossier temporaire
SCRIPT_PARENT="$(dirname "$SCRIPT_DIR")"
SCRIPT_BASENAME="$(basename "$SCRIPT_DIR")"

if [ "$SCRIPT_BASENAME" = ".tmp-opencode-config" ]; then
    # On est dans un dossier temporaire, on peut supprimer le parent
    cd "$TARGET_DIR"
    rm -rf "$SCRIPT_PARENT/.tmp-opencode-config"
    echo "✅ Dossier temporaire supprimé."
else
    echo "ℹ️  Le script n'est pas dans un dossier .tmp-opencode-config"
    echo "   Supprimez manuellement le dossier d'installation si nécessaire."
fi

echo ""
echo "🎉 Prêt ! Votre OpenCode config est maintenant configuré."
