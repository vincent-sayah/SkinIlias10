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

Ou utilise le script fourni :

```bash
cd /tmp/SkinIlias10
bash install.sh /var/www/html/ilias
bash diagnose.sh /var/www/html/ilias
```

Si tu n'es pas certain du chemin exact d'ILIAS, utilise le mode automatique :

```bash
cd /tmp/SkinIlias10
bash diagnose.sh auto
bash install.sh auto
bash diagnose.sh auto
```

Le mode `auto` cherche une installation ILIAS sous `/var/www`, `/srv` et `/opt`. S'il trouve plusieurs installations, il affiche les chemins candidats et il faut relancer la commande avec le bon chemin.

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

La ligne `other` dans le tableau ILIAS n'est pas un skin installe. ILIAS l'affiche lorsqu'au moins un utilisateur est encore affecte a un style qui n'existe plus. Pour confirmer l'installation d'eFormarine :

```bash
cd /tmp/SkinIlias10
git pull
bash install.sh /var/www/html/ilias
bash diagnose.sh /var/www/html/ilias
```

Si le diagnostic indique `MISS components/ILIAS` ou `MISS templates/default/template.xml`, tu n'as pas donne la bonne racine ILIAS au script. Recherche alors la bonne racine :

```bash
bash /tmp/SkinIlias10/diagnose.sh auto
```

Si le diagnostic indique que les fichiers eFormarine sont presents mais que l'interface ne les affiche toujours pas, redemarre le service PHP-FPM et le serveur web, puis vide le cache ILIAS.

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
