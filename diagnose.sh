#!/usr/bin/env bash
set -u

ILIAS_ROOT_ARG="${1:-/var/www/html/ilias}"
WEB_USER="${WEB_USER:-apache}"

find_ilias_roots() {
    for base in /var/www /srv /opt; do
        if [ -d "${base}" ]; then
            find "${base}" -maxdepth 7 -type f -path '*/templates/default/template.xml' -print 2>/dev/null
        fi
    done | sed 's#/templates/default/template.xml$##' | sort -u
}

resolve_ilias_root() {
    local input_root="$1"

    if [ -d "${input_root}/components/ILIAS" ] && [ -f "${input_root}/templates/default/template.xml" ]; then
        cd "${input_root}" && pwd
        return 0
    fi

    if [ -d "${input_root}/../components/ILIAS" ] && [ -f "${input_root}/../templates/default/template.xml" ]; then
        cd "${input_root}/.." && pwd
        return 0
    fi

    return 1
}

if [ "${ILIAS_ROOT_ARG}" = "auto" ]; then
    mapfile -t ILIAS_ROOT_CANDIDATES < <(find_ilias_roots)

    echo "== Candidate ILIAS roots =="
    if [ "${#ILIAS_ROOT_CANDIDATES[@]}" -eq 0 ]; then
        echo "none"
        echo
        echo "ERROR: no ILIAS root found under /var/www, /srv or /opt."
        exit 2
    fi

    printf '%s\n' "${ILIAS_ROOT_CANDIDATES[@]}"
    echo

    if [ "${#ILIAS_ROOT_CANDIDATES[@]}" -eq 1 ]; then
        ILIAS_ROOT="${ILIAS_ROOT_CANDIDATES[0]}"
    else
        echo "ERROR: several ILIAS roots were found."
        echo "Run again with the live root, for example:"
        echo "bash diagnose.sh ${ILIAS_ROOT_CANDIDATES[0]}"
        exit 2
    fi
else
    if ! ILIAS_ROOT="$(resolve_ilias_root "${ILIAS_ROOT_ARG}")"; then
        ILIAS_ROOT="${ILIAS_ROOT_ARG}"
    fi
fi

if [ -d "${ILIAS_ROOT}/public" ]; then
    ILIAS_WEB_ROOT="${ILIAS_ROOT}/public"
else
    ILIAS_WEB_ROOT="${ILIAS_ROOT}"
fi

SKIN_DIR="${ILIAS_WEB_ROOT}/Customizing/skin"
LEGACY_SKIN_DIR="${ILIAS_ROOT}/Customizing/skin"
EFM_DIR="${SKIN_DIR}/eformarine"
EFM_TEMPLATE="${EFM_DIR}/template.xml"
EFM_CSS="${EFM_DIR}/eformarine/eformarine.css"
EFM_UI_LAYOUT="${EFM_DIR}/eformarine/UI/Layout/tpl.standardpage.html"
EFM_HEADER_ICON="${EFM_DIR}/eformarine/images/logo/HeaderIcon.svg"
LEGACY_EFM_TEMPLATE="${LEGACY_SKIN_DIR}/eformarine/template.xml"

echo "== eFormarine / ILIAS skin diagnostic =="
echo "ILIAS base root: ${ILIAS_ROOT}"
echo "ILIAS web root:  ${ILIAS_WEB_ROOT}"
echo "Skin path used:  ${SKIN_DIR}"
echo

if [ ! -d "${ILIAS_ROOT}" ]; then
    echo "ERROR: ILIAS root does not exist."
    exit 2
fi

echo "== Root check =="
for path in "components/ILIAS" "components/ILIAS/Style/System/classes/Style/class.ilSystemStyleConfig.php" "templates/default/template.xml" "templates/default/delos.css"; do
    if [ -e "${ILIAS_ROOT}/${path}" ]; then
        echo "OK  ${path}"
    else
        echo "MISS ${path}"
    fi
done
echo

echo "== ILIAS 10 web root check =="
if [ "${ILIAS_WEB_ROOT}" != "${ILIAS_ROOT}" ]; then
    for path in "assets/css/delos.css" "Customizing"; do
        if [ -e "${ILIAS_WEB_ROOT}/${path}" ]; then
            echo "OK  public/${path}"
        else
            echo "MISS public/${path}"
        fi
    done
else
    echo "No public directory detected; using base root as web root."
fi
echo

echo "== ILIAS Customizing path in source =="
CONFIG_FILE="${ILIAS_ROOT}/components/ILIAS/Style/System/classes/Style/class.ilSystemStyleConfig.php"
if [ -f "${CONFIG_FILE}" ]; then
    grep -n "customizing_skin_path\\|Customizing/skin" "${CONFIG_FILE}" || true
else
    echo "MISS ${CONFIG_FILE}"
fi
echo

