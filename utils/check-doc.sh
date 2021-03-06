#!/bin/bash
#
# Copyright 2016, Intel Corporation
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
# Used to check whether changes to the generated documentation directory
# are made by the authorised user. Used only by travis builds.
#
# usage: ./check-doc.sh [-v]
#

directory=doc/generated
allowed_user="Generic builder <nvml-bot@intel.com>"

if [[ -z "$TRAVIS" ]]; then
	echo "ERROR: This script can only be executed on Travis CI."
	exit -1
fi

# Find all the commits for the current build
if [[ -n "$TRAVIS_COMMIT_RANGE" ]]; then
	commits=$(git rev-list $TRAVIS_COMMIT_RANGE)
else
	commits=$TRAVIS_COMMIT
fi

# Get the list of files modified by the commits
files=$(for commit in $commits; do git diff-tree --no-commit-id --name-only \
	-r $commit; done | sort -u)

if [[ "$1" == "-v" ]]; then
	echo "Commits in the commit range:"
	for commit in $commits; do echo $commit; done
	echo "Files modified within the commit range:"
	for file in $files; do echo $file; done
fi

# Check for changes in the generated docs directory
for file in $files; do
	# Check if modified files are relevant to the current build
	if [[ $file =~ ^($directory)\/* ]] \
			&& [[ $TRAVIS_REPO_SLUG == "pmem/nvml" \
			&& $TRAVIS_BRANCH == "master" \
			&& $TRAVIS_EVENT_TYPE != "pull_request" ]]
	then
		last_author=$(git --no-pager show -s --format='%aN <%aE>')
		if [ "$last_author" != "$allowed_user" ]; then
			echo "FAIL: changes to ${directory} allowed only by \"${allowed_user}\""
			exit -1
		fi
	fi
done
