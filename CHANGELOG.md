# Changelog eFormarine

## 1.1.12 - stable finale

Date de validation : `2026-09-13`

Etat stable final du skin `eformarine` pour ILIAS 10.

- Habillage inspire de l'identite Marine nationale et de la palette La Marine recrute.
- Logo eForm Marine dans le bandeau haut gauche.
- Barre laterale bleu marine avec accent rouge et lisibilite corrigee au survol.
- Panneaux lateraux gris, y compris les panneaux ouverts depuis Administration.
- Bandeau haut, fil d'Ariane, onglets, boutons, tableaux, formulaires, messages, tuiles et listes repository personnalises.
- Vue liste conservee sobrement, avec pictogrammes d'objets sans fond colore.
- Tuiles personnalisees avec marque rouge finale apres le titre.
- Icones d'objets ILIAS d'origine recolorisees en bleu et rouge par parties.
- Logo du ministere des Armees affiche une seule fois au debut du footer ILIAS 10.
- Aucun override HTML UI actif, afin de conserver le comportement natif liste/tuile d'ILIAS.

Reference du rendu valide : `08461c26cd321ae8c7cadc2e791c997a81150b2b`.

## Notes de maintenance

- Le fichier charge par ILIAS est `Customizing/skin/eformarine/eformarine/eformarine.css`.
- Le fichier `_eformarine-overrides.scss` doit rester synchronise avec le contenu de `eformarine.css` apres les deux premieres lignes.
- Toute evolution future du rendu doit etre faite dans une nouvelle version, sans modifier retrospectivement cette version stable.
