#
# Copyright 2014-2016, Intel Corporation
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
#
# pmempool_dump/TEST5 -- test for dump command
#
[CmdletBinding(PositionalBinding=$false)]
Param(
    [alias("d")]
    $DIR = ""
    )
$Env:UNITTEST_NAME = "pmempool_dump\TEST5w"
$Env:UNITTEST_NUM = "5w"


. ..\unittest\unittest.ps1

require_fs_type any

#XXX: port poolsets tests
#
#setup
#
#$POOL="$DIR\file.pool"
#$LOG="out$Env:UNITTEST_NUM.log"
#
#rm $LOG -Force -Recurse -ea si
#POOLSET=$DIR/pool.set
#POOL_PART1=$DIR/pool.part1
#POOL_PART2=$DIR/pool.part2
#LOG=out${UNITTEST_NUM}.log
#rm -rf $LOG && touch $LOG
#
#rm -f $POOLSET $POOL_PART1 $POOL_PART2
#
#create_poolset $POOLSET 32M:$POOL_PART1:z 32M:$POOL_PART2:z
#
#expect_normal_exit $PMEMPOOL create log $POOLSET
#expect_normal_exit $PMEMWRITE $POOLSET PMEMPOOL_DUMP_TEST
#expect_normal_exit $PMEMPOOL dump $POOLSET >> $LOG
#
#check

pass
