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
    if ! ILIAS_ROOT="$(resolve_ilias_root "${ILIAS_ROOT_ARG}")"; then
        ILIAS_ROOT="${ILIAS_ROOT_ARG}"
    fi
fi

if [ ! -d "${ILIAS_ROOT}" ]; then
    echo "ILIAS root not found: ${ILIAS_ROOT}" >&2
    exit 1
fi

if [ -d "${ILIAS_ROOT}/public" ]; then
    ILIAS_WEB_ROOT="${ILIAS_ROOT}/public"
else
    ILIAS_WEB_ROOT="${ILIAS_ROOT}"
fi

SKIN_PARENT="${ILIAS_WEB_ROOT}/Customizing/skin"
BACKUP_PARENT="${ILIAS_WEB_ROOT}/Customizing/skin_backups"
SKIN_TARGET="${SKIN_PARENT}/eformarine"
LEGACY_SKIN_TARGET="${ILIAS_ROOT}/Customizing/skin/eformarine"

echo "ILIAS base root: ${ILIAS_ROOT}"
echo "ILIAS skin target: ${SKIN_TARGET}"

mkdir -p "${SKIN_PARENT}" "${BACKUP_PARENT}"

for old_backup in "${SKIN_PARENT}"/eformarine.bak.*; do
    if [ -e "${old_backup}" ]; then
        mv "${old_backup}" "${BACKUP_PARENT}/$(basename "${old_backup}")"
        echo "Moved old backup out of active skin folder: ${old_backup}"
    fi
done

if [ -e "${SKIN_TARGET}" ]; then
    BACKUP_TARGET="${BACKUP_PARENT}/eformarine.bak.$(date +%Y%m%d%H%M%S)"
    mv "${SKIN_TARGET}" "${BACKUP_TARGET}"
    echo "Existing eFormarine skin moved to ${BACKUP_TARGET}"
fi

cp -a "${SKIN_SOURCE}" "${SKIN_TARGET}"

if id "${WEB_USER}" >/dev/null 2>&1 && getent group "${WEB_GROUP}" >/dev/null 2>&1; then
    chown -R "${WEB_USER}:${WEB_GROUP}" "${SKIN_TARGET}"
elif id "${WEB_USER}" >/dev/null 2>&1; then
    chown -R "${WEB_USER}" "${SKIN_TARGET}"
fi

find "${SKIN_TARGET}" -type d -exec chmod 755 {} \;
find "${SKIN_TARGET}" -type f -exec chmod 644 {} \;

if [ "${ILIAS_WEB_ROOT}" != "${ILIAS_ROOT}" ] && [ -e "${LEGACY_SKIN_TARGET}" ]; then
    echo "Note: ${LEGACY_SKIN_TARGET} exists but ILIAS 10 uses ${ILIAS_WEB_ROOT}/Customizing/skin."
fi

echo "eFormarine installed in ${SKIN_TARGET}"
echo "Now run: bash diagnose.sh \"${ILIAS_ROOT}\""
