# SPDX-License-Identifier: BSD-3-Clause
# Copyright 2016-2018, Intel Corporation
#
#
# pmempool_info\TEST17.PS1 -- test for info command
#

. ..\unittest\unittest.ps1

require_test_type medium

require_fs_type any

setup

$LOG="out$Env:UNITTEST_NUM.log"
remove_files $LOG

$POOLSET="$DIR\pool.set"
$POOL1="$DIR\pool.part1"
$POOL2="$DIR\pool.part2"
$POOLS="$POOL1 $POOL2"
$REPL1="$DIR\pool.rep.part1"
$REPL2="$DIR\pool.rep.part2"
$REPS="$REPL1 $REPL2"

remove_files $POOLSET
create_poolset $POOLSET 32M:${POOL1}:z 32M:${POOL2}:z `
	R 32M:${REPL1}:z 32M:${REPL2}:z
check_file $POOLSET

remove_files $POOLS $REPS
expect_normal_exit $PMEMPOOL create obj --layout pmempool$Env:SUFFIX $POOLSET
expect_normal_exit $PMEMPOOL info $POOL1 >> $LOG
expect_normal_exit $PMEMPOOL info $POOL2 >> $LOG
expect_normal_exit $PMEMPOOL info $REPL1 >> $LOG
expect_normal_exit $PMEMPOOL info $REPL2 >> $LOG

check

pass
