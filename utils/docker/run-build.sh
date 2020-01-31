#!/usr/bin/env bash
#
# Copyright 2016-2019, Intel Corporation
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in
#       the documentation and/or other materials provided with the
#       distribution.
#
#     * Neither the name of the copyright holder nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#
# run-build.sh - is called inside a Docker container; prepares the environment
#                and starts a build of PMDK project.
#

set -e

# Prepare build environment
./prepare-for-build.sh

CHECK_RESULT=ok
PCHECK_RESULT=ok
PYCHECK_RESULT=ok

# Build all and run tests
JOBS=$(nproc)
JOBS=1
cd $WORKDIR
make -j${JOBS} check-license
make -j${JOBS} cstyle
make -j${JOBS}
make -j${JOBS} test
make -j${JOBS} pcheck TEST_BUILD=$TEST_BUILD ||  PCHECK_RESULT=fail
make -j${JOBS} check TEST_BUILD=$TEST_BUILD  ||   CHECK_RESULT=fail
make -j${JOBS} pycheck                       || PYCHECK_RESULT=fail

echo " pcheck=$PCHECK_RESULT"
echo "  check=$CHECK_RESULT"
echo "pycheck=$PYCHECK_RESULT"

[[ $CHECK_RESULT == ok && $PCHECK_RESULT == ok && $PYCHECK_RESULT == ok ]] || exit 1

make -j${JOBS} DESTDIR=/tmp source

# Create PR with generated docs
if [[ "$AUTO_DOC_UPDATE" == "1" ]]; then
	echo "Running auto doc update"
	./utils/docker/run-doc-update.sh
fi
