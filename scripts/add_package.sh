#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 /path/to/package.deb [repo_root]" >&2
  exit 1
fi

PACKAGE_PATH=$1
REPO_ROOT=${2:-"/workspace/ipconfig/apt-repo"}

if [[ ! -f "${PACKAGE_PATH}" ]]; then
  echo "Package not found: ${PACKAGE_PATH}" >&2
  exit 1
fi

reprepro -b "${REPO_ROOT}" includedeb stable "${PACKAGE_PATH}"
