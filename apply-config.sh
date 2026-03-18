#!/bin/bash
set -e

# Déterminer le répertoire du script et le répertoire cible (parent)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$(dirname "$SCRIPT_DIR")"

echo "🔧 Applying OpenCode configuration to: $TARGET_DIR"
echo ""

# Vérifier si opencode.jsonc existe déjà
if [ -f "$TARGET_DIR/opencode.jsonc" ]; then
    echo "⚠️  opencode.jsonc existe déjà dans $TARGET_DIR"
    read -p "Voulez-vous l'écraser ? (o=oui, n=non, q=quitter): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[oO]$ ]]; then
        if [[ $REPLY =~ ^[qQ]$ ]]; then
            echo "❌ Opération annulée."
            exit 1
        else
            echo "⛔ Écrasement refusé. Configuration existante conservée."
            exit 0
        fi
    fi
fi

# Vérifier si .opencode/ existe déjà
if [ -d "$TARGET_DIR/.opencode" ]; then
    echo "⚠️  .opencode/ existe déjà dans $TARGET_DIR"
    read -p "Voulez-vous l'écraser ? (o=oui, n=non, q=quitter): " -n 1 -r
    echo ""
    
    if [[ ! $REPLY =~ ^[oO]$ ]]; then
        if [[ $REPLY =~ ^[qQ]$ ]]; then
            echo "❌ Opération annulée."
            exit 1
        else
            echo "⛔ Écrasement refusé. Configuration existante conservée."
            exit 0
        fi
    fi
fi

echo "📦 Copie des fichiers..."

# Copier opencode.jsonc à la racine
cp "$SCRIPT_DIR/opencode.jsonc" "$TARGET_DIR/"
echo "  ✓ opencode.jsonc"

# Copier .opencode/ en entier
cp -r "$SCRIPT_DIR/.opencode/" "$TARGET_DIR/"
echo "  ✓ .opencode/"

echo ""
echo "✅ OpenCode configuration appliquée avec succès !"
echo ""
echo "🗑️  Nettoyage du dossier temporaire..."

# Supprimer le dossier temporaire (le dossier où le script se trouve)
# Le script s'exécute depuis .tmp-opencode-config/, on supprime tout
rm -rf "$SCRIPT_DIR"

echo "✅ Dossier temporaire supprimé."
echo ""
echo "🎉 Prêt ! Votre OpenCode config est maintenant configuré."
