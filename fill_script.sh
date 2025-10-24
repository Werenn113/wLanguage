#!/bin/bash

# Paramètres
OUTPUT_FILE="script.txt"
NUM_LINES=100  # Nombre de lignes à générer

# Supprimer le fichier s'il existe déjà
> "$OUTPUT_FILE"

for i in $(seq 1 $NUM_LINES); do
    # Créer le numéro de ligne avec padding
    line_num=$(printf "%06d" $i)
    
    # Calculer combien d'octets il reste à remplir (128 - longueur du numéro - 2 pour ": " - 1 pour le newline)
    # 128 octets au total incluant le \n
    remaining=$((128 - ${#line_num} - 2 - 1))
    
    # Générer la ligne avec des 'X' pour remplir
    padding=$(printf '%*s' $remaining | tr ' ' 'X')
    
    # Écrire la ligne (le \n compte comme 1 octet)
    printf "%s: %s\n" "$line_num" "$padding" >> "$OUTPUT_FILE"
done

echo "Fichier $OUTPUT_FILE créé avec $NUM_LINES lignes de 128 octets chacune"