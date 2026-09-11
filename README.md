# SkinIlias10 - eFormarine

Skin `eformarine` pour ILIAS 10, inspire de l'identite visuelle Marine nationale.

Le depot contient un skin installable dans `Customizing/skin/eformarine` avec un style unique : `eFormarine - Marine nationale`.

## Structure

```text
Customizing/
  skin/
    eformarine/
      template.xml
      eformarine/
        eformarine.css
        eformarine.scss
        010-settings/
        images/
        fonts/
        sound/
docs/
preview/
install.sh
```

## Documentation utilisee

Le skin suit la structure lue dans la branche officielle `release_10` d'ILIAS :

- `Customizing/skin/<skin_id>/template.xml`
- `Customizing/skin/<skin_id>/<style_id>/<css_file>.css`
- style declare dans `template.xml` avec `id`, `name`, `image_directory`, `css_file`, `sound_directory` et `font_directory`

La base Delos reste importee par `eformarine.css`, puis les surcharges Marine nationale sont appliquees.

## Installation

```bash
cd /tmp
git clone https://github.com/vincent-sayah/SkinIlias10.git

cd SkinIlias10
bash install.sh /var/www/html/ilias
```

Puis, dans ILIAS :

1. Administration des styles systeme.
2. Activer le skin `eFormarine`.
3. Selectionner le style `eFormarine - Marine nationale`.
4. Le definir comme style par defaut si necessaire.

La procedure detaillee est dans [docs/INSTALL.md](docs/INSTALL.md).

## Apercu

Un apercu statique est disponible dans [preview/eformarine-preview.html](preview/eformarine-preview.html).

Il ne remplace pas un test dans ILIAS, mais il permet de visualiser rapidement la palette et les composants principaux.

