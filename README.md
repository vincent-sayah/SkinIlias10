# SkinIlias10 - eFormarine

![Apercu du catalogue eFormarine](https://github.com/vincent-sayah/SkinIlias10/blob/main/preview/page_catalogue.png)
Skin `eformarine` pour ILIAS 10, inspire de l'identite visuelle Marine nationale et de la palette du site La Marine recrute.

Le depot contient un skin installable dans `public/Customizing/skin/eformarine` pour ILIAS 10, avec un style unique : `eFormarine - Marine nationale`.

La version `1.1.12` garde la structure native ILIAS et concentre la personnalisation sur le CSS et les icones : logo eForm Marine dans le bandeau haut gauche, barre laterale bleu marine avec accent rouge lisible, panneaux lateraux gris, barre haute sobre, fil d'Ariane, onglets, tuiles avec point rouge apres le titre, cartes repository, menus d'action non tronques, logo du ministere des Armees une seule fois au debut du footer ILIAS 10 et icones d'objets ILIAS d'origine recolorisees par element, sans fond colore en vue liste.

## Version stable

La version fonctionnelle stable du skin est `1.1.12`.

Etat visuel valide le `2026-09-13` sur la branche `main`. Le dernier reglage utilisateur conserve dans GitHub concerne les marques rouges des titres de tuiles. A partir de cet etat, la documentation peut evoluer, mais les fichiers du skin ne doivent plus etre modifies sans nouvelle demande explicite.

Reference du rendu valide : `08461c26cd321ae8c7cadc2e791c997a81150b2b`.

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
- pas d'override HTML UI actif, afin de ne pas perturber le layout, les tuiles ou la bascule liste/tuile d'ILIAS

La base Delos reste importee par `eformarine.css`, puis les surcharges eFormarine sont appliquees.

Sources principales :

- [ILIAS release_10 - System Styles README](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/components/ILIAS/Style/System/README.md)
- [ILIAS release_10 - ilSystemStyleConfig](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/components/ILIAS/Style/System/classes/Style/class.ilSystemStyleConfig.php)
- [ILIAS release_10 - ilSkinStyleContainer](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/components/ILIAS/Style/System/classes/Style/class.ilSkinStyleContainer.php)
- [ILIAS release_10 - template Delos](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/templates/default/template.xml)
- [ILIAS release_10 - System Styles documentation](https://github.com/ILIAS-eLearning/ILIAS/blob/release_10/templates/Readme.md)

## Installation rapide

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

Activation dans ILIAS :

1. Administration des styles systeme.
2. Activer le skin `eFormarine`.
3. Selectionner le style `eFormarine - Marine nationale`.
4. Definir le style comme style par defaut si necessaire.

La procedure detaillee est dans [docs/INSTALL.md](docs/INSTALL.md).

Si ILIAS affiche une ligne `other`, celle-ci ne correspond pas au skin eFormarine : ILIAS l'ajoute lorsqu'un utilisateur est affecte a un style qui n'existe plus. La commande `bash diagnose.sh /var/www/html/ilias` permet de verifier que les fichiers eFormarine sont bien au bon endroit.

Apres une mise a jour du skin, le cache ILIAS doit etre vide et la page doit etre rechargee sans cache navigateur. Lorsqu'une ancienne version a deja ete appliquee, `install.sh` doit etre relance afin de supprimer les anciens overrides HTML du skin installe.

## Apercu

Un apercu statique est disponible dans [preview/eformarine-preview.html](preview/eformarine-preview.html).

Il ne remplace pas un test dans ILIAS, mais il permet de visualiser rapidement la palette et les composants principaux.

Les changements de version sont resumes dans [CHANGELOG.md](CHANGELOG.md).
