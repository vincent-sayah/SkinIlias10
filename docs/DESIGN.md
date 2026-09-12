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

## Choix techniques

- Le fichier `eformarine.css` importe `public/assets/css/delos.css` avant les surcharges.
- Le skin conserve les composants standards ILIAS, ce qui limite les risques de regression fonctionnelle.
- Les surcharges ciblent la navigation, la barre haute, la barre laterale, le fil d'Ariane, les onglets, les boutons, les tableaux, les blocs, les formulaires, les messages, la page de connexion, les listes et les tuiles repository.
- La version `1.1.3` place le logo eForm Marine dans le bandeau haut gauche via `HeaderIcon.svg` et une version PNG horizontale optimisee pour l'en-tete.
- La version ne contient aucun override HTML UI. C'est volontaire : les templates HTML de carte et de layout peuvent modifier la bascule native liste/tuile et casser le positionnement des panneaux ILIAS.
- Le dossier `images` fournit des icones SVG `icon_*.svg` pour personnaliser les objets ILIAS courants : cours, categorie, groupe, dossier, fichier, test, forum, module, SCORM, exercice, wiki, blog, session, sondage, lien web et pool de questions.
- Les icones d'objets sont transparentes : en vue liste, ILIAS affiche seulement le pictogramme, sans carre bleu de fond.
- Les classes utilitaires `eformarine-banner`, `eformarine-brand` et `eformarine-callout` peuvent etre utilisees dans du contenu de page ILIAS si besoin.
