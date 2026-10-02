---
title: sed, awk and bioawk one-liners
aliases: [sed one-liners, awk one-liners, bioawk one-liners, shell one-liners]
tags: [sed, awk, bioawk, shell, one-liners, bioinformatics, reference]
verified_with: GNU sed 4.9 · GNU Awk 5.3.2 · bioawk 20110810 · coreutils (Fedora 44)
created: 2026-10-01
---

# sed, awk and bioawk one-liners

> [!NOTE]
> **What's here**
> - **New collections** of sed, awk and bioawk one-liners for delimited files (CSV/TSV), biological formats (FASTA, FASTQ, VCF, BED, GFF3, SAM) and everyday tasks, plus shell companions for counting files, measuring sizes and so on.
> - **Eric Pement's classic *Handy one-liners for sed*** (v5.1), reformatted as Markdown and tested against modern GNU sed. See [Classic sed one-liners (Eric Pement)](#classic-sed-one-liners-eric-pement).
>
> Python equivalents are in [python-one-liners](python-one-liners.md) and the book compilation is in [python-one-liners-book](python-one-liners-book.md).

> [!TIP]
> **How the examples were verified**
> Every `bash` block was run inside `test-data/` under `LC_ALL=C.UTF-8`, and the `text` block under it is the real output. Re-check everything with `python3 scripts/verify_blocks.py sed-awk-bioawk-one-liners.md`. The Pement section uses `sh` blocks; they are tested separately by `scripts/test_pement_sed.sh`, which runs every command and compares each "emulates X" command against X itself.

> [!WARNING]
> **GNU vs BSD/macOS**
> These examples assume **GNU** sed and gawk (standard on Linux). On macOS, `sed -i` needs an argument (`sed -i ''`), `\t`, `\n`, `\+`, `\|`, `0~5` addresses and `\U` are GNU extensions, and `awk` is BWK awk without `FPAT`, `gensub`, `asort` or `PROCINFO`. Install `gsed`/`gawk` via Homebrew to get identical behaviour.

## Contents

