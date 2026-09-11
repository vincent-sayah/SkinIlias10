# SkinIlias10 - eFormarine

Skin `eformarine` pour ILIAS 10, inspire de l'identite visuelle Marine nationale.

Le depot contient un skin installable dans `public/Customizing/skin/eformarine` pour ILIAS 10, avec un style unique : `eFormarine - Marine nationale`.

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

- `public/Customizing/skin/<skin_id>/template.xml`
- `public/Customizing/skin/<skin_id>/<style_id>/<css_file>.css`
- style declare dans `template.xml` avec `id`, `name`, `image_directory`, `css_file`, `sound_directory` et `font_directory`

La base Delos reste importee par `eformarine.css`, puis les surcharges Marine nationale sont appliquees.

Sources principales :

- [ILIAS release_10 - System Styles README](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/components/ILIAS/Style/System/README.md)
- [ILIAS release_10 - ilSystemStyleConfig](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/components/ILIAS/Style/System/classes/Style/class.ilSystemStyleConfig.php)
- [ILIAS release_10 - ilSkinStyleContainer](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/components/ILIAS/Style/System/classes/Style/class.ilSkinStyleContainer.php)
- [ILIAS release_10 - template Delos](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/templates/default/template.xml)
- [ILIAS release_10 - System Styles documentation](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/templates/Readme.md)

## Installation

```bash
cd /tmp
git clone https://github.com/vincent-sayah/SkinIlias10.git

cd SkinIlias10
bash install.sh /var/www/html/ilias
bash diagnose.sh /var/www/html/ilias
```

Si le chemin ILIAS est incertain :

```bash
bash diagnose.sh auto
bash install.sh auto
```

Puis, dans ILIAS :

1. Administration des styles systeme.
2. Activer le skin `eFormarine`.
3. Selectionner le style `eFormarine - Marine nationale`.
4. Le definir comme style par defaut si necessaire.

La procedure detaillee est dans [docs/INSTALL.md](docs/INSTALL.md).

Si ILIAS affiche une ligne `other`, ce n'est pas le skin eFormarine : ILIAS l'ajoute quand un utilisateur est affecte a un style qui n'existe plus. Lance `bash diagnose.sh /var/www/html/ilias` pour verifier que les fichiers eFormarine sont bien au bon endroit.

## Apercu

Un apercu statique est disponible dans [preview/eformarine-preview.html](preview/eformarine-preview.html).

Il ne remplace pas un test dans ILIAS, mais il permet de visualiser rapidement la palette et les composants principaux.
