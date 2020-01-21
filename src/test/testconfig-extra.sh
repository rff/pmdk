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

#
# src/test/testconfig.sh -- configuration for local and remote unit tests
#

#TEST_BASE_DIR=${PWD}/../test.d
TEST_BASE_DIR=${HOME}/ws/t/pmem.mount/test.d

#
# 1) *** LOCAL CONFIGURATION ***
#
# The first part of the file tells the script unittest/unittest.sh
# which file system locations are to be used for local testing.
#

#
# Appended to PMEM_FS_DIR and NON_PMEM_FS_DIR to test PMDK with
# file path longer than 255 characters.
#
# LONGDIR="LoremipsumdolorsitametconsecteturadipiscingelitVivamuslacinianibhattortordictumsollicitudinNullamvariusvestibulumligulaetegestaselitsemperidMaurisultriciesligulaeuipsumtinciduntluctusMorbimaximusvariusdolorid"
# DIRSUFFIX="$LONGDIR/$LONGDIR/$LONGDIR/$LONGDIR/$LONGDIR"
#
# For tests that require true persistent memory, set the path to a directory
# on a PMEM-aware file system here. Uncomment this line if there's an
# actual persistent memory available on this system.
# Note that PMEM_FS_DIR is intended mostly to test codepaths where
# pmem_persist() is used for flushing data to persistence.  For now, there is
# no file system on Linux that fully supports pmem_persist(), so even in case
# of DAX-enabled file systems (like ext4), PMDK would behave as for non-PMEM
# file system and would still use pmem_msync().
# You may change this behavior by setting PMEM_FS_DIR_FORCE_PMEM (see below).
# To fully test the PMEM codepaths it is strongly recommended to configure
# DEVICE_DAX_PATH as well.
#
PMEM_FS_DIR=${TEST_BASE_DIR}/pmem-fs.d

#
# For tests that require true a non-persistent memory aware file system (i.e.
# to verify something works on traditional page-cache based memory-mapped
# files) set the path to a directory on a normal file system here.
#
NON_PMEM_FS_DIR=${TEST_BASE_DIR}/non-pmem-fs.d

mkdir -p "${PMEM_FS_DIR}" "${NON_PMEM_FS_DIR}"

#
# If you don't have real PMEM or PMEM emulation set up and/or the filesystem
# does not support MAP_SYNC flag, but still want to test PMEM codepaths
# uncomment this line. It will set PMEM_IS_PMEM_FORCE to 1 for tests that
# require pmem.
#
# Setting this flag to 1, if the PMEM_FS_DIR filesystem supports MAP_SYNC will
# cause an error. This flag cannot be used with filesystems which support
# MAP_SYNC because it would prevent from testing the target PMEM codepaths.
# If you want to ignore this error set the value to 2.
#
PMEM_FS_DIR_FORCE_PMEM=1

#
# For tests that require raw dax devices without a file system, set a path to
# those devices in an array format. For most tests one device is enough, but
# some might require more.
#
# For big sizes of DAX devices, some tests ran against Valgrind might fail due
# to length of anonymous mmap and Valgrind limitations. Maximum possible length
# is being calculated each time testconfig.sh changes. Tests which require more
# than detected maximum possible length are skipped.
#
# It is required to have R/W access to these devices and at least RO access
# to all of the following resource files (containing physical addresses)
# of NVDIMM devices (only root can read them by default):
#
# /sys/bus/nd/devices/ndbus*/region*/resource
# /sys/bus/nd/devices/ndbus*/region*/dax*/resource
#
# Note: some tests require write access to '/sys/bus/nd/devices/region*/deep_flush'.
#
#DEVICE_DAX_PATH=(/dev/dax0.0 /dev/dax1.0)

#
# Overwrite default test type:
# check (default), short, medium, long, all
# where: check = short + medium; all = short + medium + long
#
#TEST_TYPE=check

#
# Overwrite available build types:
# debug, nondebug, static-debug, static-nondebug, all (default)
#
#TEST_BUILD=all
TEST_BUILD="debug nondebug"

#
# Overwrite available filesystem types:
# pmem, non-pmem, any, none, all (default)
#
#TEST_FS=all

#
# Overwrite default timeout
# (floating point number with an optional suffix: 's' for seconds (the default),
# 'm' for minutes, 'h' for hours or 'd' for days)
#
TEST_TIMEOUT=3m

#
# To display execution time of each test
#
TM=1

#
# Normally the first failed test terminates the test run. If KEEP_GOING
# is set, continues executing all tests. If any tests fail, once all tests
# have completed reports number of failures, lists failed tests and exits
# with error status.
#
KEEP_GOING=y

#
# This option works only if KEEP_GOING=y, then if CLEAN_FAILED is set
# all data created by test is removed on test failure.
#
CLEAN_FAILED=y

#
# Changes logging level. Possible values:
# 0 - silent (only error messages)
# 1 - normal (above + SETUP + START + DONE + PASS + important SKIP messages)
# 2 - verbose (above + all SKIP messages + stdout from test binaries)
#
#UNITTEST_LOG_LEVEL=1
UNITTEST_LOG_LEVEL=0

