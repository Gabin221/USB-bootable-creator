# USB Bootable Creator

## Avertissement

Ce script efface **toutes les données** de la clé USB sélectionnée.
Vérifiez bien le périphérique avant de confirmer. L’auteur ne peut être tenu responsable en cas d’utilisation incorrecte.

## Résumé rapide
Créer une clé USB bootable facilement avec un script Bash interactif : choix du périphérique, ISO, progression en temps réel, sécurité.

## Fonctionnalités

- Affiche uniquement les **disques entiers** (sans partitions)  
- Colore la colonne **NAME** pour éviter les erreurs  
- Confirmation avant d’écraser une clé  
- Choix de l’ISO avec **complétion Tab** ou **boîte de dialogue graphique**  
- Affiche une **barre de progression** pendant la gravure (`pv`)  
- Éjecte automatiquement la clé si la gravure réussit  

## Prérequis

Installez les dépendances nécessaires :  

```bash
sudo apt install pv
```

## Installation

Clonez le dépôt et rendez le script exécutable :
```bash
git clone https://github.com/votre-pseudo/usb-bootable-creator.git
cd usb-bootable-creator
chmod +x usb-booter.sh
```

## Utilisation

Lancez simplement le script :
```bash
.\bootable_usb.sh
```

Ensuite :

- Le script liste les périphériques disponibles (les clés USB apparaissent avec TRAN=usb).
- Sélectionnez la clé à utiliser.
- Choisissez l’image ISO (complétion Tab ou via une boîte de dialogue si zenity est installé).
- Patientez pendant la gravure (barre de progression affichée).
- La clé est automatiquement éjectée à la fin.
