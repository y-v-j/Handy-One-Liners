#!/usr/bin/env bash
# Run the whole test suite: every code block in the notes + the classic sed list.
set -u
cd "$(dirname "$0")/.."
status=0
echo "### 1/2  code blocks in the notes"
python3 scripts/verify_blocks.py "$@" || status=1
echo; echo "### 2/2  Eric Pement's sed one-liners vs GNU sed"
bash scripts/test_pement_sed.sh || status=1
echo; [[ $status -eq 0 ]] && echo "ALL TESTS PASSED" || echo "SOME TESTS FAILED"
exit $status
