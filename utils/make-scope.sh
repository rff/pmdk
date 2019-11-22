#!/usr/bin/env bash
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

MAKE_ARGS="$*"

#timestamp="$(date --utc --iso-8601=seconds)"
timestamp="$(date --utc '+%Y%m%dT%H%M%S%z')"
log="\"make-scope_${timestamp}.log\""

cmd=''
cmd+="echo ======================================================================== |& tee -a ${log} ;"
cmd+="date --utc |& tee -a ${log} ;"
cmd+="echo \"make_args: ${MAKE_ARGS}\" |& tee -a ${log} ;"
cmd+="time make ${MAKE_ARGS} |& tee -a ${log} ;"
cmd+="echo \"= FIM (exit \$?)\" |& tee -a ${log} ;"
cmd+="date --utc |& tee -a ${log} ;"
cmd+="echo \"= LOG FILE:\" ${log} ;"

systemd-run --user --scope --unit=pmdk-make  --nice=19 bash -c "${cmd}"
