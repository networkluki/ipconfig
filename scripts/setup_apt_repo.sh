#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT=${1:-"/workspace/ipconfig/apt-repo"}

mkdir -p "${REPO_ROOT}/conf"

if [[ ! -f "${REPO_ROOT}/conf/distributions" ]]; then
  cat <<'DIST' > "${REPO_ROOT}/conf/distributions"
Codename: stable
Suite: stable
Components: main
Architectures: amd64 source
SignWith: default
Description: Local APT repository for ipconfig
DIST
fi

if [[ ! -f "${REPO_ROOT}/conf/options" ]]; then
  cat <<'OPT' > "${REPO_ROOT}/conf/options"
verbose
basedir /workspace/ipconfig/apt-repo
OPT
fi

echo "Repository config ready in ${REPO_ROOT}."

echo "Next steps:"
cat <<'NEXT'
1) Ensure reprepro is installed:
   sudo apt-get update && sudo apt-get install -y reprepro
2) Add a .deb package:
   reprepro -b /workspace/ipconfig/apt-repo includedeb stable /path/to/package.deb
3) Serve the repo via a web server (e.g. nginx) or local file URL.
NEXT
