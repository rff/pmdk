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

import pathlib

# testdir = pathlib.Path.cwd() / 'pmem-test-dir'
testdir = pathlib.Path('/mnt/pmem/raoni-pmdk-test-dir')
testdir.mkdir(parents=True, exist_ok=True)
testdir = str(testdir)

# XXX: Commented config lines are the ones we changed from the default config
# for travis.
config = {
  'unittest_log_level': 1,
  'cacheline_fs_dir': testdir,
  'force_cacheline': True,
  'page_fs_dir': testdir,
  # 'force_page': False,
  'force_page': True,
  'byte_fs_dir': testdir,
  'force_byte': True,
  'tm': True,
  'test_type': 'check',
  'granularity': 'all',
  # 'fs_dir_force_pmem': 0,
  'fs_dir_force_pmem': 1,
  # 'keep_going': False,
  'keep_going': True,
  'timeout': '3m',
  'build': ['debug', 'release'],
  'force_enable': None,
  'device_dax_path': [],
  'fail_on_skip': False
}
