#
# Copyright 2019, Intel Corporation
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

 LONGDIR="LoremipsumdolorsitametconsecteturadipiscingelitVivamuslacinianibhattortordictumsollicitudinNullamvariusvestibulumligulaetegestaselitsemperidMaurisultriciesligulaeuipsumtinciduntluctusMorbimaximusvariusdolorid"
DIRSUFFIX="$LONGDIR/$LONGDIR/$LONGDIR/$LONGDIR/$LONGDIR"
# This is run inside (pmdk-root)/src/test
#PMEM_FS_DIR=${PWD}/pmem-test-dir
#NON_PMEM_FS_DIR=${PWD}/pmem-test-dir
PMEM_FS_DIR=/mnt/pmem/raoni-pmdk-test-dir
NON_PMEM_FS_DIR=/mnt/pmem/raoni-pmdk-test-dir
PMEM_FS_DIR_FORCE_PMEM=1
TEST_BUILD="debug nondebug"
TM=1
KEEP_GOING=y
# We alread have the output log from buildbot.
CLEAN_FAILED=y
UNITTEST_LOG_LEVEL=0
# A hack to make sure the directories exist. This works because this file is
# sourced in a bash script.
mkdir -p "${PMEM_FS_DIR}" "${NON_PMEM_FS_DIR}"