echo "== Customizing skin folders =="
if [ -d "${SKIN_DIR}" ]; then
    find "${SKIN_DIR}" -maxdepth 2 -type d | sort
else
    echo "MISS ${SKIN_DIR}"
fi
echo

echo "== Legacy or misplaced skin folder =="
if [ "${LEGACY_SKIN_DIR}" != "${SKIN_DIR}" ] && [ -d "${LEGACY_SKIN_DIR}" ]; then
    find "${LEGACY_SKIN_DIR}" -maxdepth 2 -type d | sort
    if [ -f "${LEGACY_EFM_TEMPLATE}" ] && [ ! -f "${EFM_TEMPLATE}" ]; then
        echo "LIKELY ISSUE: eFormarine is installed in ${LEGACY_SKIN_DIR}, but ILIAS 10 scans ${SKIN_DIR}."
    fi
else
    echo "none"
fi
echo

echo "== template.xml files =="
if [ -d "${SKIN_DIR}" ]; then
    find "${SKIN_DIR}" -maxdepth 2 -type f -name template.xml -print | sort | while read -r template; do
        echo "--- ${template}"
        sed -n '1,12p' "${template}"
    done
fi
echo

echo "== eFormarine expected files =="
if [ -f "${EFM_TEMPLATE}" ]; then
    echo "OK  ${EFM_TEMPLATE}"
else
    echo "MISS ${EFM_TEMPLATE}"
fi

if [ -f "${EFM_CSS}" ]; then
    echo "OK  ${EFM_CSS}"
else
    echo "MISS ${EFM_CSS}"
fi

if [ -f "${EFM_UI_LAYOUT}" ]; then
    echo "OK  ${EFM_UI_LAYOUT}"
else
    echo "MISS ${EFM_UI_LAYOUT}"
fi

if [ -f "${EFM_HEADER_ICON}" ]; then
    echo "OK  ${EFM_HEADER_ICON}"
else
    echo "MISS ${EFM_HEADER_ICON}"
fi
echo

echo "== eFormarine XML check =="
if [ -f "${EFM_TEMPLATE}" ]; then
    if command -v php >/dev/null 2>&1; then
        php -r '
        $file = $argv[1];
        libxml_use_internal_errors(true);
        $xml = simplexml_load_file($file);
        if (!$xml) {
            echo "ERROR XML parse failed\n";
            foreach (libxml_get_errors() as $error) {
                echo trim($error->message) . "\n";
            }
            exit(1);
        }
        echo "OK  XML parsed\n";
        echo "skin id: " . basename(dirname($file)) . "\n";
        echo "skin name: " . (string) $xml["name"] . "\n";
        foreach ($xml->children() as $style) {
            echo "style id: " . (string) $style["id"] . "\n";
            echo "style name: " . (string) $style["name"] . "\n";
            echo "css file: " . (string) $style["css_file"] . "\n";
        }
        ' "${EFM_TEMPLATE}" || true
    else
        echo "SKIP php command not available"
    fi
else
    echo "SKIP ${EFM_TEMPLATE} is missing"
fi
echo

echo "== eFormarine object icons =="
if [ -d "${EFM_DIR}/eformarine/images" ]; then
    find "${EFM_DIR}/eformarine/images" -maxdepth 2 -type f \( -name 'icon_*.svg' -o -name 'HeaderIcon.svg' \) -print | sort
else
    echo "MISS ${EFM_DIR}/eformarine/images"
fi
echo

echo "== Permissions visible to PHP user =="
if id "${WEB_USER}" >/dev/null 2>&1; then
    if command -v runuser >/dev/null 2>&1; then
        if runuser -u "${WEB_USER}" -- test -r "${EFM_TEMPLATE}" 2>/dev/null && runuser -u "${WEB_USER}" -- test -r "${EFM_CSS}" 2>/dev/null; then
            echo "OK  ${WEB_USER} can read eFormarine files"
        else
            echo "MISS ${WEB_USER} cannot read all eFormarine files"
        fi
    else
        echo "SKIP runuser command not available"
    fi
else
    echo "SKIP web user ${WEB_USER} not found; set WEB_USER=www-data if needed"
fi

if command -v getenforce >/dev/null 2>&1; then
    echo "SELinux: $(getenforce)"
fi
echo

echo "== Final interpretation =="
if [ ! -f "${EFM_TEMPLATE}" ] || [ ! -f "${EFM_CSS}" ]; then
    echo "eFormarine is not installed in the skin path used by ILIAS 10."
    echo "Install it with: bash install.sh \"${ILIAS_ROOT}\""
else
    echo "eFormarine files are present in the skin path used by ILIAS 10."
    echo "If ILIAS still does not show it, restart PHP-FPM/Apache and clear the ILIAS cache."
fi
echo

echo "== Notes =="
echo "The 'other' row in ILIAS is not a real skin. It appears when at least one user is assigned to a missing style."
echo "For ILIAS 10, custom skins must be in public/Customizing/skin."
