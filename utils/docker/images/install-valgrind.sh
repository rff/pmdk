#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2016-2019, Intel Corporation

#
# install-valgrind.sh - installs valgrind for persistent memory
#

set -e

install_upstream_from_distro() {
  if command -v dnf &>/dev/null ; then
    dnf install -y valgrind
  elif command -v apt-get &>/dev/null ; then
    apt-get install -y --no-install-recommends valgrind
  else
    return 1
  fi
}

install_custom-pmem_from_source() {
  git clone https://github.com/pmem/valgrind.git
  cd valgrind
  # valgrind v3.15 with pmemcheck
  git checkout c27a8a2f973414934e63f1e94bc84c0a580e3840
  ./autogen.sh
  ./configure
  make -j$(nproc)
  make -j$(nproc) install
  cd ..
  rm -rf valgrind
}

ARCH=$(uname -m)
case $ARCH in
  ppc64le) install_upstream_from_distro ;;
  *) install_custom-pmem_from_source ;;
esac
