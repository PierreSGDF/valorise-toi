#!/bin/bash
# ============================================================
# copy-icons.sh
# Copie les icônes SGDF depuis la bibliothèque source vers
# le dossier assets GitBook.
#
# Usage : bash scripts/copy-icons.sh /chemin/vers/01_generaux
# ============================================================

SOURCE_DIR="${1:-$HOME/Downloads/01_generaux}"
DEST_DIR="$(dirname "$0")/../.gitbook/assets/icons"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "❌ Répertoire source introuvable : $SOURCE_DIR"
  exit 1
fi

mkdir -p "$DEST_DIR"

# Copie une sélection d'icônes pertinentes pour la doc
CATEGORIES=(
  "01_croixscoute"
  "02_trefle"
  "03_lys"
  "09_bougie"
  "10_promesse"
  "16_montagne"
  "18_feu"
  "26_soleil"
  "30_arbre"
  "34_etoile"
  "35_paix"
  "38_coeur"
  "40_badenpowell"
)

for CAT in "${CATEGORIES[@]}"; do
  SRC="$SOURCE_DIR/$CAT"
  if [ -d "$SRC" ]; then
    mkdir -p "$DEST_DIR/$CAT"
    # Copie la première variation de chaque catégorie (_01 ou -01 selon le nommage)
    find "$SRC" \( -name "*_01.png" -o -name "*01.png" \) | head -1 | xargs -I{} cp {} "$DEST_DIR/$CAT/"
    echo "✅ $CAT"
  else
    echo "⚠️  Catégorie manquante : $CAT"
  fi
done

echo ""
echo "Icônes copiées dans : $DEST_DIR"
echo "Total : $(find "$DEST_DIR" -name '*.png' | wc -l | tr -d ' ') icônes"
