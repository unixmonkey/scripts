#!/bin/bash
# Install a custom git version - https://git-scm.com
#
# To run this script on Codeship, add the following
# command to your project's setup commands:
# source /dev/stdin <<< "$(curl -sSL https://raw.githubusercontent.com/codeship/scripts/master/packages/git.sh)"
#
# Add the following environment variable to your project configuration
# (otherwise the default below will be used).
# * GIT_VERSION
#
GIT_VERSION=${GIT_VERSION:="2.11.1"}

GIT_DIR=${GIT_DIR:="$HOME/bin/git"}
CACHED_DOWNLOAD="${HOME}/cache/git-${GIT_VERSION}.zip"

wget --continue --output-document "${CACHED_DOWNLOAD}" "https://github.com/git/git/archive/v${GIT_VERSION}.zip"
unzip -q "${CACHED_DOWNLOAD}" -d "${HOME}/bin"
cd "${HOME}/bin/git-${GIT_VERSION}"
autoconf
./configure --prefix="${GIT_DIR}"
make
make install
cd -
export PATH="${GIT_DIR}/bin:${PATH}"

git --version | grep "${GIT_VERSION}"
