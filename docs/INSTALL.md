# Installation du skin eFormarine sur ILIAS 10

## Version stable

La version stable finale du skin est `1.1.12`.

Pour installer exactement le rendu valide avant les corrections de documentation finales, le depot peut etre fige sur le commit suivant :

```bash
git checkout 08461c26cd321ae8c7cadc2e791c997a81150b2b
```

Sinon, l'installation depuis `main` installe le meme skin stable, avec la documentation la plus recente.

## Installation rapide

Executer les commandes suivantes depuis le serveur ILIAS :

```bash
cd /tmp
git clone https://github.com/vincent-sayah/SkinIlias10.git

cd /var/www/html/ilias
mkdir -p public/Customizing/skin
cp -a /tmp/SkinIlias10/Customizing/skin/eformarine public/Customizing/skin/

chown -R apache:apache public/Customizing/skin/eformarine
find public/Customizing/skin/eformarine -type d -exec chmod 755 {} \;
find public/Customizing/skin/eformarine -type f -exec chmod 644 {} \;
```

Le chemin `/var/www/html/ilias` doit etre adapte si l'installation ILIAS utilise une autre racine. Pour ILIAS 10, le skin actif doit etre place dans `public/Customizing/skin`.

Le script fourni peut egalement etre utilise :

```bash
cd /tmp/SkinIlias10
bash install.sh /var/www/html/ilias
bash diagnose.sh /var/www/html/ilias
```

Si le chemin exact d'ILIAS n'est pas connu, le mode automatique peut etre utilise :

```bash
cd /tmp/SkinIlias10
bash diagnose.sh auto
bash install.sh auto
bash diagnose.sh auto
```

Le mode `auto` cherche une installation ILIAS sous `/var/www`, `/srv` et `/opt`. Si plusieurs installations sont detectees, les chemins candidats sont affiches et la commande doit etre relancee avec la racine ILIAS appropriee.

## Activation dans ILIAS

1. Se connecter avec un compte administrateur.
2. Ouvrir l'administration des styles systeme.
3. Activer le skin `eFormarine`.
4. Selectionner le style `eFormarine - Marine nationale`.
5. Definir le style comme style par defaut pour une application a l'ensemble de la plateforme.

Selon la traduction de l'interface, le menu peut se trouver dans `Administration > Presentation > Styles systeme` ou dans `Administration > Layout and Navigation > System Styles`.

## Si le skin n'apparait pas

```bash
cd /var/www/html/ilias
find public/Customizing/skin/eformarine -maxdepth 3 -type f | sort
```

Les fichiers suivants doivent etre presents au minimum :

```text
public/Customizing/skin/eformarine/template.xml
public/Customizing/skin/eformarine/eformarine/eformarine.css
public/Customizing/skin/eformarine/eformarine/images/eformarine-mark.svg
public/Customizing/skin/eformarine/eformarine/images/logo/HeaderIcon.svg
public/Customizing/skin/eformarine/eformarine/images/logo/logo_eformarine_header.png
public/Customizing/skin/eformarine/eformarine/images/logo/logo_eformarine_icon.png
public/Customizing/skin/eformarine/eformarine/images/logo/logo-ministere-armees-anciens-combattants-ilias.svg
```

Le fichier XML doit egalement etre lisible par Apache/PHP-FPM. Le cache ILIAS doit ensuite etre vide depuis l'administration.

La ligne `other` dans le tableau ILIAS n'est pas un skin installe. ILIAS l'affiche lorsqu'au moins un utilisateur est encore affecte a un style qui n'existe plus. Pour confirmer l'installation d'eFormarine :

```bash
cd /tmp/SkinIlias10
git pull
bash install.sh /var/www/html/ilias
bash diagnose.sh /var/www/html/ilias
```

Si le diagnostic indique `MISS components/ILIAS` ou `MISS templates/default/template.xml`, la racine ILIAS transmise au script n'est pas correcte. Le mode automatique permet alors de rechercher la racine attendue :

```bash
bash /tmp/SkinIlias10/diagnose.sh auto
```

Si le diagnostic indique que les fichiers eFormarine sont presents mais que l'interface ne les affiche toujours pas, le service PHP-FPM et le serveur web doivent etre redemarres, puis le cache ILIAS doit etre vide.

La version `1.1.12` ne doit afficher aucun template sous `public/Customizing/skin/eformarine/eformarine/UI`. Si `diagnose.sh` signale un override HTML, `install.sh` doit etre relance : il remplace le dossier complet du skin et supprime les anciens fichiers qui pouvaient casser la vue tuile/liste.

## Mise a jour

```bash
cd /tmp/SkinIlias10
git pull

cd /var/www/html/ilias
if [ -e public/Customizing/skin/eformarine ]; then
  mkdir -p public/Customizing/skin_backups
  mv public/Customizing/skin/eformarine public/Customizing/skin_backups/eformarine.bak.$(date +%Y%m%d%H%M%S)
fi
cp -a /tmp/SkinIlias10/Customizing/skin/eformarine public/Customizing/skin/
chown -R apache:apache public/Customizing/skin/eformarine
```

Ensuite, le cache ILIAS doit etre vide, PHP-FPM/Apache doit etre redemarre si necessaire, et la page doit etre rechargee avec le cache navigateur ignore. La version `1.1.12` supprime tous les anciens overrides HTML UI : `install.sh` doit donc etre relance, et non pas seulement le fichier CSS remplace.
