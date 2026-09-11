#!/usr/bin/env bash
set -u

ILIAS_ROOT="${1:-/var/www/html/ilias}"
SKIN_DIR="${ILIAS_ROOT}/Customizing/skin"
EFM_DIR="${SKIN_DIR}/eformarine"
EFM_TEMPLATE="${EFM_DIR}/template.xml"
EFM_CSS="${EFM_DIR}/eformarine/eformarine.css"

echo "== eFormarine / ILIAS skin diagnostic =="
echo "ILIAS root: ${ILIAS_ROOT}"
echo

if [ ! -d "${ILIAS_ROOT}" ]; then
    echo "ERROR: ILIAS root does not exist."
    exit 2
fi

echo "== Root check =="
for path in "components/ILIAS" "templates/default/template.xml" "templates/default/delos.css"; do
    if [ -e "${ILIAS_ROOT}/${path}" ]; then
        echo "OK  ${path}"
    else
        echo "MISS ${path}"
    fi
done
echo

echo "== Customizing skin folders =="
if [ -d "${SKIN_DIR}" ]; then
    find "${SKIN_DIR}" -maxdepth 2 -type d | sort
else
    echo "MISS ${SKIN_DIR}"
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
echo

echo "== Notes =="
echo "The 'other' row in ILIAS is not a real skin. It appears when at least one user is assigned to a missing style."
echo "If eFormarine is not listed, the skin files are usually not in the ILIAS root scanned by PHP."

