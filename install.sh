#!/usr/bin/env bash
set -euo pipefail

ILIAS_ROOT_ARG="${1:-/var/www/html/ilias}"
WEB_USER="${WEB_USER:-apache}"
WEB_GROUP="${WEB_GROUP:-apache}"
SKIN_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Customizing/skin/eformarine"

find_ilias_roots() {
    for base in /var/www /srv /opt; do
        if [ -d "${base}" ]; then
            find "${base}" -maxdepth 7 -type f -path '*/templates/default/template.xml' -print 2>/dev/null
        fi
    done | sed 's#/templates/default/template.xml$##' | sort -u
}

if [ "${ILIAS_ROOT_ARG}" = "auto" ]; then
    mapfile -t ILIAS_ROOT_CANDIDATES < <(find_ilias_roots)

    if [ "${#ILIAS_ROOT_CANDIDATES[@]}" -eq 1 ]; then
        ILIAS_ROOT="${ILIAS_ROOT_CANDIDATES[0]}"
        echo "Detected ILIAS root: ${ILIAS_ROOT}"
    else
        echo "Could not select one ILIAS root automatically." >&2
        echo "Candidates found:" >&2
        printf '  %s\n' "${ILIAS_ROOT_CANDIDATES[@]:-none}" >&2
        echo "Run again with: bash install.sh /path/to/ilias" >&2
        exit 2
    fi
else
    ILIAS_ROOT="${ILIAS_ROOT_ARG}"
fi

SKIN_TARGET="${ILIAS_ROOT}/Customizing/skin/eformarine"

if [ ! -d "${ILIAS_ROOT}" ]; then
    echo "ILIAS root not found: ${ILIAS_ROOT}" >&2
    exit 1
fi

mkdir -p "${ILIAS_ROOT}/Customizing/skin"

if [ -e "${SKIN_TARGET}" ]; then
    BACKUP_TARGET="${SKIN_TARGET}.bak.$(date +%Y%m%d%H%M%S)"
    mv "${SKIN_TARGET}" "${BACKUP_TARGET}"
    echo "Existing eFormarine skin moved to ${BACKUP_TARGET}"
fi

cp -a "${SKIN_SOURCE}" "${SKIN_TARGET}"

if id "${WEB_USER}" >/dev/null 2>&1; then
    chown -R "${WEB_USER}:${WEB_GROUP}" "${SKIN_TARGET}"
fi

find "${SKIN_TARGET}" -type d -exec chmod 755 {} \;
find "${SKIN_TARGET}" -type f -exec chmod 644 {} \;

echo "eFormarine installed in ${SKIN_TARGET}"
echo "Now run: bash diagnose.sh \"${ILIAS_ROOT}\""
