#!/bin/bash
# Script interactif pour rendre une clé USB bootable

set -euo pipefail

# Vérification des dépendances
if ! command -v pv &> /dev/null; then
    echo "Le paquet 'pv' n'est pas installé. Installe-le avec : sudo apt install pv"
    exit 1
fi

echo "=== Créateur de clé USB bootable ==="
echo

# 1. Lister uniquement les disques (pas les partitions)
echo "Voici la liste des périphériques disponibles (en bleu) :"
lsblk -d -o NAME,SIZE,MODEL,TRAN | awk 'NR==1 {print $0; next} {print "\033[1;34m"$1"\033[0m", $2, $3, $4}'
echo

# 2. Sélection de la clé
read -rp "Entrez le périphérique de votre clé USB (ex: sdb) : " usbdev
device="/dev/$usbdev"

# Confirmation
read -rp "ATTENTION : toutes les données sur $device seront effacées. Continuer ? (o/N) : " confirm
if [[ ! "$confirm" =~ ^[oOyY]$ ]]; then
    echo "Annulé."
    exit 1
fi

# 3. Choisir l'ISO
read -e -p "Entrez le chemin complet de l'image ISO à graver : " iso

if [[ ! -f "$iso" ]]; then
    echo "Fichier introuvable : $iso"
    exit 1
fi

# 4. Démonter le périphérique s’il est monté
echo "Démontage de la clé si nécessaire..."
sudo umount "${device}"* || true

# 5. Écriture avec barre de progression
echo "Gravure en cours... (ça peut prendre plusieurs minutes)"
sudo dd if="$iso" | pv | sudo dd of="$device" bs=4M conv=fsync status=none

# 6. Synchronisation
sync

# 7. Éjection uniquement si tout a réussi
sudo eject "$device"

echo
echo "L’écriture est terminée et la clé USB a été éjectée correctement."

