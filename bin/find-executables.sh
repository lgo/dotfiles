#!/usr/bin/env bash
#
# Finds all files that are not executable but have a shebang ("#!"). After
# inspecting the output of this file, you can then make them executable with
#
#   find-executables.sh | xargs chmod +x
#
# NB: We use gfind, the GNU find installed on macos via 'brew install findutils'

set -e

gfind . ! -executable -type f -not \( -path './.git/*' \) -exec echo -n '"{}" ' \; | tr '\n' ' ' | xargs grep -Il '#!'
