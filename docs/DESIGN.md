# Design eFormarine

## Intention

Le skin eFormarine habille ILIAS 10 avec une identite inspiree de La Marine recrute : bleu institutionnel tres sombre, surfaces blanches, accent rouge franc et typographies proches de Marianne/Anisette quand elles sont disponibles sur le poste.

## Palette

| Usage | Couleur |
| --- | --- |
| Bleu nuit principal | `#001b39` |
| Bleu navigation | `#071f41` |
| Bleu action | `#0b2b57` |
| Bleu lien | `#173f70` |
| Bleu secondaire | `#2a347b` |
| Bleu clair | `#edf3fa` |
| Rouge action | `#d60725` |
| Rouge hover | `#b00020` |
| Texte | `#172033` |
| Fond | `#f6f8fb` |
| Panneaux lateraux | `#eef2f6` |

## Choix techniques

- Le fichier `eformarine.css` importe `public/assets/css/delos.css` avant les surcharges.
- Le skin conserve les composants standards ILIAS, ce qui limite les risques de regression fonctionnelle.
- Les surcharges ciblent la navigation, la barre haute, la barre laterale, le fil d'Ariane, les onglets, les boutons, les tableaux, les blocs, les formulaires, les messages, la page de connexion, les listes et les tuiles repository.
- La version `1.1.11` place le logo eForm Marine dans le bandeau haut gauche via `HeaderIcon.svg` et une version PNG horizontale optimisee pour l'en-tete.
- La barre laterale conserve l'accent rouge au survol, avec textes et icones forces en blanc pour rester lisibles.
- Les panneaux ouverts depuis la barre laterale, y compris Administration, utilisent un fond gris clair avec texte fonce.
- La version ne contient aucun override HTML UI. C'est volontaire : les templates HTML de carte et de layout peuvent modifier la bascule native liste/tuile et casser le positionnement des panneaux ILIAS.
- Le dossier `images` fournit des icones SVG `icon_*.svg` issues des pictogrammes ILIAS 10 Delos d'origine. Les pictos principaux sont recolorises par element : cours avec tableau bleu et trepied rouge, categorie avec ombre bleue, face avant blanche et contour rouge, fichier bleu avec fleche rouge, modules ILIAS/HTML/SCORM avec livre bleu et traits rouges, forum avec grande bulle bleue et petite bulle rouge, groupe d'objets avec premiere barre et points rouges, plus les autres objets courants ajoutes en bleu/rouge.
- Les icones d'objets sont transparentes : en vue liste, ILIAS affiche seulement le pictogramme, sans carre bleu de fond.
- Les titres principaux d'objet et les titres de tuiles recoivent automatiquement un petit point rouge final serre contre le texte.
- Le footer ILIAS 10 affiche le bloc-marque du ministere des Armees depuis `images/logo/logo-ministere-armees-anciens-combattants-ilias.svg`.
- Les classes utilitaires `eformarine-banner`, `eformarine-brand` et `eformarine-callout` peuvent etre utilisees dans du contenu de page ILIAS si besoin.
