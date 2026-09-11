# Design eFormarine

## Intention

Le skin eFormarine habille ILIAS 10 avec une identite inspiree de la Marine nationale : bleu profond, blanc de lecture, touches or et rouge tres ponctuel pour les alertes.

## Palette

| Usage | Couleur |
| --- | --- |
| Bleu nuit principal | `#071526` |
| Bleu navigation | `#0a1f35` |
| Bleu action | `#12385c` |
| Bleu lien | `#174b78` |
| Bleu clair | `#eaf4fb` |
| Or accent | `#c9a646` |
| Rouge alerte | `#c9292e` |
| Texte | `#1b2634` |
| Fond | `#f6f8fb` |

## Choix techniques

- Le fichier `eformarine.css` importe `templates/default/delos.css` avant les surcharges.
- Le skin conserve les composants standards ILIAS, ce qui limite les risques de regression fonctionnelle.
- Les surcharges ciblent surtout la navigation, les boutons, les tableaux, les blocs, les formulaires, les messages et la page de connexion.
- Les classes utilitaires `eformarine-banner`, `eformarine-brand` et `eformarine-callout` peuvent etre utilisees dans du contenu de page ILIAS si besoin.

