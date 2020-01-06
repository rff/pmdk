#!/usr/bin/env bash
# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2016-2020, Intel Corporation

#
# prepare-for-build.sh - is called inside a Docker container; prepares
#                        the environment inside a Docker container for
#                        running build of PMDK project.
#

set -e

# Some travis-ci instances have ID conflics between the VM and docker users. So
# let's make sure we fix any ownership mismatch from the binded workdir.
echo ${USERPASS} | sudo -S chown -R ${USER}: ${WORKDIR}

# Configure tests (e.g. ssh for remote tests) unless the current configuration
# should be preserved
KEEP_TEST_CONFIG=${KEEP_TEST_CONFIG:-0}
if [[ "$KEEP_TEST_CONFIG" == 0 ]]; then
	./configure-tests.sh
fi
