#!/usr/bin/env bash
# Test Eric Pement's "Handy one-liners for sed" (v5.1) against the local GNU sed.
#  1. every Unix-side command in scripts/pement_commands.txt must run cleanly
#  2. every "emulates X" command is diffed against X itself
#  3. the corrected versions of the two commands broken on GNU sed must match
# usage: bash scripts/test_pement_sed.sh            (uses your current locale)
#        LC_ALL=C bash scripts/test_pement_sed.sh
set -u
cd "$(dirname "$0")"
work=$(mktemp -d); trap 'rm -rf "$work"' EXIT
in="$work/in.txt"
printf '\n\nfirst line foo\n  indented foo foo baz\nfoo bar foo foo foo\n\n\n\nsame\nsame\nsame\n1234567 and -9876543.21\nline with trailing   \t\nAAA then BBB then CCC\nCCC BBB AAA\nIowa\nmiddle\nMontana\nafter\nlast-but-one \\\ncontinued\n=appended\nshort\nthis line is definitely sixty-five characters or longer, yes indeed!!\n\n\nend\n\n\n' > "$in"

echo "== $(sed --version | head -1), locale=${LC_ALL:-${LANG:-unset}}"
n=0; bad=0
while IFS= read -r c; do
  n=$((n+1)); cmd=${c//in.txt/$in}; [[ $c == *in.txt* ]] || cmd="$c $in"
  if ! err=$(bash -c "$cmd" 2>&1 >/dev/null) || [[ -n $err ]]; then echo "RUN-FAIL: $c :: $err"; bad=$((bad+1)); fi
done < pement_commands.txt
echo "1) ran $n commands, $bad failed"

same=0; diff=0
chk() {  # $1 = Pement command, $2 = reference, $3 = note when they differ
  if diff <(bash -c "$1" 2>&1) <(bash -c "$2" 2>&1) >/dev/null; then same=$((same+1))
  else diff=$((diff+1)); echo "DIFF: $1   vs   $2   [$3]"; [[ $3 == CORRECTED* ]] && bad=$((bad+1)); fi
}
cd "$work"
chk "sed -n '\$=' in.txt" "wc -l < in.txt"
chk "sed '1!G;h;\$!d' in.txt" "tac in.txt"
chk "sed -n '1!G;h;\$p' in.txt" "tac in.txt"
chk "sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//' in.txt" "rev in.txt"
chk "sed 10q in.txt" "head -n 10 in.txt"
chk "sed q in.txt" "head -n 1 in.txt"
chk "sed -e :a -e '\$q;N;11,\$D;ba' in.txt" "tail -n 10 in.txt"
chk "sed '\$!N;\$!D' in.txt" "tail -n 2 in.txt"
chk "sed '\$!d' in.txt" "tail -n 1 in.txt"
chk "sed -n '/foo/p' in.txt" "grep foo in.txt"
chk "sed -n '/foo/!p' in.txt" "grep -v foo in.txt"
chk "sed -n -e '/Iowa/{=;x;1!p;g;\$!N;p;D;}' -e h in.txt" "grep -n -A1 -B1 Iowa in.txt" "format only: line number printed on its own line"
chk "sed '\$!N; /^\(.*\)\n\1\$/!P; D' in.txt" "uniq in.txt"
chk "sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P' in.txt" "awk '!seen[\$0]++' in.txt" "REAL: [ -~] range is locale-dependent; works with LC_ALL=C"
chk "sed '/^\$/d' in.txt" "grep . in.txt"
chk "sed '/./,/^\$/!d' in.txt" "cat -s in.txt | sed '1{/^\$/d}'"
chk "sed '/^\$/N;/\n\$/D' in.txt" "cat -s in.txt"
chk "sed '1,10d' in.txt" "tail -n +11 in.txt"
chk "sed '\$d' in.txt" "head -n -1 in.txt"
chk "sed 'N;\$!P;\$!D;\$d' in.txt" "head -n -2 in.txt"
chk "sed -e :a -e '\$d;N;2,10ba' -e 'P;D' in.txt" "head -n -10 in.txt"
chk "sed -n -e :a -e '1,10!{P;N;D;};N;ba' in.txt" "head -n -10 in.txt"
chk "sed '0~8d' in.txt" "awk 'NR%8' in.txt"
chk "sed 'n;n;n;n;n;n;n;d;' in.txt" "awk 'NR%8' in.txt"
chk "sed -n '3~7p' in.txt" "awk 'NR%7==3' in.txt"
chk "sed -n '3,\${p;n;n;n;n;n;n;}' in.txt" "awk 'NR%7==3' in.txt"
chk "sed '0~5G' in.txt" "sed 'n;n;n;n;G;' in.txt"
chk "sed = in.txt | sed 'N;s/\n/\t/'" "awk '{print NR \"\t\" \$0}' in.txt"
chk "sed '\$!N;s/\n/ /' in.txt" "paste -d' ' - - < in.txt" "format only: paste pads an odd last line with the delimiter"
chk "sed '12q;d' in.txt" "sed -n 12p in.txt"
chk "sed ':a;s/\B[0-9]\{3\}\>/,&/;ta' <<< 1234567" "echo 1,234,567"
chk "sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta' <<< 1234567" "echo 1,234,567"
chk "sed ':a;s/\(^\|[^0-9.]\)\([0-9]\+\)\([0-9]\{3\}\)/\1\2,\3/g;ta' <<< '-9876543.21 and 1234567'" "echo '-9,876,543.21 and 1,234,567'"
chk "sed -e :a -e '/^\n*\$/{\$d;N;ba' -e '}' in.txt" "printf '%s\n' \"\$(cat in.txt)\""
chk "sed -e :a -e '/^\n*\$/N;/\n\$/ba' in.txt" "printf '%s\n' \"\$(cat in.txt)\"" "REAL: GNU N prints pattern space at EOF; works only with POSIXLY_CORRECT=1"
chk "sed '/./,\$!d' in.txt" "awk 'NF||p{p=1;print}' in.txt"
chk "sed 's/.\x08//g' <<< \$'b\x08bo\x08ol\x08ld\x08d'" "echo bold"
# corrected versions of the two commands that fail on GNU sed (must match in ANY locale)
chk "sed -n 'G; s/\n/&&/; /^\([^\n]*\n\).*\n\1/d; s/\n//; h; P' in.txt" "awk '!seen[\$0]++' in.txt" "CORRECTED version failed"
chk "sed -e :a -e '/^\n*\$/{\$d;N;};/\n\$/ba' in.txt" "printf '%s\n' \"\$(cat in.txt)\"" "CORRECTED version failed"
echo "2) compared $((same+diff)) emulations: $same identical, $diff differ"
[[ $bad -eq 0 ]]
