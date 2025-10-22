#!/bin/bash

# Nom du fichier de sortie
fichier="script.txt"

nb_lignes=100

for i in $(seq 1 $nb_lignes); do
    # Convertir le numéro en chaîne
    num="$i"
    # Calculer le reste pour atteindre 127 octets (128 - 1 pour le saut de ligne)
    reste=$((128 - ${#num} - 1))
    # Créer la ligne complète avec des tirets et ajouter le saut de ligne
    printf "%s%s\n" "$num" "$(printf '%*s' "$reste" | tr ' ' 'A')" >> "$fichier"
done
