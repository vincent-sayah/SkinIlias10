#!/usr/bin/env bash
set -euo pipefail

ILIAS_ROOT="${1:-/var/www/html/ilias}"
WEB_USER="${WEB_USER:-apache}"
WEB_GROUP="${WEB_GROUP:-apache}"
SKIN_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Customizing/skin/eformarine"
SKIN_TARGET="${ILIAS_ROOT}/Customizing/skin/eformarine"

if [ ! -d "${ILIAS_ROOT}" ]; then
    echo "ILIAS root not found: ${ILIAS_ROOT}" >&2
    exit 1
fi

mkdir -p "${ILIAS_ROOT}/Customizing/skin"
rm -rf "${SKIN_TARGET}"
cp -a "${SKIN_SOURCE}" "${SKIN_TARGET}"

if id "${WEB_USER}" >/dev/null 2>&1; then
    chown -R "${WEB_USER}:${WEB_GROUP}" "${SKIN_TARGET}"
fi

find "${SKIN_TARGET}" -type d -exec chmod 755 {} \;
find "${SKIN_TARGET}" -type f -exec chmod 644 {} \;

echo "eFormarine installed in ${SKIN_TARGET}"