#
# Test against installed libraries, NOT the one built in tree.
# Note that these variable won't affect tests that link statically. You should
# disabled them using TEST_BUILD variable.
#
#PMDK_LIB_PATH_NONDEBUG=/usr/lib/x86_64-linux-gnu/
#PMDK_LIB_PATH_DEBUG=/usr/lib/x86_64-linux-gnu/pmdk_dbg

#
# Tests using the 'sudo' command can be potentially very harmful,
# so they have to be enabled deliberately.
#
#ENABLE_SUDO_TESTS=y

#
# Enable and select the type of tests for code handling bad blocks.
# Options: nfit_test, real_pmem, none (do not run, default).
#
# Running tests on emulated memory ('nfit test' option) requires 'nfit_test'
# kernel module to be present in the system.
# See https://github.com/pmem/ndctl#unit-tests
#
# If the 'real_pmem' option is enabled, tests are run on real hardware
# provided through PMEM_FS_DIR or DEVICE_DAX_PATH config fields.
#
# The tests use 'sudo' command many times and, in case of tests on
# emulated memory, insert the 'nfit_test' kernel module, so they can be
# considered as POTENTIALLY DANGEROUS and have to be explicitly enabled.
# Enable them ONLY IF you are sure you know what you are doing.
#
# As of kernel 4.20, the nfit-test module causes kernel oops whenever a devdax
# namespace is created and then accessed for the first time. This causes several
# of badblock-related unit tests to fail.
#
# BADBLOCK_TEST_TYPE=none

#
# 2) *** REMOTE CONFIGURATION ***
#
# The second part of the file tells the script unittest/unittest.sh
# which remote nodes and their file system locations are to be used
# for remote testing.
#

#
# Addresses of nodes should be defined as an array:
#
#    NODE[index]=[<user>@]<host-name-or-IP>
#
# The remote account must be set up for automated ssh authentication.
# The remote user's login shell must be bash.
#
#NODE[0]=127.0.0.1
#NODE[1]=user1@host1
#NODE[2]=user2@host2
NODE[0]=127.0.0.1
NODE[1]=127.0.0.1
NODE[2]=127.0.0.1
NODE[3]=127.0.0.1

#
# Addresses of interfaces which the remote nodes
# shall communicate on should be defined as an array:
#
#    NODE_ADDR[index]=[<user>@]<host-name-or-IP>
#
#NODE_ADDR[0]=192.168.0.1
#NODE_ADDR[1]=192.168.0.2
#NODE_ADDR[2]=192.168.0.3
NODE_ADDR[0]=127.0.0.1
NODE_ADDR[1]=127.0.0.1
NODE_ADDR[2]=127.0.0.1
NODE_ADDR[3]=127.0.0.1

#
# Working directories on remote nodes (they will be created)
#
#NODE_WORKING_DIR[0]=/remote/dir0
#NODE_WORKING_DIR[1]=/remote/dir1
#NODE_WORKING_DIR[2]=/remote/dir2
NODE_WORKING_DIR[0]=${TEST_BASE_DIR}/node0
NODE_WORKING_DIR[1]=${TEST_BASE_DIR}/node1
NODE_WORKING_DIR[2]=${TEST_BASE_DIR}/node2
NODE_WORKING_DIR[3]=${TEST_BASE_DIR}/node3

#
# NODE_LD_LIBRARY_PATH variable for each remote node
#
#NODE_LD_LIBRARY_PATH[0]=/usr/local/lib
#NODE_LD_LIBRARY_PATH[1]=/usr/local/lib
#NODE_LD_LIBRARY_PATH[2]=/usr/local/lib
#

#
# NODE_DEVICE_DAX_PATH variable for each remote node which
# can be used to specify path to multiple device daxes on remote node.
#
# All remote tests assume the master replica is present on a node of index 1.
# So the size of device dax on the node of index 1 should not be bigger than
# a size of device dax devices on other nodes.
#
#NODE_DEVICE_DAX_PATH[0]="/dev/dax0.0 /dev/dax1.0"
#NODE_DEVICE_DAX_PATH[1]="/dev/dax0.0 /dev/dax1.0"
#NODE_DEVICE_DAX_PATH[2]="/dev/dax0.0"
#NODE_DEVICE_DAX_PATH[3]="/dev/dax0.0"

#
# NODE_ENV variable for setting environment variables on specified nodes
#
#NODE_ENV[0]="VAR=1"
#NODE_ENV[1]="VAR=\$VAR:1"
#NODE_ENV[2]=""
NODE_ENV[0]="PMEM_IS_PMEM_FORCE=1"
NODE_ENV[1]="PMEM_IS_PMEM_FORCE=1"
NODE_ENV[2]="PMEM_IS_PMEM_FORCE=1"
NODE_ENV[3]="PMEM_IS_PMEM_FORCE=1"

#
# RPMEM_VALGRIND_ENABLED variable enables valgrind rpmem tests
# Valgrind rpmem tests require libibverbs and librdmacm compiled with valgrind
# support.
#
#RPMEM_VALGRIND_ENABLED=y

#
# Overwrite available providers:
# verbs, sockets, all (default)
#
#TEST_PROVIDERS=all
TEST_PROVIDERS=sockets

#
# Overwrite available persistency methods:
# GPSPM, APM, all (default)
#
#TEST_PMETHODS=all