- [sed — delimited files](#sed--delimited-files)
- [sed — bioinformatics](#sed--bioinformatics)
- [sed — everyday text tasks](#sed--everyday-text-tasks)
- [awk — fields, filters and formatting](#awk--fields-filters-and-formatting)
- [awk — aggregation and statistics](#awk--aggregation-and-statistics)
- [awk — multi-file and join operations](#awk--multi-file-and-join-operations)
- [awk — bioinformatics](#awk--bioinformatics)
- [bioawk](#bioawk)
- [Shell companions — files, sizes and counts](#shell-companions--files-sizes-and-counts)
- [Shell companions — text pipelines](#shell-companions--text-pipelines)
- [Classic sed one-liners (Eric Pement)](#classic-sed-one-liners-eric-pement)
- [Gotchas](#gotchas)

---

## sed — delimited files

**Print the header line only**

```bash
sed -n '1p' sample.csv
```

```text
id,name,group,value,date
```

**Skip the header**

```bash
sed '1d' sample.csv | head -3
```

```text
1,alpha,ctrl,10.5,2024-01-15
2,beta,ctrl,12.0,2024-01-20
3,gamma,treat,15.25,2024-02-03
```

**Simple CSV → TSV (no quoted commas!)**

```bash
sed 's/,/\t/g' expression.tsv | head -2; sed 's/,/\t/g' sample.csv | sed -n '6p' | cat -A
```

```text
gene	S1	S2	S3	S4
TP53	12.1	11.8	3.2	2.9
5^I"epsilon^I jr"^Itreat^I18.0^I2024-03-01$
```

> [!WARNING]
> `sed 's/,/\t/g'` splits `"epsilon, jr"` into two fields (line 6 above). For real CSV use `mlr --icsv --otsv cat`, `csvformat -T` (csvkit), Python's `csv`, or the gawk `FPAT` trick in [awk — fields, filters and formatting](#awk--fields-filters-and-formatting).

**TSV → CSV**

```bash
sed 's/\t/,/g' expression.tsv | head -3
```

```text
gene,S1,S2,S3,S4
TP53,12.1,11.8,3.2,2.9
BRCA1,5.5,5.9,6.1,5.7
```

**Replace a delimiter only in the Nth occurrence (here the 2nd comma → `|`)**

```bash
sed 's/,/|/2' sample.csv | head -3
```

```text
id,name|group,value,date
1,alpha|ctrl,10.5,2024-01-15
2,beta|ctrl,12.0,2024-01-20
```

**Strip all double quotes**

```bash
sed 's/"//g' sample.csv | sed -n '6p'
```

```text
5,epsilon, jr,treat,18.0,2024-03-01
```

**Trim spaces around delimiters**

```bash
printf 'a , b ,c\n1 ,  2,3\n' | sed -E 's/[[:space:]]*,[[:space:]]*/,/g'
```

```text
a,b,c
1,2,3
```

**Remove trailing delimiters**

```bash
printf 'a,b,c,,\n1,2,3,\n' | sed -E 's/,+$//'
```

```text
a,b,c
1,2,3
```

**Insert a header line**

```bash
sed '1i chrom\tstart\tend\tname\tscore\tstrand' sample.bed | head -3
```

```text
chrom	start	end	name	score	strand
chr1	100	200	peakA	500	+
chr1	150	250	peakB	300	-
```

**Append a footer line**

```bash
sed '$a # end of file' sample.bed | tail -2
```

```text
chr2	500	520	peakE	950	-
# end of file
```

**Replace the header (line 1) entirely**

```bash
sed '1c ID,NAME,GROUP,VALUE,DATE' sample.csv | head -2
```

```text
ID,NAME,GROUP,VALUE,DATE
1,alpha,ctrl,10.5,2024-01-15
```

**Uppercase the header only (GNU `\U`)**

```bash
sed '1s/.*/\U&/' sample.csv | head -2
```

```text
ID,NAME,GROUP,VALUE,DATE
1,alpha,ctrl,10.5,2024-01-15
```

**Print the column names, one per line, numbered**

```bash
sed -n '1{s/,/\n/g;p}' sample.csv | nl
```

```text
     1	id
     2	name
     3	group
     4	value
     5	date
```

**Fill empty fields with `NA` (repeat until no `,,` remain)**

```bash
printf 'a,,c,,\n,b,,d,\n' | sed -E ':a; s/,,/,NA,/g; ta; s/^,/NA,/; s/,$/,NA/'
```

```text
a,NA,c,NA,NA
NA,b,NA,d,NA
```

**Rows whose 3rd field equals `treat`**

```bash
sed -nE '/^[^,]*,[^,]*,treat,/p' sample.csv
```

```text
3,gamma,treat,15.25,2024-02-03
4,delta,treat,,2024-02-10
7,eta,treat,21.5,2024-03-18
```

> [!NOTE]
> Row 5 (`"epsilon, jr"`, also `treat`) is missed because its quoted comma shifts the fields. Field-level conditions are clearer in awk (see the `FPAT` example); the sed form is handy when you're already in a sed pipeline and the CSV has no quoted commas.

**Swap the first two columns (capture groups)**

```bash
sed -E 's/^([^\t]*)\t([^\t]*)/\2\t\1/' expression.tsv | head -3
```

```text
S1	gene	S2	S3	S4
12.1	TP53	11.8	3.2	2.9
5.5	BRCA1	5.9	6.1	5.7
```

**Edit a file in place, keeping a backup**

```bash
t=$(mktemp); cp sample.bed "$t"; sed -i.bak 's/^chr/Chr/' "$t"; head -2 "$t"; head -1 "$t.bak"; rm -f "$t" "$t.bak"
```

```text
Chr1	100	200	peakA	500	+
Chr1	150	250	peakB	300	-
chr1	100	200	peakA	500	+
```

**Edit several files in place at once (`-s` treats each file separately)**

```bash
d=$(mktemp -d); printf 'x\nlast\n' > $d/a; printf 'y\nlast\n' > $d/b; sed -s -i '$d' $d/a $d/b; cat $d/a $d/b; rm -r "$d"
```

```text
x
y
```

---

## sed — bioinformatics

**Simplify FASTA headers (keep the ID only)**

```bash
sed '/^>/ s/ .*//' sample.fasta | grep '>'
```

```text
>seq1
>seq2
>seq3
>seq4
```

**Add a prefix or sample tag to every header**

```bash
sed 's/^>/>sampleA_/' sample.fasta | grep '>'
```

```text
>sampleA_seq1 Homo sapiens test gene A
>sampleA_seq2 short fragment
>sampleA_seq3 GC-rich region
>sampleA_seq4 AT-rich
```

**Replace spaces in headers with underscores**

```bash
sed '/^>/ s/ /_/g' sample.fasta | grep '>'
```

```text
>seq1_Homo_sapiens_test_gene_A
>seq2_short_fragment
>seq3_GC-rich_region
>seq4_AT-rich
```

**Uppercase sequence lines only**

```bash
printf '>s1\nacgtNNacgt\n' | sed '/^>/! s/.*/\U&/'
```

```text
>s1
ACGTNNACGT
```

**Soft-masked (lowercase) bases → N**

```bash
printf '>s1\nACGTacgtACGT\n' | sed '/^>/! s/[acgt]/N/g'
```

```text
>s1
ACGTNNNNACGT
```

**FASTQ → FASTA (GNU `first~step` addresses)**

```bash
sed -n '1~4s/^@/>/p;2~4p' sample.fastq
```

```text
>read1 sample=A
ACGTACGTACGTACGTAAAA
>read2 sample=A
TTTTGGGGCCCCAAAANNNN
>read3 sample=B
ACGTTGCA
>read4 sample=B
GATTACAGATTACAGATTACAGATTACA
```

**Count reads in a FASTQ**

```bash
echo $(( $(sed -n '$=' sample.fastq) / 4 ))
```

```text
4
```

**Extract one FASTA record by ID (multi-line sequences OK)**

```bash
sed -n '/^>seq3\b/,/^>/{/^>seq3\b/p;/^>/!p}' sample.fasta
```

```text
>seq3 GC-rich region
GGGCCCGCGCGGCCGCGGCCATGCCGCGG
CCGGCGCGCCGGTAA
```

**Remove line wrapping from FASTA (one line per sequence)**

```bash
sed ':a; /^>/!{$!N; /\n[^>]/s/\n//; ta}; P; D' sample.fasta
```

```text
>seq1 Homo sapiens test gene A
ATGGCGTACGTTAGCCGATAGCTAGCTAGGCTAACGTAGCTAGCTAGCATCGATCGATGCATGC
>seq2 short fragment
ATGNNNACGTTAG
>seq3 GC-rich region
GGGCCCGCGCGGCCGCGGCCATGCCGCGGCCGGCGCGCCGGTAA
>seq4 AT-rich
ATATATTTAAATATTAAATTTATATAATTA
```

**Add or remove the `chr` prefix (VCF/BED)**

```bash
sed 's/^chr//' sample.bed | head -2; sed -E '/^#/! s/^([0-9XYM])/chr\1/' <(printf '#h\n1\t100\nX\t5\n')
```

```text
1	100	200	peakA	500	+
1	150	250	peakB	300	-
#h
chr1	100
chrX	5
```

**Rename `chrM` → `chrMT` in data lines and `##contig` headers**

```bash
printf '##contig=<ID=chrM,length=16569>\nchrM\t73\t.\tA\tG\n' | sed -E 's/(^|ID=)chrM\b/\1chrMT/'
```

```text
##contig=<ID=chrMT,length=16569>
chrMT	73	.	A	G
```

**Print VCF header lines only / body only**

```bash
sed -n '/^#/p' sample.vcf | wc -l; sed '/^#/d' sample.vcf | wc -l
```

```text
5
8
```

**Keep the VCF header + PASS records**

```bash
sed -n '/^#/p; /\tPASS\t/p' sample.vcf | tail -3
```

```text
chr2	50	rs5	T	C	80	PASS	DP=40;AF=0.5	GT	0/1	0/0
chr2	75	.	G	GTT	35	PASS	DP=18;AF=0.5	GT	0/0	0/1
chr2	200	rs7	C	A,G	70	PASS	DP=33;AF=0.3,0.2	GT	1/2	0/1
```

**Pull one INFO tag (e.g. `DP`) from every record**

```bash
sed -nE '/^#/! s/.*[\t;]DP=([0-9]+).*/\1/p' sample.vcf | tr '\n' ' '; echo
```

```text
30 8 45 22 40 18 33 5 
```

**Extract GFF3 `Name=` values**

```bash
sed -nE 's/.*[\t;]Name=([^;]+).*/\1/p' sample.gff3
```

```text
ABC1
XYZ9
```

**GFF3 → BED (0-based start), genes only**

```bash
sed -nE '/\tgene\t/ s/^([^\t]+)\t[^\t]+\t[^\t]+\t([0-9]+)\t([0-9]+)\t[^\t]+\t([+-])\t[^\t]+\t.*Name=([^;]+).*/\1\t\2\t\3\t\5\t0\t\4/p' sample.gff3 | awk 'BEGIN{OFS="\t"}{$2--; print}'
```

```text
chr1	99	900	ABC1	0	+
chr2	49	400	XYZ9	0	-
```

**Remove SAM header lines**

```bash
sed '/^@/d' sample.sam | cut -f1-6
```

```text
r1	99	chr1	100	60	20M
r1	147	chr1	180	60	20M
r2	0	chr1	300	12	8M
r3	16	chr2	50	42	5M2I5M
r4	4	*	0	0	*
r5	1024	chr2	60	60	10M
```

**Convert U ↔ T (RNA ↔ DNA) in sequence lines**

```bash
printf '>r\nAUGGCCUAA\n' | sed '/^>/! y/Uu/Tt/'
```

```text
>r
ATGGCCTAA
```

**Complement (no reverse) with `y///`**

```bash
echo ATGCatgc | sed 'y/ACGTacgt/TGCAtgca/'
```

```text
TACGtacg
```

**Reverse complement of a single sequence (sed + rev)**

```bash
echo ATGCGTTAN | rev | sed 'y/ACGTN/TGCAN/'
```

```text
NTAACGCAT
```

---

## sed — everyday text tasks

**Remove CR (Windows line endings)**

```bash
printf 'a\r\nb\r\n' | sed 's/\r$//' | cat -A
```

```text
a$
b$
```

**Strip ANSI colour codes**

```bash
printf '\033[1;31mERROR\033[0m done\n' | sed -E 's/\x1B\[[0-9;]*[A-Za-z]//g' | cat -A
```

```text
ERROR done$
```

**Collapse repeated spaces**

```bash
sed -n '$p' notes.txt | sed -E 's/ +/ /g; s/ $//' | cat -A
```

```text
TODO: fix extra spaces$
```

**Delete lines matching a pattern, in a range only**

```bash
seq 1 10 | sed '3,8{/[02468]/d}' | tr '\n' ' '; echo
```

```text
1 2 3 5 7 9 10 
```

**Print lines between two markers (exclusive)**

```bash
printf 'a\nSTART\nx\ny\nEND\nb\n' | sed -n '/START/,/END/{//!p}'
```

```text
x
y
```

**Comment out / uncomment a config line**

```bash
printf 'port=80\nhost=x\n' | sed 's/^port=/#&/'; printf '#port=80\nhost=x\n' | sed 's/^#\(port=\)/\1/'
```

```text
#port=80
host=x
port=80
host=x
```

**Change a `key=value` setting**

```bash
printf 'port=80\nhost=x\n' | sed -E 's/^(port=).*/\18080/'
```

```text
port=8080
host=x
```

**Insert a line after the match / before the match**

```bash
printf 'a\nb\nc\n' | sed '/b/a after-b' | tr '\n' ' '; printf 'a\nb\nc\n' | sed '/b/i before-b' | tr '\n' ' '; echo
```

```text
a b after-b c a before-b b c 
```

**Join all lines into one (comma-separated)**

```bash
seq 5 | sed ':a;N;$!ba;s/\n/,/g'
```

```text
1,2,3,4,5
```

**Split a line into one item per line**

```bash
echo 'a,b,c' | sed 's/,/\n/g'
```

```text
a
b
c
```

**Expand tabs to spaces (or `expand`)**

```bash
printf 'a\tb\n' | sed 's/\t/    /g' | cat -A
```

```text
a    b$
```

**Wrap each line in quotes**

```bash
printf 'TP53\nMYC\n' | sed 's/.*/"&"/'
```

```text
"TP53"
"MYC"
```

**Show non-printing characters (debug a file)**

```bash
printf 'x\ty \r\n' | sed -n 'l'
```

```text
x\ty \r$
```

**Print the first line that matches, then stop**

```bash
sed -n '/POST/{p;q}' access.log
```

```text
10.0.0.5 - - [01/Oct/2026:10:00:07 +0000] "POST /api/login HTTP/1.1" 401 87
```

**Extract the value between two delimiters**

```bash
sed -E 's/.*\[([^]]+)\].*/\1/' access.log | head -2
```

```text
01/Oct/2026:10:00:01 +0000
01/Oct/2026:10:00:07 +0000
```

**Slugify file names (preview)**

```bash
printf 'My File (v2).TXT\nData Set 1.csv\n' | sed -E 's/.*/\L&/; s/[^a-z0-9.]+/-/g; s/-+\././'
```

```text
my-file-v2.txt
data-set-1.csv
```

**Template substitution with shell variables (note the double quotes)**

```bash
name=TP53; chrom=chr17; echo 'gene=@NAME@ on @CHROM@' | sed "s/@NAME@/$name/; s/@CHROM@/$chrom/"
```

```text
gene=TP53 on chr17
```

**Use a different delimiter when the pattern contains `/`**

```bash
echo '/usr/local/bin/tool' | sed 's|/usr/local|/opt|'
```

```text
/opt/bin/tool
```

---

## awk — fields, filters and formatting

**Print selected columns (TSV in, TSV out)**

```bash
awk -F'\t' -v OFS='\t' '{print $1, $4}' expression.tsv
```

```text
gene	S3
TP53	3.2
BRCA1	6.1
MYC	15.6
GAPDH	20.4
EGFR	8.8
```

**Print the last field and the second-to-last field**

```bash
awk -F'\t' '{print $NF, $(NF-1)}' sample.bed
```

```text
+ 500
- 300
+ 800
+ 200
- 950
```

**Reorder and rename columns**

```bash
awk -F'\t' -v OFS='\t' 'NR==1{print "id","chr","s","e"; next} {print $4,$1,$2,$3}' <(sed '1i chrom\tstart\tend\tname' sample.bed) | head -3
```

```text
id	chr	s	e
peakA	chr1	100	200
peakB	chr1	150	250
```

**Real CSV with quoted commas (gawk `FPAT`)**

```bash
gawk -v FPAT='([^,]*)|("[^"]*")' -v OFS='\t' '{print $1, $2, $4}' sample.csv
```

```text
id	name	value
1	alpha	10.5
2	beta	12.0
3	gamma	15.25
4	delta	
5	"epsilon, jr"	18.0
6	zeta	9.75
7	eta	21.5
8	theta	11.0
```

**Rows where a numeric column passes a threshold**

```bash
awk -F, 'NR>1 && $4 > 15' sample.csv
```

```text
3,gamma,treat,15.25,2024-02-03
5,"epsilon, jr",treat,18.0,2024-03-01
7,eta,treat,21.5,2024-03-18
```

> [!WARNING]
> Row 5 is in the output **for the wrong reason**. With a plain `-F,`, the quoted `"epsilon, jr"` splits, so `$4` is `treat`, and `"treat" > 15` is a *string* comparison that happens to be true. Use `FPAT` (above) for quoted CSV, and `$4+0 > 15` to force a numeric comparison.

**Keep the header plus matching rows**

```bash
awk -F'\t' 'NR==1 || $2 > 10' expression.tsv
```

```text
gene	S1	S2	S3	S4
TP53	12.1	11.8	3.2	2.9
GAPDH	20.1	19.8	20.4	20.0
```

**Filter on a regex in one column**

```bash
awk -F'\t' '$1 ~ /^(TP53|MYC)$/' expression.tsv
```

```text
TP53	12.1	11.8	3.2	2.9
MYC	2.0	2.4	15.6	14.9
```

**Case-insensitive match (gawk)**

```bash
gawk 'BEGIN{IGNORECASE=1} /post/' access.log | wc -l
```

```text
2
```

**Print line numbers, or line ranges by number**

```bash
awk 'NR>=2 && NR<=3 {print NR": "$0}' sample.csv
```

```text
2: 1,alpha,ctrl,10.5,2024-01-15
3: 2,beta,ctrl,12.0,2024-01-20
```

**Print lines between two patterns**

```bash
awk '/^>seq2/{f=1} /^>seq3/{f=0} f' sample.fasta
```

```text
>seq2 short fragment
ATGNNNACGTTAG
```

**Count fields per line (spot ragged rows)**

```bash
awk -F, '{print NF}' sample.csv | sort | uniq -c
```

```text
      8 5
      1 6
```

**Check every row has the same number of columns**

```bash
awk -F'\t' 'NR==1{n=NF} NF!=n{bad++; print "line "NR": "NF" fields"} END{print (bad?bad" bad rows":"all rows have "n" fields")}' expression.tsv
```

```text
all rows have 5 fields
```

**Add a computed column**

```bash
awk -F'\t' -v OFS='\t' '{print $0, $3-$2}' sample.bed
```

```text
chr1	100	200	peakA	500	+	100
chr1	150	250	peakB	300	-	100
chr1	400	450	peakC	800	+	50
chr2	10	110	peakD	200	+	100
chr2	500	520	peakE	950	-	20
```

**Replace a column value in place**

```bash
awk -F'\t' -v OFS='\t' '{$6 = ($6=="+" ? "plus" : "minus")} 1' sample.bed | head -2
```

```text
chr1	100	200	peakA	500	plus
chr1	150	250	peakB	300	minus
```

**Pretty-print aligned columns**

```bash
awk -F'\t' '{printf "%-6s %6s %6s\n", $1, $2, $5}' expression.tsv
```

```text
gene       S1     S4
TP53     12.1    2.9
BRCA1     5.5    5.7
MYC       2.0   14.9
GAPDH    20.1   20.0
EGFR        0    9.1
```

**Round numbers / format decimals**

```bash
awk -F'\t' 'NR>1{printf "%s\t%.0f\t%.2e\n", $1, $2, $2}' expression.tsv
```

```text
TP53	12	1.21e+01
BRCA1	6	5.50e+00
MYC	2	2.00e+00
GAPDH	20	2.01e+01
EGFR	0	0.00e+00
```

**Remove duplicate lines without sorting (keep first)**

```bash
printf 'b\na\nb\nc\na\n' | awk '!seen[$0]++'
```

```text
b
a
c
```

**Deduplicate by one column**

```bash
awk -F'\t' '!seen[$1]++' sample.bed
```

```text
chr1	100	200	peakA	500	+
chr2	10	110	peakD	200	+
```

**Print the longest line and its length**

```bash
awk 'length > max {max = length; line = $0} END {print max": "line}' sample.csv
```

```text
37: 5,"epsilon, jr",treat,18.0,2024-03-01
```

**Transpose a matrix**

```bash
awk -F'\t' '{for (i=1; i<=NF; i++) a[i] = (NR==1 ? $i : a[i] "\t" $i)} END {for (i=1; i<=NF; i++) print a[i]}' expression.tsv
```

```text
gene	TP53	BRCA1	MYC	GAPDH	EGFR
S1	12.1	5.5	2.0	20.1	0
S2	11.8	5.9	2.4	19.8	0.5
S3	3.2	6.1	15.6	20.4	8.8
S4	2.9	5.7	14.9	20.0	9.1
```

**Convert TSV to a Markdown table**

```bash
awk -F'\t' 'NR==1{h=$0; gsub(/\t/," | ",h); print "| " h " |"; s="|"; for(i=1;i<=NF;i++) s=s"---|"; print s; next} {gsub(/\t/," | "); print "| " $0 " |"}' expression.tsv | head -4
```

```text
| gene | S1 | S2 | S3 | S4 |
|---|---|---|---|---|
| TP53 | 12.1 | 11.8 | 3.2 | 2.9 |
| BRCA1 | 5.5 | 5.9 | 6.1 | 5.7 |
```

**Split a file by a column value (preview the routing)**

```bash
gawk -v FPAT='([^,]*)|("[^"]*")' 'NR>1 {print $3 ".csv <- row " $1}' sample.csv | sort
```

```text
ctrl.csv <- row 1
ctrl.csv <- row 2
ctrl.csv <- row 6
ctrl.csv <- row 8
treat.csv <- row 3
treat.csv <- row 4
treat.csv <- row 5
treat.csv <- row 7
```

> [!TIP]
> To actually split, write instead of print: `gawk -v FPAT='([^,]*)|("[^"]*")' 'NR==1{h=$0; next} !($3 in s){print h > ($3".csv"); s[$3]} {print > ($3".csv")}' sample.csv`. The parentheses around the file name matter.

**Print every Nth line**

```bash
seq 1 20 | awk 'NR % 5 == 0' | tr '\n' ' '; echo
```

```text
5 10 15 20 
```

**Number non-empty lines**

```bash
awk 'NF {print ++n": "$0}' notes.txt | head -3
```

```text
1: Contact alice@example.com or bob.smith@lab.org.
2: Call +1-555-123-4567 before 2026-10-15.
3: Server 10.0.0.5 and 256.1.1.1 (invalid)
```

**Reverse the fields on every line**

```bash
echo 'a b c d' | awk '{for (i=NF; i>0; i--) printf "%s%s", $i, (i>1 ? OFS : ORS)}'
```

```text
d c b a
```

**Case conversion**

```bash
awk -F'\t' '{print tolower($1), toupper("x")}' expression.tsv | head -2
```

```text
gene X
tp53 X
```

**Substitution in a single field (`sub` / `gsub`)**

```bash
awk -F'\t' -v OFS='\t' '{gsub(/chr/, "", $1)} 1' sample.bed | head -2
```

```text
1	100	200	peakA	500	+
1	150	250	peakB	300	-
```

**Capture groups with gawk `match()`**

```bash
gawk 'match($0, /"(GET|POST) ([^ ]+)/, m) {print m[1], m[2]}' access.log
```

```text
GET /index.html
POST /api/login
GET /about.html
GET /missing.png
POST /api/login
GET /index.html
```

---

## awk — aggregation and statistics

**Sum a column**

```bash
awk -F'\t' 'NR>1 {s += $2} END {print s}' expression.tsv
```

```text
39.7
```

**Mean, min, max of a column**

```bash
awk -F'\t' 'NR>1 {s+=$2; n++; if (n==1 || $2<mn) mn=$2; if (n==1 || $2>mx) mx=$2} END {printf "n=%d mean=%.3f min=%s max=%s\n", n, s/n, mn, mx}' expression.tsv
```

```text
n=5 mean=7.940 min=0 max=20.1
```

**Sample standard deviation**

```bash
awk -F'\t' 'NR>1 {x[NR]=$2; s+=$2; n++} END {m=s/n; for (i in x) ss+=(x[i]-m)^2; printf "%.4f\n", sqrt(ss/(n-1))}' expression.tsv
```

```text
8.2075
```

**Median (sort first)**

```bash
cut -f2 expression.tsv | tail -n +2 | sort -g | awk '{a[NR]=$1} END {print (NR%2 ? a[(NR+1)/2] : (a[NR/2]+a[NR/2+1])/2)}'
```

```text
5.5
```

**Group-by count and sum**

```bash
gawk -v FPAT='([^,]*)|("[^"]*")' 'NR>1 {n[$3]++; s[$3]+=$4} END {for (g in n) print g, n[g], s[g]}' sample.csv | sort
```

```text
ctrl 4 43.25
treat 4 54.75
```

**Group-by mean, ignoring empty values**

```bash
gawk -v FPAT='([^,]*)|("[^"]*")' 'NR>1 && $4!="" {n[$3]++; s[$3]+=$4} END {for (g in n) printf "%s\t%.3f\n", g, s[g]/n[g]}' sample.csv | sort
```

```text
ctrl	10.812
treat	18.250
```

**Count occurrences of each value (like `sort | uniq -c`)**

```bash
awk '{c[$9]++} END {for (k in c) print c[k], k}' access.log | sort -rn
```

```text
3 200
1 404
1 401
1 304
```

**Percent of total**

```bash
awk '{c[$1]++; n++} END {for (k in c) printf "%-14s %d (%.1f%%)\n", k, c[k], 100*c[k]/n}' access.log | sort
```

```text
10.0.0.5       2 (33.3%)
172.16.4.2     1 (16.7%)
192.168.1.10   3 (50.0%)
```

**Running (cumulative) sum**

```bash
seq 1 5 | awk '{s += $1; print $1, s}'
```

```text
1 1
2 3
3 6
4 10
5 15
```

**Row-wise sum and mean of a matrix**

```bash
awk -F'\t' 'NR>1 {s=0; for (i=2; i<=NF; i++) s+=$i; printf "%s\t%.2f\t%.2f\n", $1, s, s/(NF-1)}' expression.tsv
```

```text
TP53	30.00	7.50
BRCA1	23.20	5.80
MYC	34.90	8.72
GAPDH	80.30	20.08
EGFR	18.40	4.60
```

**Column-wise means of a matrix**

```bash
awk -F'\t' 'NR==1 {for (i=2; i<=NF; i++) h[i]=$i; next} {for (i=2; i<=NF; i++) s[i]+=$i; n++} END {for (i=2; i<=NF; i++) printf "%s=%.2f ", h[i], s[i]/n; print ""}' expression.tsv
```

```text
S1=7.94 S2=8.08 S3=10.82 S4=10.52 
```

**Keep rows whose row mean exceeds a threshold**

```bash
awk -F'\t' 'NR==1 {print; next} {s=0; for (i=2; i<=NF; i++) s+=$i; if (s/(NF-1) > 8) print}' expression.tsv
```

```text
gene	S1	S2	S3	S4
MYC	2.0	2.4	15.6	14.9
GAPDH	20.1	19.8	20.4	20.0
```

**Max value per group (keep the whole row)**

```bash
awk -F'\t' '!($1 in m) || $5 > m[$1] {m[$1]=$5; r[$1]=$0} END {for (k in r) print r[k]}' sample.bed | sort
```

```text
chr1	400	450	peakC	800	+
chr2	500	520	peakE	950	-
```

**Top-N by a column (awk + sort)**

```bash
awk -F'\t' 'NR>1 {print $5"\t"$1}' expression.tsv | sort -k1,1gr | head -2
```

```text
20.0	GAPDH
14.9	MYC
```

**Text histogram with fixed-width bins**

```bash
awk -F'\t' 'NR>1 {for (i=2; i<=NF; i++) b[int($i/5)*5]++} END {for (k in b) {bar=""; for (j=0; j<b[k]; j++) bar=bar "#"; printf "%2d-%-2d %s\n", k, k+4, bar}}' expression.tsv | sort -n
```

```text
 0-4  ######
 5-9  ######
10-14 ###
15-19 ##
20-24 ###
```

**Linear regression (slope, intercept, r)**

```bash
printf '1 2.1\n2 3.9\n3 6.2\n4 7.8\n5 10.1\n' | awk '{x+=$1; y+=$2; xx+=$1*$1; yy+=$2*$2; xy+=$1*$2; n++} END {b=(n*xy-x*y)/(n*xx-x*x); a=(y-b*x)/n; r=(n*xy-x*y)/sqrt((n*xx-x*x)*(n*yy-y*y)); printf "slope=%.4f intercept=%.4f r=%.4f\n", b, a, r}'
```

```text
slope=1.9900 intercept=0.0500 r=0.9987
```

**Arithmetic and math functions on the command line**

```bash
awk 'BEGIN {printf "%.6f %.4f %.4f %d %d\n", atan2(0,-1), exp(1), log(10)/log(2), int(-3.7), 17 % 5}'
```

```text
3.141593 2.7183 3.3219 -3 2
```

**Convert units (bytes → human-readable)**

```bash
printf '512\n2048\n5368709120\n' | awk '{split("B KB MB GB TB", u); i=1; x=$1; while (x>=1024 && i<5) {x/=1024; i++} printf "%.1f %s\n", x, u[i]}'
```

```text
512.0 B
2.0 KB
5.0 GB
```

**Generate random numbers (seeded)**

```bash
awk 'BEGIN {srand(42); for (i=0; i<5; i++) printf "%d ", int(rand()*100); print ""}'
```

```text
24 39 95 17 59 
```

---

## awk — multi-file and join operations

**Join two files on a key (`NR==FNR` idiom, inner join)**

```bash
awk -F'\t' -v OFS='\t' 'NR==FNR {p[$1]=$2; next} ($1 in p) {print $0, p[$1]}' pvals.tsv ids.tsv
```

```text
ENSG01	TP53	0.001
ENSG03	MYC	0.04
```

**Left join with `NA` for missing keys**

```bash
awk -F'\t' -v OFS='\t' 'NR==FNR {p[$1]=$2; next} FNR==1 {print $0, "pval"; next} {print $0, ($1 in p ? p[$1] : "NA")}' pvals.tsv ids.tsv
```

```text
gene	symbol	pval
ENSG01	TP53	0.001
ENSG02	BRCA1	NA
ENSG03	MYC	0.04
```

**Lines in file B whose key is NOT in file A (anti-join)**

```bash
awk -F'\t' 'NR==FNR {a[$1]; next} !($1 in a)' ids.tsv pvals.tsv
```

```text
ENSG04	0.2
```

**Lines common to two files (set intersection, unsorted)**

```bash
awk 'NR==FNR {a[$0]; next} $0 in a' <(printf 'TP53\nMYC\nEGFR\n') <(printf 'MYC\nBRCA1\nTP53\n')
```

```text
MYC
TP53
```

**Filter rows by an ID list**

```bash
awk -F'\t' 'NR==FNR {keep[$1]; next} FNR==1 || $1 in keep' <(printf 'TP53\nGAPDH\n') expression.tsv
```

```text
gene	S1	S2	S3	S4
TP53	12.1	11.8	3.2	2.9
GAPDH	20.1	19.8	20.4	20.0
```

**Concatenate CSVs, keeping a single header**

```bash
awk 'FNR==1 && NR!=1 {next} 1' tree/data/a.csv tree/data/b.csv
```

```text
a,b
1,2
3,4
5,6
```

**Add the source file name as a column**

```bash
awk -v OFS=',' 'FNR==1 {next} {print FILENAME, $0}' tree/data/*.csv
```

```text
tree/data/a.csv,1,2
tree/data/a.csv,3,4
tree/data/b.csv,5,6
```

**Line count per file**

```bash
awk 'END {print NR} ' sample.csv; awk 'FNR==1 && NR>1 {print f, n} {f=FILENAME; n=FNR} END {print f, n}' sample.csv sample.bed
```

```text
9
sample.csv 9
sample.bed 5
```

**Paste two files side by side, line by line**

```bash
awk 'NR==FNR {a[FNR]=$0; next} {print a[FNR] "\t" $0}' <(seq 3) <(printf 'x\ny\nz\n')
```

```text
1	x
2	y
3	z
```

**Replace IDs using a lookup table**

```bash
awk -F'\t' -v OFS='\t' 'NR==FNR {m[$1]=$2; next} {$1 = ($1 in m ? m[$1] : $1)} 1' ids.tsv pvals.tsv
```

```text
TP53	0.001
MYC	0.04
ENSG04	0.2
```

---

## awk — bioinformatics

**Count sequences in a FASTA**

```bash
awk '/^>/ {n++} END {print n}' sample.fasta
```

```text
4
```

**Length of each FASTA sequence (multi-line safe)**

```bash
awk '/^>/ {if (id) print id, len; id=substr($1,2); len=0; next} {len += length($0)} END {print id, len}' sample.fasta
```

```text
seq1 64
seq2 13
seq3 44
seq4 30
```

**Linearise FASTA**

```bash
awk '/^>/ {if (seq) print seq; print; seq=""; next} {seq = seq $0} END {print seq}' sample.fasta
```

```text
>seq1 Homo sapiens test gene A
ATGGCGTACGTTAGCCGATAGCTAGCTAGGCTAACGTAGCTAGCTAGCATCGATCGATGCATGC
>seq2 short fragment
ATGNNNACGTTAG
>seq3 GC-rich region
GGGCCCGCGCGGCCGCGGCCATGCCGCGGCCGGCGCGCCGGTAA
>seq4 AT-rich
ATATATTTAAATATTAAATTTATATAATTA
```

**FASTA → two-column TSV (id, sequence)**

```bash
awk '/^>/ {if (s) print id "\t" s; id=substr($1,2); s=""; next} {s = s $0} END {print id "\t" s}' sample.fasta | cut -c1-40
```

```text
seq1	ATGGCGTACGTTAGCCGATAGCTAGCTAGGCTAAC
seq2	ATGNNNACGTTAG
seq3	GGGCCCGCGCGGCCGCGGCCATGCCGCGGCCGGCG
seq4	ATATATTTAAATATTAAATTTATATAATTA
```

**GC content per sequence (%)**

```bash
awk '/^>/ {if (id) printf "%s\t%.1f\n", id, 100*gc/len; id=substr($1,2); gc=len=0; next} {len+=length($0); gc+=gsub(/[GCgc]/,"")} END {printf "%s\t%.1f\n", id, 100*gc/len}' sample.fasta
```

```text
seq1	51.6
seq2	30.8
seq3	88.6
seq4	0.0
```

**Filter FASTA by minimum length**

```bash
awk '/^>/ {if (h && length(s) >= 30) print h "\n" s; h=$0; s=""; next} {s = s $0} END {if (length(s) >= 30) print h "\n" s}' sample.fasta | grep '>'
```

```text
>seq1 Homo sapiens test gene A
>seq3 GC-rich region
>seq4 AT-rich
```

**Extract FASTA records by an ID list**

```bash
awk 'NR==FNR {ids[$1]; next} /^>/ {p = (substr($1,2) in ids)} p' <(printf 'seq2\nseq4\n') sample.fasta
```

```text
>seq2 short fragment
ATGNNNACGTTAG
>seq4 AT-rich
ATATATTTAAATATTAAATTTATATAATTA
```

**Base composition of a FASTA**

```bash
awk '!/^>/ {n = split(toupper($0), c, ""); for (i=1; i<=n; i++) b[c[i]]++} END {for (k in b) printf "%s=%d ", k, b[k]; print ""}' sample.fasta | tr ' ' '\n' | sort | tr '\n' ' '; echo
```

```text
 A=37 C=35 G=41 N=3 T=35 
```

**Total and mean length, plus N50**

```bash
awk '/^>/ {if (l) print l; l=0; next} {l += length($0)} END {print l}' sample.fasta | sort -rn | awk '{a[NR]=$1; t+=$1} END {for (i=1; i<=NR; i++) {c+=a[i]; if (c >= t/2) {printf "total=%d mean=%.2f N50=%d\n", t, t/NR, a[i]; exit}}}'
```

```text
total=151 mean=37.75 N50=44
```

**Wrap sequences at 10 columns**

```bash
awk '/^>/ {print; next} {while (length($0) > 10) {print substr($0,1,10); $0 = substr($0,11)} if (length($0)) print}' <(printf '>x\nACGTACGTACGTACGTACGTAC\n')
```

```text
>x
ACGTACGTAC
GTACGTACGT
AC
```

**Count reads and bases in a FASTQ**

```bash
awk 'NR%4==2 {n++; b+=length($0)} END {printf "reads=%d bases=%d mean_len=%.1f\n", n, b, b/n}' sample.fastq
```

```text
reads=4 bases=76 mean_len=19.0
```

**FASTQ → FASTA**

```bash
awk 'NR%4==1 {print ">" substr($0,2)} NR%4==2' sample.fastq
```

```text
>read1 sample=A
ACGTACGTACGTACGTAAAA
>read2 sample=A
TTTTGGGGCCCCAAAANNNN
>read3 sample=B
ACGTTGCA
>read4 sample=B
GATTACAGATTACAGATTACAGATTACA
```

**Read-length distribution**

```bash
awk 'NR%4==2 {print length($0)}' sample.fastq | sort -n | uniq -c
```

```text
      1 8
      2 20
      1 28
```

**Mean Phred quality per read (Phred+33)**

```bash
awk 'BEGIN {for (i=33; i<127; i++) q[sprintf("%c", i)] = i-33} NR%4==1 {id=$1} NR%4==0 {s=0; for (i=1; i<=length($0); i++) s += q[substr($0,i,1)]; printf "%s\t%.1f\n", id, s/length($0)}' sample.fastq
```

```text
@read1	40.0
@read2	20.5
@read3	10.0
@read4	40.0
```

**Filter FASTQ by read length**

```bash
awk 'NR%4==1 {h=$0} NR%4==2 {s=$0} NR%4==3 {p=$0} NR%4==0 && length(s) >= 20 {print h "\n" s "\n" p "\n" $0}' sample.fastq | awk 'NR%4==1'
```

```text
@read1 sample=A
@read2 sample=A
@read4 sample=B
```

**VCF: variant counts per chromosome**

```bash
awk '!/^#/ {c[$1]++} END {for (k in c) print k, c[k]}' sample.vcf | sort
```

```text
chr1 4
chr2 4
```

**VCF: PASS variants with QUAL ≥ 30**

```bash
awk -F'\t' '/^#/ || ($7=="PASS" && $6 >= 30)' sample.vcf | grep -vc '^#'
```

```text
6
```

**VCF: SNPs vs indels**

```bash
awk -F'\t' '!/^#/ {t = (length($4)==1 && $5 ~ /^[ACGT](,[ACGT])*$/) ? "SNP" : "INDEL"; c[t]++} END {for (k in c) print k, c[k]}' sample.vcf | sort
```

```text
INDEL 2
SNP 6
```

**VCF: transition/transversion ratio (biallelic SNPs)**

```bash
awk -F'\t' '!/^#/ && length($4)==1 && length($5)==1 {if ($4$5 ~ /^(AG|GA|CT|TC)$/) ti++; else tv++} END {printf "Ti=%d Tv=%d Ti/Tv=%.2f\n", ti, tv, ti/tv}' sample.vcf
```

```text
Ti=4 Tv=1 Ti/Tv=4.00
```

**VCF: extract one INFO field as a column**

```bash
awk -F'\t' '!/^#/ {dp="NA"; n=split($8, kv, ";"); for (i=1; i<=n; i++) if (kv[i] ~ /^DP=/) dp=substr(kv[i],4); print $1":"$2, dp}' sample.vcf | head -4
```

```text
chr1:100 30
chr1:150 8
chr1:300 45
chr1:420 22
```

**VCF: genotype of one sample (column 10)**

```bash
awk -F'\t' '!/^#/ {split($10, g, ":"); c[g[1]]++} END {for (k in c) print k, c[k]}' sample.vcf | sort
```

```text
0/0 1
0/1 5
1/1 1
1/2 1
```

**VCF → BED (0-based, REF-length span)**

```bash
awk -F'\t' -v OFS='\t' '!/^#/ {print $1, $2-1, $2-1+length($4), $3=="." ? $1":"$2 : $3}' sample.vcf | head -4
```

```text
chr1	99	100	rs1
chr1	149	150	chr1:150
chr1	299	300	rs3
chr1	419	421	chr1:420
```

**BED: total bases and per-interval lengths**

```bash
awk -F'\t' '{l = $3-$2; t += l; print $4, l} END {print "total", t}' sample.bed
```

```text
peakA 100
peakB 100
peakC 50
peakD 100
peakE 20
total 370
```

**BED: extend intervals by 50 bp each side, clipping at 0 (`slop`)**

```bash
awk -F'\t' -v OFS='\t' '{$2 = ($2-50 < 0 ? 0 : $2-50); $3 += 50; print}' sample.bed | head -3
```

```text
chr1	50	250	peakA	500	+
chr1	100	300	peakB	300	-
chr1	350	500	peakC	800	+
```

**BED: keep intervals longer than N**

```bash
awk -F'\t' '$3-$2 > 50' sample.bed
```

```text
chr1	100	200	peakA	500	+
chr1	150	250	peakB	300	-
chr2	10	110	peakD	200	+
```

**BED: merge overlapping intervals (input must be sorted)**

```bash
sort -k1,1 -k2,2n sample.bed | awk -F'\t' -v OFS='\t' '$1!=c || $2>e {if (c) print c, s, e; c=$1; s=$2; e=$3; next} {if ($3>e) e=$3} END {print c, s, e}'
```

```text
chr1	100	250
chr1	400	450
chr2	10	110
chr2	500	520
```

**BED → 1-based `chr:start-end` region strings**

```bash
awk -F'\t' '{print $1":"$2+1"-"$3}' sample.bed
```

```text
chr1:101-200
chr1:151-250
chr1:401-450
chr2:11-110
chr2:501-520
```

**GFF3: feature counts**

```bash
awk -F'\t' '!/^#/ {c[$3]++} END {for (k in c) print k, c[k]}' sample.gff3 | sort
```

```text
exon 3
gene 2
mRNA 2
```

**GFF3: gene coordinates with the Name attribute**

```bash
awk -F'\t' '$3=="gene" {match($9, /Name=[^;]+/); print $1, $4, $5, $7, substr($9, RSTART+5, RLENGTH-5)}' sample.gff3
```

```text
chr1 100 900 + ABC1
chr2 50 400 - XYZ9
```

**GFF3: total exon length per parent transcript**

```bash
awk -F'\t' '$3=="exon" {match($9, /Parent=[^;]+/); p = substr($9, RSTART+7, RLENGTH-7); L[p] += $5-$4+1} END {for (k in L) print k, L[k]}' sample.gff3 | sort
```

```text
tx1 452
tx2 351
```

**SAM: mapped, unmapped, duplicate and MAPQ ≥ 30 counts**

```bash
awk -F'\t' '!/^@/ {if (and($2,4)) u++; else m++; if (and($2,1024)) d++; if ($5 >= 30) q++} END {print "mapped="m, "unmapped="u, "dup="d, "mapq30="q}' sample.sam
```

```text
mapped=5 unmapped=1 dup=1 mapq30=4
```

**SAM: reads per reference sequence**

```bash
awk -F'\t' '!/^@/ && $3 != "*" {c[$3]++} END {for (k in c) print k, c[k]}' sample.sam | sort
```

```text
chr1 3
chr2 2
```

**SAM: aligned reference length from CIGAR**

```bash
awk -F'\t' '!/^@/ && $6 != "*" {c=$6; L=0; while (match(c, /^[0-9]+[MIDNSHP=X]/)) {n=substr(c,1,RLENGTH-1); op=substr(c,RLENGTH,1); if (op ~ /[MDN=X]/) L+=n; c=substr(c,RLENGTH+1)} print $1, $6, L}' sample.sam
```

```text
r1 20M 20
r1 20M 20
r2 8M 8
r3 5M2I5M 10
r5 10M 10
```

**SAM → FASTQ (unmapped reads)**

```bash
awk -F'\t' '!/^@/ && and($2,4) {print "@"$1"\n"$10"\n+\n"$11}' sample.sam
```

```text
@r4
NNNNNNNN
+
!!!!!!!!
```

**Reverse complement in awk**

```bash
echo ATGCGTTAN | awk 'BEGIN {c["A"]="T"; c["C"]="G"; c["G"]="C"; c["T"]="A"; c["N"]="N"} {s=""; for (i=length($0); i>0; i--) s = s c[substr($0,i,1)]; print s}'
```

```text
NTAACGCAT
```

**Translate DNA → protein (codon table in a string)**

```bash
echo ATGGCGTACGTTAGCTAA | awk 'BEGIN {b="TCAG"; aa="FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG"; for (i=0; i<64; i++) t[substr(b,int(i/16)+1,1) substr(b,int(i/4)%4+1,1) substr(b,i%4+1,1)] = substr(aa,i+1,1)} {p=""; for (i=1; i+2<=length($0); i+=3) p = p t[substr($0,i,3)]; print p}'
```

```text
MAYVS*
```

**k-mer counting (k = 3)**

```bash
echo ATGATGATCC | awk -v k=3 '{for (i=1; i<=length($0)-k+1; i++) c[substr($0,i,k)]++} END {for (m in c) print c[m], m}' | sort -k1,1nr -k2 | head -3
```

```text
2 ATG
2 GAT
2 TGA
```

---

## bioawk

> [!NOTE]
> **bioawk**
> [bioawk](https://github.com/lh3/bioawk) is Heng Li's awk with built-in parsers. `-c fastx` gives `$name $seq $qual $comment`; `-c bed`, `-c sam`, `-c vcf` and `-c gff` give named columns (`bioawk -c help` lists them); `-c header` names columns from line 1. Built-ins include `gc()`, `meanqual()`, `revcomp()`, `reverse()`, `qualcount()` and bitwise `and()`/`or()`/`xor()`. Install it with `conda install -c bioconda bioawk` or `brew install bioawk`.

> [!WARNING]
> **Two bioawk gotchas, verified**
> 1. In `-c gff`, the column **names** after `score` are shifted one place from the GFF3 spec: `$filter` is the strand (col 7), `$strand` is the phase (col 8), `$group` holds the attributes (col 9), and `$attribute` is a non-existent col 10, so it prints **empty**. For GFF3, use `$7` and `$9` (or `$filter` and `$group`).
> 2. `-c header` still runs your action on the header line. Add `NR>1` if you don't want it.

**Sequence lengths (FASTA or FASTQ)**

```bash
bioawk -c fastx '{print $name, length($seq)}' sample.fasta
```

```text
seq1	64
seq2	13
seq3	44
seq4	30
```

**Count records**

```bash
bioawk -c fastx 'END {print NR}' sample.fastq
```

```text
4
```

**GC fraction per sequence**

```bash
bioawk -c fastx '{printf "%s\t%.3f\n", $name, gc($seq)}' sample.fasta
```

```text
seq1	0.516
seq2	0.308
seq3	0.886
seq4	0.000
```

**Reverse complement every sequence**

```bash
bioawk -c fastx '{print ">"$name"_rc\n"revcomp($seq)}' sample.fasta | head -4
```

```text
>seq1_rc
GCATGCATCGATCGATGCTAGCTAGCTACGTTAGCCTAGCTAGCTATCGGCTAACGTACGCCAT
>seq2_rc
CTAACGTNNNCAT
```

**FASTQ → FASTA**

```bash
bioawk -c fastx '{print ">"$name" "$comment"\n"$seq}' sample.fastq
```

```text
>read1 sample=A
ACGTACGTACGTACGTAAAA
>read2 sample=A
TTTTGGGGCCCCAAAANNNN
>read3 sample=B
ACGTTGCA
>read4 sample=B
GATTACAGATTACAGATTACAGATTACA
```

**Linearise FASTA (free with fastx parsing)**

```bash
bioawk -c fastx '{print ">"$name; print $seq}' sample.fasta | head -2
```

```text
>seq1
ATGGCGTACGTTAGCCGATAGCTAGCTAGGCTAACGTAGCTAGCTAGCATCGATCGATGCATGC
```

**Mean quality per read, and count of bases ≥ Q30**

```bash
bioawk -c fastx '{print $name, meanqual($qual), qualcount($qual, 30)}' sample.fastq
```

```text
read1	40	20
read2	20.5	10
read3	10	0
read4	40	28
```

**Filter reads by mean quality and length**

```bash
bioawk -c fastx 'meanqual($qual) >= 30 && length($seq) >= 10 {print "@"$name"\n"$seq"\n+\n"$qual}' sample.fastq | grep '^@'
```

```text
@read1
@read4
```

**Filter FASTA by length and rename**

```bash
bioawk -c fastx 'length($seq) > 20 {print ">contig_"++n" len="length($seq)"\n"$seq}' sample.fasta | grep '>'
```

```text
>contig_1 len=64
>contig_2 len=44
>contig_3 len=30
```

**Sequences containing a motif**

```bash
bioawk -c fastx '$seq ~ /ATG[ACGT]{3}TAG/ || $seq ~ /CGCGCG/ {print $name}' sample.fasta
```

```text
seq3
```

**Comment field (text after the ID)**

```bash
bioawk -c fastx '{print $name "\t" $comment}' sample.fasta
```

```text
seq1	Homo sapiens test gene A
seq2	short fragment
seq3	GC-rich region
seq4	AT-rich
```

**Total bases and N50 (bioawk + sort + awk)**

```bash
bioawk -c fastx '{print length($seq)}' sample.fasta | sort -rn | awk '{a[NR]=$1; t+=$1} END {for (i=1; i<=NR; i++) {c+=a[i]; if (c>=t/2) {print "N50="a[i], "total="t; exit}}}'
```

```text
N50=44 total=151
```

**VCF with named columns**

```bash
bioawk -c vcf '$filter=="PASS" && $qual >= 50 {print $chrom, $pos, $ref">"$alt}' sample.vcf
```

```text
chr1	100	A>G
chr1	300	G>A
chr1	420	AT>A
chr2	50	T>C
chr2	200	C>A,G
```

**BED with named columns (`-t` sets tab output)**

```bash
bioawk -t -c bed '{print $chrom, $end-$start, $name, $strand}' sample.bed
```

```text
chr1	100	peakA	+
chr1	100	peakB	-
chr1	50	peakC	+
chr2	100	peakD	+
chr2	20	peakE	-
```

**SAM: mapped reads with MAPQ ≥ 30 (bitwise `and`)**

```bash
bioawk -c sam '!and($flag, 4) && $mapq >= 30 {print $qname, $rname, $pos, $cigar}' sample.sam
```

```text
r1	chr1	100	20M
r1	chr1	180	20M
r3	chr2	50	5M2I5M
r5	chr2	60	10M
```

**SAM: reads on the reverse strand**

```bash
bioawk -c sam 'and($flag, 16) {print $qname, $flag}' sample.sam
```

```text
r1	147
r3	16
```

**GFF3 genes: positional `$7` / `$9` are safest**

```bash
bioawk -c gff '$feature=="gene" {print $seqname, $start, $end, $7, $9}' sample.gff3
```

```text
chr1	100	900	+	ID=gene1;Name=ABC1
chr2	50	400	-	ID=gene2;Name=XYZ9
```

**Named columns from a header line**

```bash
bioawk -t -c header 'NR>1 && $S3 > $S1 {print $gene, $S1, $S3}' expression.tsv
```

```text
BRCA1	5.5	6.1
MYC	2.0	15.6
GAPDH	20.1	20.4
EGFR	0	8.8
```

---

## Shell companions — files, sizes and counts

**Count files with one extension (recursive)**

```bash
find tree -type f -name '*.py' | wc -l
```

```text
3
```

**Count files per extension**

```bash
find tree -type f -name '*.*' | sed 's/.*\.//' | sort | uniq -c | sort -k1,1nr -k2
```

```text
      3 py
      2 csv
      2 txt
      1 bin
      1 md
```

**Count files in each directory**

```bash
find tree -type f -printf '%h\n' | sort | uniq -c
```

```text
      3 tree/data
      3 tree/docs
      1 tree/src
      2 tree/src/lib
```

**Total size of a folder (bytes and human-readable)**

```bash
du -sb tree | cut -f1; du -sh --apparent-size tree | cut -f1
```

```text
2128
2.1K
```

**Size of each subfolder, largest first**

```bash
du -sb tree/* | sort -rn
```

```text
2068	tree/data
34	tree/src
26	tree/docs
```

**Size of one file**

```bash
stat -c '%s %n' sample.fasta; wc -c < sample.fasta
```

```text
244 sample.fasta
244
```

**Largest files under a folder**

```bash
find tree -type f -printf '%s\t%p\n' | sort -rn | head -3
```

```text
2048	tree/data/blob.bin
14	tree/docs/readme.md
12	tree/src/main.py
```

**Total bytes of files with one extension**

```bash
find tree -type f -name '*.csv' -printf '%s\n' | awk '{s+=$1} END {print s" bytes"}'
```

```text
20 bytes
```

**Files larger / smaller than a size**

```bash
find tree -type f -size +1k; find tree -type f -size -20c | wc -l
```

```text
tree/data/blob.bin
8
```

**Files modified in the last N days**

<!-- nondeterministic -->
```bash
find tree -type f -mtime -7 | wc -l
```

```text
9
```

**Empty files and empty directories**

```bash
find . -type f -empty | wc -l; find . -type d -empty | wc -l
```

```text
0
0
```

**Duplicate files by checksum**

```bash
find tree -type f -exec md5sum {} + | sort | awk '{if ($1==p) {print pf; print $2} p=$1; pf=$2}' | sort -u
```

```text
tree/docs/copy_of_notes.txt
tree/docs/notes.txt
```

**Line counts of every `.py` file plus the total**

```bash
find tree -name '*.py' -exec wc -l {} + | sort -k2
```

```text
 4 total
 1 tree/src/lib/__init__.py
 2 tree/src/lib/util.py
 1 tree/src/main.py
```

**Lines of code per extension**

```bash
find tree -type f \( -name '*.py' -o -name '*.md' -o -name '*.csv' \) -exec wc -l {} + | awk '$2!="total" {n=split($2,a,"."); s[a[n]]+=$1} END {for (k in s) print k, s[k]}' | sort
```

```text
csv 5
md 3
py 4
```

**Rename all `*.txt` to `*.md` (dry run with `echo`)**

```bash
for f in tree/docs/*.txt; do echo mv "$f" "${f%.txt}.md"; done
```

```text
mv tree/docs/copy_of_notes.txt tree/docs/copy_of_notes.md
mv tree/docs/notes.txt tree/docs/notes.md
```

**Batch-rename with a sed expression (dry run)**

```bash
find tree -name '*.csv' | sed -E 's|(.*)/(.*)\.csv$|mv & \1/sample_\2.csv|'
```

```text
mv tree/data/a.csv tree/data/sample_a.csv
mv tree/data/b.csv tree/data/sample_b.csv
```

**Disk usage of the filesystem holding a path**

<!-- nondeterministic -->
```bash
df -h . | awk 'NR==2 {print $2" total, "$4" free ("$5" used)"}'
```

```text
1.9T total, 118G free (94% used)
```

**Count lines, words, characters**

```bash
wc -lwc notes.txt
```

```text
  7  20 203 notes.txt
```

**Number of sequences in every FASTA in a folder**

```bash
grep -c '^>' *.fasta
```

```text
4
```

**Checksum a file / verify checksums**

```bash
sha256sum sample.bed > /tmp/sum.$$ && sha256sum -c /tmp/sum.$$; rm -f /tmp/sum.$$
```

```text
sample.bed: OK
```

---

## Shell companions — text pipelines

**Top-N most frequent values**

```bash
cut -d' ' -f1 access.log | sort | uniq -c | sort -rn | head -3
```

```text
      3 192.168.1.10
      2 10.0.0.5
      1 172.16.4.2
```

**Unique values in a column**

```bash
cut -f1 sample.bed | sort -u
```

```text
chr1
chr2
```

**Sort a TSV by a numeric column, descending (keeping the header)**

```bash
(head -1 expression.tsv; tail -n +2 expression.tsv | sort -t$'\t' -k2,2gr) | cut -f1,2
```

```text
gene	S1
GAPDH	20.1
TP53	12.1
BRCA1	5.5
MYC	2.0
EGFR	0
```

**Natural / version sort (`chr2` before `chr10`)**

```bash
printf 'chr10\nchr2\nchrX\nchr1\n' | sort -V
```

```text
chr1
chr2
chr10
chrX
```

**Join two sorted files on the first column**

```bash
join -t$'\t' <(tail -n +2 ids.tsv | sort) <(sort pvals.tsv)
```

```text
ENSG01	TP53	0.001
ENSG03	MYC	0.04
```

**Lines only in file A / only in B / in both (`comm`)**

```bash
comm <(printf 'a\nb\nc\n') <(printf 'b\nc\nd\n')
```

```text
a
		b
		c
	d
```

**Side-by-side merge of columns**

```bash
paste <(cut -f1 expression.tsv) <(cut -f5 expression.tsv) | head -3
```

```text
gene	S4
TP53	2.9
BRCA1	5.7
```

**Pretty-print a TSV as aligned columns**

```bash
column -t -s$'\t' expression.tsv
```

```text
gene   S1    S2    S3    S4
TP53   12.1  11.8  3.2   2.9
BRCA1  5.5   5.9   6.1   5.7
MYC    2.0   2.4   15.6  14.9
GAPDH  20.1  19.8  20.4  20.0
EGFR   0     0.5   8.8   9.1
```

**Translate or delete characters (`tr`)**

```bash
echo 'Hello World' | tr 'a-z' 'A-Z'; echo 'a-b_c d' | tr -d ' _-'; echo 'aaabbb' | tr -s 'ab'
```

```text
HELLO WORLD
abcd
ab
```

**Reverse-complement with `tr`**

```bash
echo ATGCGTTAN | rev | tr ACGTN TGCAN
```

```text
NTAACGCAT
```

**Split a big file into N-line chunks (preview)**

```bash
d=$(mktemp -d); split -l 4 -d --additional-suffix=.fq sample.fastq $d/chunk_; ls $d; rm -r "$d"
```

```text
chunk_00.fq
chunk_01.fq
chunk_02.fq
chunk_03.fq
```

**Random sample of lines (seeded)**

```bash
seq 100 | shuf -n 5 --random-source=<(yes)
```

```text
15
87
63
22
88
```

**Grep with context, counts, and only the match**

```bash
grep -c POST access.log; grep -oE '"(GET|POST) [^ ]+' access.log | sort | uniq -c
```

```text
2
      1 "GET /about.html
      2 "GET /index.html
      1 "GET /missing.png
      2 "POST /api/login
```

**Parallel processing with `xargs`**

```bash
printf '%s\n' sample.fasta sample.fastq sample.vcf | xargs -P 3 -I{} sh -c 'echo "$(wc -l < {}) {}"' | sort -k2
```

```text
10 sample.fasta
16 sample.fastq
13 sample.vcf
```

**Run a command on each file found**

```bash
find tree -name '*.csv' -print0 | sort -z | xargs -0 -n1 sh -c 'echo "$1: $(($(wc -l < "$1") - 1)) rows"' _
```

```text
tree/data/a.csv: 2 rows
tree/data/b.csv: 1 rows
```

**Repeat a command for a range of numbers**

```bash
for i in {01..03}; do echo "sample_$i.fastq"; done
```

```text
sample_01.fastq
sample_02.fastq
sample_03.fastq
```

**Generate a numbered sequence / padded IDs**

```bash
seq -f 'id_%03g' 1 3; printf 'S%02d\n' {1..3}
```

```text
id_001
id_002
id_003
S01
S02
S03
```

**Timestamp each line of output**

<!-- nondeterministic -->
```bash
printf 'a\nb\n' | while IFS= read -r l; do echo "$(date +%T) $l"; done
```

```text
08:11:01 a
08:11:01 b
```

**Today's date in useful formats**

<!-- nondeterministic -->
```bash
date +%F; date +%Y%m%d_%H%M%S; date -u +%s
```

```text
2026-10-01
20261001_081101
1790842261
```

**Date arithmetic (GNU date)**

```bash
date -d '2026-10-01 + 30 days' +%F; echo $(( ($(date -d 2026-12-25 +%s) - $(date -d 2026-10-01 +%s)) / 86400 )) days
```

```text
2026-10-31
85 days
```

**Arithmetic with `bc` (floating point)**

```bash
echo 'scale=6; 4*a(1)' | bc -l; echo '2^64' | bc
```

```text
3.141592
18446744073709551616
```

**Base conversion**

```bash
printf '%d %x %o\n' 0xff 255 255; echo 'obase=2; 42' | bc
```

```text
255 ff 377
101010
```

---

## Classic sed one-liners (Eric Pement)

> [!NOTE]
> **Source**
> *HANDY ONE-LINERS FOR SED (Unix stream editor)*, version 5.1 (Mar. 23, 2001), compiled by Eric Pement <pemente@northpark.edu>. Reproduced in full, with the content unchanged and the layout converted to Markdown. The original was published at `http://www.student.northpark.edu/pemente/sed/sed1line.txt` and `http://www.cornerstonemag.com/sed/sed1line.txt`, and a Portuguese translation at `http://www.lrv.ufsc.br/wmaker/sed_ptBR.html`. Contributors credited in the original: Al Aab, Edgar Allen, Yiorgos Adamopoulos, Dale Dougherty, Carlos Duarte, Eric Pement, Ken Pizzini, S.G. Ravenhall and Greg Ubben.

> [!NOTE]
> **Tested against GNU sed 4.9**
> `scripts/test_pement_sed.sh` runs **all 93 Unix-side commands** (DOS-only ones are excluded) on a test file, and every one exits cleanly. **37** of the "emulates X" commands were then diffed against X itself (`tac`, `rev`, `head`, `tail`, `uniq`, `grep`, `cat -s`, `wc -l`, `paste`, …). **33 match exactly** in a UTF-8 locale (34 with `LC_ALL=C`). Two differ only in format: the `grep -A1 -B1` emulation prints the line number on its own line, and `paste` pads an odd last line. **Two have real problems** on GNU sed 4.9, and they are flagged below with ⚠️.
>
> In the original text, `gsed` means GNU sed (on Linux plain `sed` is GNU sed), and `filename` is a placeholder for your file.

### File Spacing

**Double space a file**

```sh
sed G
```

**Double space a file which already has blank lines in it. Output file should contain no more than one blank line between lines of text.**

```sh
sed '/^$/d;G'
```

**Triple space a file**

```sh
sed 'G;G'
```

**Undo double-spacing (assumes even-numbered lines are always blank)**

```sh
sed 'n;d'
```

### Numbering

**Number each line of a file (simple left alignment). Using a tab (see note on '\t' at end of file) instead of space will preserve margins.**

```sh
sed = filename | sed 'N;s/\n/\t/'
```

**Number each line of a file (number on left, right-aligned)**

```sh
sed = filename | sed 'N; s/^/     /; s/ *\(.\{6,\}\)\n/\1  /'
```

**Number each line of file, but only print numbers if line is not blank**

```sh
sed '/./=' filename | sed '/./N; s/\n/ /'
```

**Count lines (emulates "wc -l")**

```sh
sed -n '$='
```

### Text Conversion And Substitution

**IN UNIX ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format**

```sh
sed 's/.$//'               # assumes that all lines end with CR/LF
sed 's/^M$//'              # in bash/tcsh, press Ctrl-V then Ctrl-M
sed 's/\x0D$//'            # gsed 3.02.80, but top script is easier
```

**IN UNIX ENVIRONMENT: convert Unix newlines (LF) to DOS format**

```sh
sed "s/$/`echo -e \\\r`/"            # command line under ksh
sed 's/$'"/`echo \\\r`/"             # command line under bash
sed "s/$/`echo \\\r`/"               # command line under zsh
sed 's/$/\r/'                        # gsed 3.02.80
```

**IN DOS ENVIRONMENT: convert Unix newlines (LF) to DOS format**

```sh
sed "s/$//"                          # method 1
sed -n p                             # method 2
```

**IN DOS ENVIRONMENT: convert DOS newlines (CR/LF) to Unix format Cannot be done with DOS versions of sed. Use "tr" instead.**

```sh
tr -d \r <infile >outfile            # GNU tr version 1.22 or higher
```

**Delete leading whitespace (spaces, tabs) from front of each line aligns all text flush left**

```sh
sed 's/^[ \t]*//'                    # see note on '\t' at end of file
```

**Delete trailing whitespace (spaces, tabs) from end of each line**

```sh
sed 's/[ \t]*$//'                    # see note on '\t' at end of file
```

**Delete BOTH leading and trailing whitespace from each line**

```sh
sed 's/^[ \t]*//;s/[ \t]*$//'
```

**Insert 5 blank spaces at beginning of each line (make page offset)**

```sh
sed 's/^/     /'
```

**Align all text flush right on a 79-column width**

```sh
sed -e :a -e 's/^.\{1,78\}$/ &/;ta'  # set at 78 plus 1 space
```

**Center all text in the middle of 79-column width. In method 1, spaces at the beginning of the line are significant, and trailing spaces are appended at the end of the line. In method 2, spaces at the beginning of the line are discarded in centering the line, and no trailing spaces appear at the end of lines.**

```sh
sed  -e :a -e 's/^.\{1,77\}$/ & /;ta'                     # method 1
sed  -e :a -e 's/^.\{1,77\}$/ &/;ta' -e 's/\( *\)\1/\1/'  # method 2
```

**Substitute (find and replace) "foo" with "bar" on each line**

```sh
sed 's/foo/bar/'             # replaces only 1st instance in a line
sed 's/foo/bar/4'            # replaces only 4th instance in a line
sed 's/foo/bar/g'            # replaces ALL instances in a line
sed 's/\(.*\)foo\(.*foo\)/\1bar\2/' # replace the next-to-last case
sed 's/\(.*\)foo/\1bar/'            # replace only the last case
```

**Substitute "foo" with "bar" ONLY for lines which contain "baz"**

```sh
sed '/baz/s/foo/bar/g'
```

**Substitute "foo" with "bar" EXCEPT for lines which contain "baz"**

```sh
sed '/baz/!s/foo/bar/g'
```

**Change "scarlet" or "ruby" or "puce" to "red"**

```sh
sed 's/scarlet/red/g;s/ruby/red/g;s/puce/red/g'   # most seds
gsed 's/scarlet\|ruby\|puce/red/g'                # GNU sed only
```

**Reverse order of lines (emulates "tac") bug/feature in HHsed v1.5 causes blank lines to be deleted**

```sh
sed '1!G;h;$!d'               # method 1
sed -n '1!G;h;$p'             # method 2
```

**Reverse each character on the line (emulates "rev")**

```sh
sed '/\n/!G;s/\(.\)\(.*\n\)/&\2\1/;//D;s/.//'
```

**Join pairs of lines side-by-side (like "paste")**

```sh
sed '$!N;s/\n/ /'
```

**If a line ends with a backslash, append the next line to it**

```sh
sed -e :a -e '/\\$/N; s/\\\n//; ta'
```

**If a line begins with an equal sign, append it to the previous line and replace the "=" with a single space**

```sh
sed -e :a -e '$!N;s/\n=/ /;ta' -e 'P;D'
```

**Add commas to numeric strings, changing "1234567" to "1,234,567"**

```sh
gsed ':a;s/\B[0-9]\{3\}\>/,&/;ta'                     # GNU sed
sed -e :a -e 's/\(.*[0-9]\)\([0-9]\{3\}\)/\1,\2/;ta'  # other seds
```

**Add commas to numbers with decimal points and minus signs (GNU sed)**

```sh
gsed ':a;s/\(^\|[^0-9.]\)\([0-9]\+\)\([0-9]\{3\}\)/\1\2,\3/g;ta'
```

**Add a blank line every 5 lines (after lines 5, 10, 15, 20, etc.)**

```sh
gsed '0~5G'                  # GNU sed only
sed 'n;n;n;n;G;'             # other seds
```

### Selective Printing Of Certain Lines

**Print first 10 lines of file (emulates behavior of "head")**

```sh
sed 10q
```

**Print first line of file (emulates "head -1")**

```sh
sed q
```

**Print the last 10 lines of a file (emulates "tail")**

```sh
sed -e :a -e '$q;N;11,$D;ba'
```

**Print the last 2 lines of a file (emulates "tail -2")**

```sh
sed '$!N;$!D'
```

**Print the last line of a file (emulates "tail -1")**

```sh
sed '$!d'                    # method 1
sed -n '$p'                  # method 2
```

**Print only lines which match regular expression (emulates "grep")**

```sh
sed -n '/regexp/p'           # method 1
sed '/regexp/!d'             # method 2
```

**Print only lines which do NOT match regexp (emulates "grep -v")**

```sh
sed -n '/regexp/!p'          # method 1, corresponds to above
sed '/regexp/d'              # method 2, simpler syntax
```

**Print the line immediately before a regexp, but not the line containing the regexp**

```sh
sed -n '/regexp/{g;1!p;};h'
```

**Print the line immediately after a regexp, but not the line containing the regexp**

```sh
sed -n '/regexp/{n;p;}'
```

**Print 1 line of context before and after regexp, with line number indicating where the regexp occurred (similar to "grep -A1 -B1")**

```sh
sed -n -e '/regexp/{=;x;1!p;g;$!N;p;D;}' -e h
```

**Grep for AAA and BBB and CCC (in any order)**

```sh
sed '/AAA/!d; /BBB/!d; /CCC/!d'
```

**Grep for AAA and BBB and CCC (in that order)**

```sh
sed '/AAA.*BBB.*CCC/!d'
```

**Grep for AAA or BBB or CCC (emulates "egrep")**

```sh
sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d    # most seds
gsed '/AAA\|BBB\|CCC/!d'                        # GNU sed only
```

**Print paragraph if it contains AAA (blank lines separate paragraphs) HHsed v1.5 must insert a 'G;' after 'x;' in the next 3 scripts below**

```sh
sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;'
```

**Print paragraph if it contains AAA and BBB and CCC (in any order)**

```sh
sed -e '/./{H;$!d;}' -e 'x;/AAA/!d;/BBB/!d;/CCC/!d'
```

**Print paragraph if it contains AAA or BBB or CCC**

```sh
sed -e '/./{H;$!d;}' -e 'x;/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d
gsed '/./{H;$!d;};x;/AAA\|BBB\|CCC/b;d'         # GNU sed only
```

**Print only lines of 65 characters or longer**

```sh
sed -n '/^.\{65\}/p'
```

**Print only lines of less than 65 characters**

```sh
sed -n '/^.\{65\}/!p'        # method 1, corresponds to above
sed '/^.\{65\}/d'            # method 2, simpler syntax
```

**Print section of file from regular expression to end of file**

```sh
sed -n '/regexp/,$p'
```

**Print section of file based on line numbers (lines 8-12, inclusive)**

```sh
sed -n '8,12p'               # method 1
sed '8,12!d'                 # method 2
```

**Print line number 52**

```sh
sed -n '52p'                 # method 1
sed '52!d'                   # method 2
sed '52q;d'                  # method 3, efficient on large files
```

**Beginning at line 3, print every 7th line**

```sh
gsed -n '3~7p'               # GNU sed only
sed -n '3,${p;n;n;n;n;n;n;}' # other seds
```

**Print section of file between two regular expressions (inclusive)**

```sh
sed -n '/Iowa/,/Montana/p'             # case sensitive
```

### Selective Deletion Of Certain Lines

**Print all of file EXCEPT section between 2 regular expressions**

```sh
sed '/Iowa/,/Montana/d'
```

**Delete duplicate, consecutive lines from a file (emulates "uniq"). First line in a set of duplicate lines is kept, rest are deleted.**

```sh
sed '$!N; /^\(.*\)\n\1$/!P; D'
```

**Delete duplicate, nonconsecutive lines from a file. Beware not to overflow the buffer size of the hold space, or else use GNU sed.**

```sh
sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P'
```

> [!WARNING]
> **⚠️ Locale-dependent: corrected version below**
> Under a UTF-8 locale such as `en_US.UTF-8` this deletes **nothing**: glibc collation changes what `[ -~]` matches. Run it as `LC_ALL=C sed -n '…'`, or use the simpler `awk '!seen[$0]++'`. Lines containing a TAB are never removed either, because TAB is outside `[ -~]`.

Corrected (works in every locale and also handles TAB characters: `[^\n]` replaces `[ -~]`):

```bash
printf 'a\tb\nx\na\tb\nx\ny\n' | sed -n 'G; s/\n/&&/; /^\([^\n]*\n\).*\n\1/d; s/\n//; h; P' | cat -A
```

```text
a^Ib$
x$
y$
```


**Delete the first 10 lines of a file**

```sh
sed '1,10d'
```

**Delete the last line of a file**

```sh
sed '$d'
```

**Delete the last 2 lines of a file**

```sh
sed 'N;$!P;$!D;$d'
```

**Delete the last 10 lines of a file**

```sh
sed -e :a -e '$d;N;2,10ba' -e 'P;D'   # method 1
sed -n -e :a -e '1,10!{P;N;D;};N;ba'  # method 2
```

**Delete every 8th line**

```sh
gsed '0~8d'                           # GNU sed only
sed 'n;n;n;n;n;n;n;d;'                # other seds
```

**Delete ALL blank lines from a file (same as "grep '.' ")**

```sh
sed '/^$/d'                           # method 1
sed '/./!d'                           # method 2
```

**Delete all CONSECUTIVE blank lines from file except the first; also deletes all blank lines from top and end of file (emulates "cat -s")**

```sh
sed '/./,/^$/!d'          # method 1, allows 0 blanks at top, 1 at EOF
sed '/^$/N;/\n$/D'        # method 2, allows 1 blank at top, 0 at EOF
```

**Delete all CONSECUTIVE blank lines from file except the first 2:**

```sh
sed '/^$/N;/\n$/N;//D'
```

**Delete all leading blank lines at top of file**

```sh
sed '/./,$!d'
```

**Delete all trailing blank lines at end of file**

```sh
sed -e :a -e '/^\n*$/{$d;N;ba' -e '}'  # works on all seds
sed -e :a -e '/^\n*$/N;/\n$/ba'        # ditto, except for gsed 3.02*
```

> [!WARNING]
> **⚠️ Fails on modern GNU sed (tested on 4.9): corrected version below**
> When `N` hits end-of-file, GNU sed prints the pattern space before exiting, so the trailing blank lines are **kept**. It only works with `POSIXLY_CORRECT=1` set. Use the first version (`/^\n*$/{$d;N;ba` …), which works everywhere.

Corrected for GNU sed (stop before `N` on the last line):

```bash
printf 'a\n\nb\n\n\n' | sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' | cat -A
```

```text
a$
$
b$
```

**Delete the last line of each paragraph**

```sh
sed -n '/^$/{p;h;};/./{x;/./p;}'
```

### Special Applications

**Remove nroff overstrikes (char, backspace) from man pages. The 'echo' command may need an -e switch if you use Unix System V or bash shell.**

```sh
sed "s/.`echo \\\b`//g"    # double quotes required for Unix environment
sed 's/.^H//g'             # in bash/tcsh, press Ctrl-V and then Ctrl-H
sed 's/.\x08//g'           # hex expression for sed v1.5
```

**Get Usenet/e-mail message header**

```sh
sed '/^$/q'                # deletes everything after first blank line
```

**Get Usenet/e-mail message body**

```sh
sed '1,/^$/d'              # deletes everything up to first blank line
```

**Get Subject header, but remove initial "Subject: " portion**

```sh
sed '/^Subject: */!d; s///;q'
```

**Get return address header**

```sh
sed '/^Reply-To:/q; /^From:/h; /./d;g;q'
```

**Parse out the address proper. Pulls out the e-mail address by itself from the 1-line return address header (see preceding script)**

```sh
sed 's/ *(.*)//; s/>.*//; s/.*[:<] *//'
```

**Add a leading angle bracket and space to each line (quote a message)**

```sh
sed 's/^/> /'
```

**Delete leading angle bracket & space from each line (unquote a message)**

```sh
sed 's/^> //'
```

**Remove most HTML tags (accommodates multiple-line tags)**

```sh
sed -e :a -e 's/<[^>]*>//g;/</N;//ba'
```

**Extract multi-part uuencoded binaries, removing extraneous header info, so that only the uuencoded portion remains. Files passed to sed must be passed in the proper order. Version 1 can be entered from the command line; version 2 can be made into an executable Unix shell script. (Modified from a script by Rahul Dhesi.)**

```sh
sed '/^end/,/^begin/d' file1 file2 ... fileX | uudecode   # vers. 1
sed '/^end/,/^begin/d' "$@" | uudecode                    # vers. 2
```

**Zip up each .TXT file individually, deleting the source file and setting the name of each .ZIP file to the basename of the .TXT file (under DOS: the "dir /b" switch returns bare filenames in all caps).**

```sh
echo @echo off >zipup.bat
dir /b *.txt | sed "s/^\(.*\)\.TXT/pkzip -mo \1 \1.TXT/" >>zipup.bat
```


### Notes from the original

**Typical use.** sed takes one or more editing commands and applies all of them, in sequence, to each line of input. After all the commands have been applied to the first input line, that line is output and a second input line is taken for processing, and the cycle repeats. Input comes from stdin unless filenames are given; output goes to stdout.

```sh
cat filename | sed '10q'        # uses piped input
sed '10q' filename              # same effect, avoids a useless "cat"
sed '10q' filename > newfile    # redirects output to disk
```

**Further reading.** *sed & awk*, 2nd ed. (Dale Dougherty and Arnold Robbins, O'Reilly, 1997); *UNIX Text Processing* (Dale Dougherty and Tim O'Reilly, Hayden Books, 1987); the tutorials by Mike Arst in U-SEDIT2.ZIP; and, for regular expressions, *Mastering Regular Expressions* (Jeffrey Friedl, O'Reilly, 1997). The man pages (`man sed`, `man regexp`, the regex section of `man ed`) are a reference rather than a tutorial.

**Quoting syntax.** The examples use single quotes (`'...'`) so the Unix shell does not expand `$` or backquotes. csh users must also escape `!` (as `\!`), even inside single quotes. DOS versions of sed need double quotes (`"..."`) instead.

**Use of `\t` in sed scripts.** `\t` stands for a TAB character (0x09) in this document. Most old seds don't recognise it, so press the TAB key instead. awk, perl, HHsed, sedmod and GNU sed (v3.02.80 and later) all understand `\t`.

**Versions of sed.** Versions differ, and most don't allow labels (`:name`) or branches (`b`, `t`) except at the end of a command. The examples use the portable form; GNU sed allows a shorter one:

```sh
sed -e '/AAA/b' -e '/BBB/b' -e '/CCC/b' -e d   # portable
sed '/AAA/b;/BBB/b;/CCC/b;d'                   # GNU sed
sed '/AAA\|BBB\|CCC/b;d'                       # GNU sed, shorter still
```

Also, some seds accept `/one/ s/RE1/RE2/` but reject `/one/! s/RE1/RE2/` (a space before the `s`). Omit the space.

**Optimizing for speed.** A substitution runs faster when an address selects the lines first:

```sh
sed 's/foo/bar/g' filename         # standard replace command
sed '/foo/ s/foo/bar/g' filename   # executes more quickly
sed '/foo/ s//bar/g' filename      # shorthand sed syntax
```

When you only need lines from the start of a file, quit early with `q`:

```sh
sed -n '45,50p' filename           # print line nos. 45-50 of a file
sed -n '51q;45,50p' filename       # same, but executes much faster
```

---

## Gotchas

**`sed -i` on macOS needs an explicit backup suffix**

<!-- no-run -->
```bash
sed -i '' 's/a/b/' file   # BSD/macOS
sed -i 's/a/b/' file      # GNU
```

**Locale changes regex ranges and speed**

```bash
printf 'a\nb\na\n' | LC_ALL=C sed -n 'G; s/\n/&&/; /^\([ -~]*\n\).*\n\1/d; s/\n//; h; P' | tr '\n' ' '; echo "(C locale)"
```

```text
a b (C locale)
```

> [!WARNING]
> In `en_US.UTF-8` the same command prints `a b a`: glibc's collation makes `[ -~]` match differently, so the duplicate survives. Prefix byte-oriented scripts with `LC_ALL=C`, which is also much faster for `sort`, `grep` and `awk` on big files.

**awk compares numbers as strings when a field isn't numeric-looking**

```bash
echo '10 9' | awk '{print ($1 > $2)}'; echo '10 9x' | awk '{print ($1 > $2)}'; echo '10 9x' | awk '{print ($1+0 > $2+0)}'
```

```text
1
0
1
```

**Assigning to a field rebuilds `$0` with `OFS`**

```bash
echo 'a b c' | awk '{$2 = "X"} 1'; echo 'a,b,c' | awk -F, '{$2 = "X"} 1'; echo 'a,b,c' | awk -F, -v OFS=, '{$2 = "X"} 1'
```

```text
a X c
a X c
a,X,c
```

**`$1=$1` normalises whitespace**

```bash
echo '  a    b   c ' | awk '{$1=$1} 1' | cat -A
```

```text
a b c$
```

**Shell variables go into awk via `-v`, not by splicing quotes**

```bash
t=15; awk -F, -v t="$t" 'NR>1 && $4 > t {print $2}' sample.csv
```

```text
gamma
"epsilon
eta
```

**`sort` needs `-g` for scientific notation and `-k` for a single key**

```bash
printf '1e-3\n2e-10\n0.5\n' | sort -n | tr '\n' ' '; echo '(-n: wrong)'; printf '1e-3\n2e-10\n0.5\n' | sort -g | tr '\n' ' '; echo '(-g: right)'
```

```text
0.5 1e-3 2e-10 (-n: wrong)
2e-10 1e-3 0.5 (-g: right)
```

**`uniq` only collapses adjacent duplicates**

```bash
printf 'a\nb\na\n' | uniq | tr '\n' ' '; printf 'a\nb\na\n' | sort | uniq | tr '\n' ' '; echo
```

```text
a b a a b 
```
