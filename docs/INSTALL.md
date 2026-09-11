# Installation du skin eFormarine sur ILIAS 10

## Installation rapide

Depuis le serveur ILIAS :

```bash
cd /tmp
git clone https://github.com/vincent-sayah/SkinIlias10.git

cd /var/www/html/ilias
mkdir -p Customizing/skin
cp -a /tmp/SkinIlias10/Customizing/skin/eformarine Customizing/skin/

chown -R apache:apache Customizing/skin/eformarine
find Customizing/skin/eformarine -type d -exec chmod 755 {} \;
find Customizing/skin/eformarine -type f -exec chmod 644 {} \;
```

Adapte `/var/www/html/ilias` si ton installation ILIAS est ailleurs.

## Activation dans ILIAS

1. Connecte-toi avec un compte administrateur.
2. Ouvre l'administration des styles systeme.
3. Active le skin `eFormarine`.
4. Choisis le style `eFormarine - Marine nationale`.
5. Definis-le comme style par defaut si tu veux l'appliquer a toute la plateforme.

Selon la traduction de ton interface, le menu peut se trouver dans `Administration > Presentation > Styles systeme` ou dans `Administration > Layout and Navigation > System Styles`.

## Si le skin n'apparait pas

```bash
cd /var/www/html/ilias
find Customizing/skin/eformarine -maxdepth 3 -type f | sort
```

Tu dois voir au minimum :

```text
Customizing/skin/eformarine/template.xml
Customizing/skin/eformarine/eformarine/eformarine.css
Customizing/skin/eformarine/eformarine/images/eformarine-mark.svg
```

Verifie aussi que le fichier XML est lisible par Apache/PHP-FPM, puis vide le cache ILIAS depuis l'administration.

## Mise a jour

```bash
cd /tmp/SkinIlias10
git pull

cd /var/www/html/ilias
if [ -e Customizing/skin/eformarine ]; then
  mv Customizing/skin/eformarine Customizing/skin/eformarine.bak.$(date +%Y%m%d%H%M%S)
fi
cp -a /tmp/SkinIlias10/Customizing/skin/eformarine Customizing/skin/
chown -R apache:apache Customizing/skin/eformarine
```

Ensuite, vide le cache ILIAS et recharge la page avec le cache navigateur ignore.
