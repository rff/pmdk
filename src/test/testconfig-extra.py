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
# src/test/testconfig.py -- configuration for local and remote unit tests
#

import pathlib

# testdir = pathlib.Path.cwd() / 'pmem-test-dir'
test_base_dir = pathlib.Path.home() / 'ws/t/pmem.mount/test.d'
page_fs_dir = test_base_dir / 'page-fs.d'
cacheline_fs_dir = test_base_dir / 'cacheline-fs.d'
byte_fs_dir = test_base_dir / 'byte-fs.d'
pmem_fs_dir = test_base_dir / 'pmem-fs.d'
non_pmem_fs_dir = test_base_dir / 'non-pmem-fs.d'
page_fs_dir.mkdir(parents=True, exist_ok=True)
cacheline_fs_dir.mkdir(parents=True, exist_ok=True)
byte_fs_dir.mkdir(parents=True, exist_ok=True)
pmem_fs_dir.mkdir(parents=True, exist_ok=True)
non_pmem_fs_dir.mkdir(parents=True, exist_ok=True)

config = {
    #
    # 1) *** LOCAL CONFIGURATION ***
    #
    # The first part of the file tells the test framework
    # which file system locations are to be used for local testing.
    #
    #
    # Set logging level. Possible values:
    # 0 - silent (only error messages)
    # 1 - normal (above + SETUP + START + DONE + PASS + SKIP messages)
    # 2 - verbose (above + stdout from test binaries)
    #

    # 'unittest_log_level': 1,
    'unittest_log_level': 1,

    #
    # For tests that require filesystem with page granularity, set the
    # path to a directory on a filesystem with such granularity.
    # This line may stay commented out if there's no such filesystem
    # available on your system.
    #

    # 'page_fs_dir': '/tmp',
    'page_fs_dir': page_fs_dir,

    #
    # Enforce that the library will act in accordance with
    # page granularity, even if the underlying filesystem is not page
    # granular.
    #

    'force_page': False,

    #
    # For tests that require filesystem with cache line granularity, set
    # the path to a directory on a filesystem with such granularity.
    # This line may stay commented out if there's no such filesystem
    # available on your system.
    #

    # 'cacheline_fs_dir': '/mnt/pmem',
    'cacheline_fs_dir': cacheline_fs_dir,

    #
    # Enforce that the library will act in accordance with
    # cache line granularity, even if the underlying filesystem is not
    # cache line granular.
    #

    # 'force_cacheline': False,
    'force_cacheline': True,

    #
    # For tests that require filesystem with byte granularity, set
    # the path to a directory on a filesystem with such granularity.
    # This line may stay commented out if there's no such filesystem
    # available on your system.
    #

    # 'byte_fs_dir': '/mnt/pmem',
    'byte_fs_dir': byte_fs_dir,

    #
    # Enforce that the library will act in accordance with
    # byte granularity, even if the underlying filesystem is not byte
    # granular.
    #

    # 'force_byte': False,
    'force_byte': True,

    #
    # For tests that require true persistent memory, set the path to
    # a directory on a PMEM-aware file system here.
    # Uncomment this line if there's an actual persistent memory
    # available on your system.
    #

    # 'pmem_fs_dir': '/mnt/pmem',
    'pmem_fs_dir': pmem_fs_dir,

    #
    # For tests that require true a non-persitent memory aware file system
    # (i.e. to verify something works on traditional page-cache based
    # memory-mapped files) set the path to a directory
    # on a normal file system here.
    #

    # 'non_pmem_fs_dir': '/tmp',
    'non_pmem_fs_dir': non_pmem_fs_dir,

    #
    # Set filesystem type to be run:
    # pmem, non-pmem, any, none, all (default)
    #

    'fs': 'all',

    #
    # To display execution time of each test
    #

    'tm': True,

    #
    # Overwrite default test type:
    # check, short, medium, long, all
    # where: check = short + medium; all = short + medium + long
    #

    'test_type': 'check',

    #
    # Set build type to be run:
    # debug, release, static-debug, static-release, all
    # Can be a string or a list: ['debug', 'release']
    #

    # 'build': 'all',
    'build': ['debug', 'release'],

    #
    # Set filesystem granularity to be run:
    # page, cacheline, byte, none, all (default)
    #

    'granularity': 'all',

    #
    # If keep_going is set to True, execution continues despite test failures.
    #

    # 'keep_going': False,
    'keep_going': True,

    #
    # Skips will be treated as Fails if set to True
    #

    'fail_on_skip': False,

    #
    # Set timeout
    # (floating point number with an optional suffix: 's' for seconds,
    # 'm' for minutes, 'h' for hours or 'd' for days)
    #

    'timeout': '3m',

    #
    # If you don't have real PMEM or PMEM emulation set up and/or the
    # filesystem does not support MAP_SYNC flag, but still want to test PMEM
    # codepaths set fs_dir_force_pmem to 1 or 2. It will set PMEM_IS_PMEM_FORCE
    # to 1 for tests that require pmem.
    #
    # Setting this flag to 1, if the PMEM_FS_DIR filesystem supports MAP_SYNC
    # will cause an error. This flag cannot be used with filesystems which
    # support MAP_SYNC because it would prevent from testing the target
    # PMEM codepaths. If you want to ignore this error set the value to 2.
    #
    # 'fs_dir_force_pmem': 0,
    'fs_dir_force_pmem': 1,

    #
    # In case of test fail all log files will be written. You can specify how
    # many lines should be written by setting this variable. If 'dump_lines' is
    # not set default value is 30.
    #
    'dump_lines': 0,

    # Forcibly run tests with selected Valgrind tool, unless the test
    # explicitly disables it.
    # Possible values: None (do not force), 'memcheck',
    # 'pmemcheck', 'drd', 'helgrind'
    #
    'force_enable': None,

    # For tests that require raw dax devices without a file system, add paths
    # to those devices to the list 'device_dax_path'. For most tests one device
    # is enough, but some might require more.
    # Eg. ['/dev/dax0.0', '/dev/dax1.0']
    #
    'device_dax_path': [],
}
