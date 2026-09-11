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

- Le fichier `eformarine.css` importe `public/assets/css/delos.css` avant les surcharges.
- Le skin conserve les composants standards ILIAS, ce qui limite les risques de regression fonctionnelle.
- Les surcharges ciblent la navigation, la barre haute, la barre laterale, les boutons, les tableaux, les blocs, les formulaires, les messages, la page de connexion et les tuiles repository.
- Des overrides HTML UI ajoutent des classes dediees et une signature eForm Marine sur `standardpage`, `mainbar`, `metabar`, `breadcrumbs` et `card`.
- Le dossier `images` fournit des icones SVG `icon_*.svg` pour personnaliser les objets ILIAS courants : cours, categorie, groupe, dossier, fichier, test, forum, module, SCORM, exercice, wiki, blog, session, sondage, lien web et pool de questions.
- Les classes utilitaires `eformarine-banner`, `eformarine-brand` et `eformarine-callout` peuvent etre utilisees dans du contenu de page ILIAS si besoin.
