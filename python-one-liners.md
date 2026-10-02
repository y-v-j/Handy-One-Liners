---
title: Python one-liners (extended)
aliases: [python one-liners, py one-liners]
tags: [python, one-liners, reference, bioinformatics, data-processing]
verified_with: Python 3.14.6 · pandas 3.0.5 · numpy 2.4.6 · Biopython 1.88
created: 2026-10-01
---

# Python one-liners: extended collection

> [!NOTE]
> **What's here**
> These are everyday Python one-liners for files, delimited data, text, regex, lambdas, maths, statistics, bioinformatics, dates and the command line. They extend the book compilation in [python-one-liners-book](python-one-liners-book.md), and shell equivalents are in [sed-awk-bioawk-one-liners](sed-awk-bioawk-one-liners.md).
>
> **Every block was executed.** The `text` block under each snippet is its real output, produced by running it inside `test-data/` with Python 3.14. Re-check with `python3 scripts/verify_blocks.py python-one-liners.md`. Blocks preceded by `<!-- nondeterministic -->` (random values, current time, file timestamps) show a sample run.

> [!TIP]
> **Conventions**
> - "One-liner" means one logical expression. Imports sit on the same line (`import x; ...`) or the line above.
> - File examples read small sample files (`sample.csv`, `sample.fasta`, `sample.vcf`, …). Substitute your own files of the same format.
> - Stdlib first. pandas, numpy and Biopython are used only in their own sections.

## Contents

- [Files and folders](#files-and-folders)
- [Reading and writing CSV, TSV, JSON](#reading-and-writing-csv-tsv-json)
- [Delimited data with the standard library](#delimited-data-with-the-standard-library)
- [pandas one-liners](#pandas-one-liners)
- [Text and strings](#text-and-strings)
- [Regular expressions](#regular-expressions)
- [Lambdas, sorting and functional tools](#lambdas-sorting-and-functional-tools)
- [Collections and itertools](#collections-and-itertools)
- [Maths and number theory](#maths-and-number-theory)
- [Statistics](#statistics)
- [numpy one-liners](#numpy-one-liners)
- [Bioinformatics — sequences](#bioinformatics--sequences)
- [Bioinformatics — file formats](#bioinformatics--file-formats)
- [Biopython one-liners](#biopython-one-liners)
- [Dates and times](#dates-and-times)
- [Command-line python -c and python -m](#command-line-python--c-and-python--m)
- [System, hashing, encoding and security](#system-hashing-encoding-and-security)
- [Gotchas worth remembering](#gotchas-worth-remembering)

---

## Files and folders

**Count files by extension, recursively**

```python
from pathlib import Path; from collections import Counter
print(Counter(p.suffix or "<none>" for p in Path("tree").rglob("*") if p.is_file()).most_common())
```

```text
[('.py', 3), ('.txt', 2), ('.csv', 2), ('.md', 1), ('.bin', 1)]
```

**Count the files with one extension**

```python
from pathlib import Path
print(sum(1 for _ in Path("tree").rglob("*.py")))
```

```text
3
```

**Total size of a folder (bytes)**

```python
from pathlib import Path
print(sum(p.stat().st_size for p in Path("tree").rglob("*") if p.is_file()))
```

```text
2128
```

**Human-readable file size**

```python
human = lambda n: next(f"{n / 1024**i:.1f} {u}" for i, u in enumerate("B KB MB GB TB PB".split()) if n < 1024**(i + 1) or u == "PB")
print(human(512), human(2048), human(5_368_709_120))
```

```text
512.0 B 2.0 KB 5.0 GB
```

**Size of every file, largest first**

```python
from pathlib import Path
print(*sorted(((p.stat().st_size, str(p)) for p in Path("tree").rglob("*") if p.is_file()), reverse=True)[:3], sep="\n")
```

```text
(2048, 'tree/data/blob.bin')
(14, 'tree/docs/readme.md')
(12, 'tree/src/main.py')
```

**Size per extension**

```python
from pathlib import Path; from collections import Counter
c = Counter(); [c.update({p.suffix: p.stat().st_size}) for p in Path("tree").rglob("*") if p.is_file()]; print(dict(c))
```

```text
{'.py': 34, '.md': 14, '.txt': 12, '.csv': 20, '.bin': 2048}
```

**Most recently modified file**

<!-- nondeterministic -->
```python
from pathlib import Path
print(max(Path("tree").rglob("*.*"), key=lambda p: p.stat().st_mtime))
```

```text
tree/docs/copy_of_notes.txt
```

**Find duplicate files by content hash**

```python
import hashlib; from pathlib import Path; from collections import defaultdict
d = defaultdict(list); [d[hashlib.md5(p.read_bytes()).hexdigest()].append(p.name) for p in sorted(Path("tree").rglob("*")) if p.is_file()]; print([v for v in d.values() if len(v) > 1])
```

```text
[['copy_of_notes.txt', 'notes.txt']]
```

**List empty files and empty directories**

```python
from pathlib import Path
print([str(p) for p in Path(".").rglob("*") if (p.is_file() and p.stat().st_size == 0) or (p.is_dir() and not any(p.iterdir()))])
```

```text
[]
```

**Line count of every `.py` file, plus the total**

```python
from pathlib import Path
counts = {str(p): sum(1 for _ in p.open()) for p in sorted(Path("tree").rglob("*.py"))}; print(counts, sum(counts.values()))
```

```text
{'tree/src/lib/__init__.py': 1, 'tree/src/lib/util.py': 2, 'tree/src/main.py': 1} 4
```

**Count lines in a big file without loading it**

```python
print(sum(1 for _ in open("sample.fasta")))
```

```text
10
```

**Bulk rename preview: `.txt` → `.md` (dry run)**

```python
from pathlib import Path
print([(p.name, p.with_suffix(".md").name) for p in sorted(Path("tree").rglob("*.txt"))])
```

```text
[('copy_of_notes.txt', 'copy_of_notes.md'), ('notes.txt', 'notes.md')]
```

> [!WARNING]
> To actually rename, call `p.rename(p.with_suffix(".md"))`. Run the dry-run list first.

**Directory tree as indented text**

```python
from pathlib import Path
print("\n".join("  " * (len(p.relative_to("tree").parts) - 1) + p.name for p in sorted(Path("tree").rglob("*"))))
```

```text
data
  a.csv
  b.csv
  blob.bin
docs
  copy_of_notes.txt
  notes.txt
  readme.md
src
  lib
    __init__.py
    util.py
  main.py
```

**Files bigger than N bytes**

```python
from pathlib import Path
print([p.name for p in Path("tree").rglob("*") if p.is_file() and p.stat().st_size > 100])
```

```text
['blob.bin']
```

**Read the first N lines of a file**

```python
from itertools import islice
print("".join(islice(open("sample.csv"), 3)), end="")
```

```text
id,name,group,value,date
1,alpha,ctrl,10.5,2024-01-15
2,beta,ctrl,12.0,2024-01-20
```

**Read the last N lines of a file**

```python
from collections import deque
print("".join(deque(open("sample.csv"), maxlen=2)), end="")
```

```text
7,eta,treat,21.5,2024-03-18
8,theta,ctrl,11.0,2024-04-02
```

**Write a list to a file, one item per line**

```python
from pathlib import Path; import tempfile
p = Path(tempfile.gettempdir(), "items.txt"); p.write_text("\n".join(["a", "b", "c"]) + "\n"); print(p.read_text().split())
```

```text
['a', 'b', 'c']
```

**Disk usage of a mount point**

<!-- nondeterministic -->
```python
import shutil
print({k: f"{v / 1e9:.1f} GB" for k, v in shutil.disk_usage(".")._asdict().items()})
```

```text
{'total': '1997.6 GB', 'used': '1868.4 GB', 'free': '126.1 GB'}
```

---

## Reading and writing CSV, TSV, JSON

**CSV → list of dicts**

```python
import csv
print(list(csv.DictReader(open("sample.csv")))[:2])
```

```text
[{'id': '1', 'name': 'alpha', 'group': 'ctrl', 'value': '10.5', 'date': '2024-01-15'}, {'id': '2', 'name': 'beta', 'group': 'ctrl', 'value': '12.0', 'date': '2024-01-20'}]
```

**CSV → JSON**

```python
import csv, json
print(json.dumps(list(csv.DictReader(open("sample.csv")))[:2], indent=1))
```

```text
[
 {
  "id": "1",
  "name": "alpha",
  "group": "ctrl",
  "value": "10.5",
  "date": "2024-01-15"
 },
 {
  "id": "2",
  "name": "beta",
  "group": "ctrl",
  "value": "12.0",
  "date": "2024-01-20"
 }
]
```

**TSV → CSV (quoting handled by the `csv` module)**

```python
import csv, sys
csv.writer(sys.stdout).writerows(csv.reader(open("expression.tsv"), delimiter="\t"))
```

```text
gene,S1,S2,S3,S4
TP53,12.1,11.8,3.2,2.9
BRCA1,5.5,5.9,6.1,5.7
MYC,2.0,2.4,15.6,14.9
GAPDH,20.1,19.8,20.4,20.0
EGFR,0,0.5,8.8,9.1
```

**CSV → TSV, keeping the quoted comma intact**

```python
import csv, sys
csv.writer(sys.stdout, delimiter="\t", lineterminator="\n").writerows(csv.reader(open("sample.csv")))
```

```text
id	name	group	value	date
1	alpha	ctrl	10.5	2024-01-15
2	beta	ctrl	12.0	2024-01-20
3	gamma	treat	15.25	2024-02-03
4	delta	treat		2024-02-10
5	epsilon, jr	treat	18.0	2024-03-01
6	zeta	ctrl	9.75	2024-03-05
7	eta	treat	21.5	2024-03-18
8	theta	ctrl	11.0	2024-04-02
```

**Pretty-print JSON**

```python
import json
print(json.dumps({"b": [1, 2], "a": {"x": None}}, indent=2, sort_keys=True))
```

```text
{
  "a": {
    "x": null
  },
  "b": [
    1,
    2
  ]
}
```

**JSON Lines → list**

```python
import json, io
print([json.loads(l) for l in io.StringIO('{"id": 1}\n{"id": 2}\n')])
```

```text
[{'id': 1}, {'id': 2}]
```

**Flatten nested JSON into dotted keys**

```python
flat = lambda d, p="": {f"{p}{k}": v for kk, vv in d.items() for k, v in (flat(vv, f"{kk}.").items() if isinstance(vv, dict) else [(kk, vv)])}
print(flat({"a": 1, "b": {"c": 2, "d": {"e": 3}}}))
```

```text
{'a': 1, 'b.c': 2, 'b.d.e': 3}
```

**Read a gzip-compressed text file**

```python
import gzip
print(gzip.open("sample.fastq.gz", "rt").readline().strip(), sum(1 for _ in gzip.open("sample.fastq.gz", "rt")) // 4)
```

```text
@read1 sample=A 4
```

---

## Delimited data with the standard library

**Print one column**

```python
import csv
print([r["name"] for r in csv.DictReader(open("sample.csv"))])
```

```text
['alpha', 'beta', 'gamma', 'delta', 'epsilon, jr', 'zeta', 'eta', 'theta']
```

**Sum a numeric column, skipping blanks**

```python
import csv
print(sum(float(r["value"]) for r in csv.DictReader(open("sample.csv")) if r["value"]))
```

```text
98.0
```

**Filter rows on a condition**

```python
import csv
print([r["name"] for r in csv.DictReader(open("sample.csv")) if r["group"] == "treat" and r["value"] and float(r["value"]) > 16])
```

```text
['epsilon, jr', 'eta']
```

**Group-by sum**

```python
import csv; from collections import defaultdict
d = defaultdict(float); [d.__setitem__(r["group"], d[r["group"]] + float(r["value"] or 0)) for r in csv.DictReader(open("sample.csv"))]; print(dict(d))
```

```text
{'ctrl': 43.25, 'treat': 54.75}
```

**Group-by mean (dropping blanks)**

```python
import csv, statistics as st; from itertools import groupby
rows = sorted((r for r in csv.DictReader(open("sample.csv")) if r["value"]), key=lambda r: r["group"])
print({g: round(st.mean(float(r["value"]) for r in rs), 3) for g, rs in groupby(rows, key=lambda r: r["group"])})
```

```text
{'ctrl': 10.812, 'treat': 18.25}
```

**Unique values in a column, with counts**

```python
import csv; from collections import Counter
print(Counter(r["group"] for r in csv.DictReader(open("sample.csv"))))
```

```text
Counter({'ctrl': 4, 'treat': 4})
```

**Count missing values per column**

```python
import csv
rows = list(csv.DictReader(open("sample.csv"))); print({k: sum(not r[k] for r in rows) for k in rows[0]})
```

```text
{'id': 0, 'name': 0, 'group': 0, 'value': 1, 'date': 0}
```

**Select and reorder columns**

```python
import csv, sys
w = csv.writer(sys.stdout, lineterminator="\n"); [w.writerow([r[2], r[1]]) for r in csv.reader(open("sample.csv"))]
```

```text
group,name
ctrl,alpha
ctrl,beta
treat,gamma
treat,delta
treat,"epsilon, jr"
ctrl,zeta
treat,eta
ctrl,theta
```

**Transpose a TSV matrix**

```python
import csv
print("\n".join("\t".join(c) for c in zip(*csv.reader(open("expression.tsv"), delimiter="\t"))))
```

```text
gene	TP53	BRCA1	MYC	GAPDH	EGFR
S1	12.1	5.5	2.0	20.1	0
S2	11.8	5.9	2.4	19.8	0.5
S3	3.2	6.1	15.6	20.4	8.8
S4	2.9	5.7	14.9	20.0	9.1
```

**Join two TSVs on a key (inner join)**

```python
import csv
p = dict(csv.reader(open("pvals.tsv"), delimiter="\t")); print([(g, s, p[g]) for g, s in csv.reader(open("ids.tsv"), delimiter="\t") if g in p])
```

```text
[('ENSG01', 'TP53', '0.001'), ('ENSG03', 'MYC', '0.04')]
```

**Left join, filling missing values with `NA`**

```python
import csv
p = dict(csv.reader(open("pvals.tsv"), delimiter="\t")); print([(g, s, p.get(g, "NA")) for g, s in list(csv.reader(open("ids.tsv"), delimiter="\t"))[1:]])
```

```text
[('ENSG01', 'TP53', '0.001'), ('ENSG02', 'BRCA1', 'NA'), ('ENSG03', 'MYC', '0.04')]
```

**Row-wise mean of a numeric matrix**

```python
import csv, statistics as st
r = csv.reader(open("expression.tsv"), delimiter="\t"); next(r); print({row[0]: round(st.mean(map(float, row[1:])), 2) for row in r})
```

```text
{'TP53': 7.5, 'BRCA1': 5.8, 'MYC': 8.72, 'GAPDH': 20.07, 'EGFR': 4.6}
```

**Sort rows by a numeric column, descending**

```python
import csv
print([r["name"] for r in sorted(csv.DictReader(open("sample.csv")), key=lambda r: float(r["value"] or "-inf"), reverse=True)])
```

```text
['eta', 'epsilon, jr', 'gamma', 'beta', 'theta', 'alpha', 'zeta', 'delta']
```

**Deduplicate rows on a key, keeping the first**

```python
rows = [("a", 1), ("b", 2), ("a", 3)]
print(list({k: (k, v) for k, v in reversed(rows)}.values())[::-1])
```

```text
[('b', 2), ('a', 1)]
```

**Split a CSV into one file per group (preview)**

```python
import csv; from collections import defaultdict
d = defaultdict(list); [d[r["group"]].append(r["id"]) for r in csv.DictReader(open("sample.csv"))]; print(dict(d))
```

```text
{'ctrl': ['1', '2', '6', '8'], 'treat': ['3', '4', '5', '7']}
```

---

## pandas one-liners

> [!NOTE]
> Tested with pandas **3.0**: copy-on-write and the new default `str` dtype are on. Chained assignment (`df["a"][0] = 1`) no longer modifies `df`. Use `df.loc[0, "a"] = 1`.

**Read, then show shape and dtypes**

```python
import pandas as pd
df = pd.read_csv("sample.csv"); print(df.shape); print(df.dtypes.to_dict())
```

```text
(8, 5)
{'id': dtype('int64'), 'name': <StringDtype(na_value=nan)>, 'group': <StringDtype(na_value=nan)>, 'value': dtype('float64'), 'date': <StringDtype(na_value=nan)>}
```

**Summary statistics of numeric columns**

```python
import pandas as pd
print(pd.read_csv("sample.csv")["value"].describe().round(2).to_dict())
```

```text
{'count': 7.0, 'mean': 14.0, 'std': 4.42, 'min': 9.75, '25%': 10.75, '50%': 12.0, '75%': 16.62, 'max': 21.5}
```

**Missing values per column**

```python
import pandas as pd
print(pd.read_csv("sample.csv").isna().sum().to_dict())
```

```text
{'id': 0, 'name': 0, 'group': 0, 'value': 1, 'date': 0}
```

**Group-by aggregate with several functions**

```python
import pandas as pd
print(pd.read_csv("sample.csv").groupby("group")["value"].agg(["count", "mean", "max"]).round(2))
```

```text
       count   mean   max
group                    
ctrl       4  10.81  12.0
treat      3  18.25  21.5
```

**Value counts as proportions**

```python
import pandas as pd
print(pd.read_csv("sample.csv")["group"].value_counts(normalize=True).to_dict())
```

```text
{'ctrl': 0.5, 'treat': 0.5}
```

**Filter with `query`**

```python
import pandas as pd
print(pd.read_csv("sample.csv").query("group == 'ctrl' and value > 10")["name"].tolist())
```

```text
['alpha', 'beta', 'theta']
```

**Fill missing values with the group mean**

```python
import pandas as pd
df = pd.read_csv("sample.csv"); print(df["value"].fillna(df.groupby("group")["value"].transform("mean")).round(2).tolist())
```

```text
[10.5, 12.0, 15.25, 18.25, 18.0, 9.75, 21.5, 11.0]
```

**Parse dates and resample monthly**

```python
import pandas as pd
print(pd.read_csv("sample.csv", parse_dates=["date"]).set_index("date")["value"].resample("ME").sum().to_dict())
```

```text
{Timestamp('2024-01-31 00:00:00'): 22.5, Timestamp('2024-02-29 00:00:00'): 15.25, Timestamp('2024-03-31 00:00:00'): 49.25, Timestamp('2024-04-30 00:00:00'): 11.0}
```

**Wide → long (melt) and back (pivot)**

```python
import pandas as pd
long = pd.read_csv("expression.tsv", sep="\t").melt(id_vars="gene", var_name="sample", value_name="expr"); print(long.head(3)); print(long.pivot(index="gene", columns="sample", values="expr").shape)
```

```text
    gene sample  expr
0   TP53     S1  12.1
1  BRCA1     S1   5.5
2    MYC     S1   2.0
(5, 4)
```

**Merge two tables (left join)**

```python
import pandas as pd
print(pd.read_csv("ids.tsv", sep="\t").merge(pd.read_csv("pvals.tsv", sep="\t", names=["gene", "p"]), on="gene", how="left"))
```

```text
     gene symbol      p
0  ENSG01   TP53  0.001
1  ENSG02  BRCA1    NaN
2  ENSG03    MYC  0.040
```

**Top-N per group**

```python
import pandas as pd
print(pd.read_csv("sample.csv").sort_values("value", ascending=False).groupby("group").head(2)[["group", "name", "value"]])
```

```text
   group         name  value
6  treat          eta   21.5
4  treat  epsilon, jr   18.0
1   ctrl         beta   12.0
7   ctrl        theta   11.0
```

**Z-score each row of an expression matrix**

```python
import pandas as pd
m = pd.read_csv("expression.tsv", sep="\t", index_col=0); print(m.sub(m.mean(1), axis=0).div(m.std(1), axis=0).round(2))
```

```text
         S1    S2    S3    S4
gene                         
TP53   0.89  0.84 -0.84 -0.89
BRCA1 -1.16  0.39  1.16 -0.39
MYC   -0.89 -0.84  0.91  0.82
GAPDH  0.10 -1.10  1.30 -0.30
EGFR  -0.91 -0.82  0.84  0.89
```

**Log2 fold change between two sample groups**

```python
import pandas as pd, numpy as np
m = pd.read_csv("expression.tsv", sep="\t", index_col=0); print(np.log2((m[["S3", "S4"]].mean(1) + 1) / (m[["S1", "S2"]].mean(1) + 1)).round(2).to_dict())
```

```text
{'TP53': -1.68, 'BRCA1': 0.04, 'MYC': 2.34, 'GAPDH': 0.02, 'EGFR': 2.99}
```

**Correlation matrix**

```python
import pandas as pd
print(pd.read_csv("expression.tsv", sep="\t", index_col=0).corr().round(2))
```

```text
      S1    S2    S3    S4
S1  1.00  1.00  0.36  0.35
S2  1.00  1.00  0.37  0.36
S3  0.36  0.37  1.00  1.00
S4  0.35  0.36  1.00  1.00
```

**Write to TSV without the index**

```python
import pandas as pd, sys
pd.read_csv("sample.csv").head(2).to_csv(sys.stdout, sep="\t", index=False)
```

```text
id	name	group	value	date
1	alpha	ctrl	10.5	2024-01-15
2	beta	ctrl	12.0	2024-01-20
```

**Concatenate every CSV in a folder, tagging the source**

```python
import pandas as pd; from pathlib import Path
print(pd.concat([pd.read_csv(p).assign(source=p.name) for p in sorted(Path("tree/data").glob("*.csv"))], ignore_index=True))
```

```text
   a  b source
0  1  2  a.csv
1  3  4  a.csv
2  5  6  b.csv
```

**Rename columns to snake_case**

```python
import pandas as pd, re
print(pd.DataFrame(columns=["Sample ID", "Gene Name", "logFC"]).rename(columns=lambda c: re.sub(r"(?<=[a-z])(?=[A-Z])|\s+", "_", c).lower()).columns.tolist())
```

```text
['sample_id', 'gene_name', 'log_fc']
```

---

## Text and strings

**Word frequency, top N**

```python
import re; from collections import Counter
print(Counter(re.findall(r"[a-z']+", "the cat and the hat and the bat".lower())).most_common(2))
```

```text
[('the', 3), ('and', 2)]
```

**Deduplicate lines, keeping their order**

```python
print(list(dict.fromkeys(["b", "a", "b", "c", "a"])))
```

```text
['b', 'a', 'c']
```

**Collapse runs of whitespace**

```python
print(" ".join("  too   many    spaces  ".split()))
```

```text
too many spaces
```

**Remove blank lines from text**

```python
print([l for l in open("notes.txt").read().splitlines() if l.strip()])
```

```text
['Contact alice@example.com or bob.smith@lab.org.', 'Call +1-555-123-4567 before 2026-10-15.', 'Server 10.0.0.5 and 256.1.1.1 (invalid)', 'Visit https://example.com/docs?id=42 today', 'TODO: fix   extra   spaces   ']
```

**`snake_case` ↔ `camelCase`**

```python
import re
to_snake = lambda s: re.sub(r"(?<!^)(?=[A-Z])", "_", s).lower(); to_camel = lambda s: s.split("_")[0] + "".join(w.title() for w in s.split("_")[1:])
print(to_snake("geneExpressionLevel"), to_camel("gene_expression_level"))
```

```text
gene_expression_level geneExpressionLevel
```

**Slugify a title**

```python
import re, unicodedata
slug = lambda s: re.sub(r"[^a-z0-9]+", "-", unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode().lower()).strip("-")
print(slug("Héllo, Wörld! Python One-Liners"))
```

```text
hello-world-python-one-liners
```

**Strip accents**

```python
import unicodedata
print("".join(c for c in unicodedata.normalize("NFD", "Crème brûlée à São Paulo") if unicodedata.category(c) != "Mn"))
```

```text
Creme brulee a Sao Paulo
```

**Wrap text to a width**

```python
import textwrap
print(textwrap.fill("Python one-liners are short programs that do a lot in a single expression.", width=30))
```

```text
Python one-liners are short
programs that do a lot in a
single expression.
```

**Center or pad a string**

```python
print(f"[{'title':^11}] [{'left':<6}] [{'right':>7}] [{42:05d}]")
```

```text
[   title   ] [left  ] [  right] [00042]
```

**Is it a palindrome (letters only)?**

```python
is_pal = lambda s: (t := [c.lower() for c in s if c.isalnum()]) == t[::-1]
print(is_pal("Was it a car or a cat I saw?"))
```

```text
True
```

**Character n-grams**

```python
print([("banana"[i:i + 3]) for i in range(len("banana") - 2)])
```

```text
['ban', 'ana', 'nan', 'ana']
```

**Caesar / ROT13**

```python
import codecs
print(codecs.encode("Hello, World", "rot13"), "".join(chr((ord(c) - 97 + 3) % 26 + 97) if c.islower() else c for c in "abc xyz"))
```

```text
Uryyb, Jbeyq def abc
```

**Count sentences, words and characters**

```python
import re
t = "One. Two words! Three words here?"; print(len(re.findall(r"[.!?]+", t)), len(t.split()), len(t))
```

```text
3 6 33
```

**Levenshtein edit distance (memoised)**

```python
from functools import cache
lev = cache(lambda a, b: len(a) + len(b) if not a or not b else min(lev(a[1:], b) + 1, lev(a, b[1:]) + 1, lev(a[1:], b[1:]) + (a[0] != b[0])))
print(lev("kitten", "sitting"), lev("GATTACA", "GCATGCU"))
```

```text
3 4
```

**Fuzzy match against a list of choices**

```python
import difflib
print(difflib.get_close_matches("BRAC1", ["BRCA1", "BRCA2", "TP53", "BRAF"], n=2))
```

```text
['BRCA1', 'BRAF']
```

**Line-by-line diff of two texts**

```python
import difflib
print("".join(difflib.unified_diff(["a\n", "b\n", "c\n"], ["a\n", "B\n", "c\n"], "old", "new")), end="")
```

```text
--- old
+++ new
@@ -1,3 +1,3 @@
 a
-b
+B
 c
```

**Translate or delete characters in one pass**

```python
print("2024-01-15".translate(str.maketrans("-", "/")), "(555) 123-4567".translate(str.maketrans("", "", "()- ")))
```

```text
2024/01/15 5551234567
```

---

## Regular expressions

**Extract email addresses**

```python
import re
print(re.findall(r"[\w.+-]+@[\w-]+(?:\.[\w-]+)+", open("notes.txt").read()))
```

```text
['alice@example.com', 'bob.smith@lab.org']
```

**Extract URLs**

```python
import re
print(re.findall(r"https?://[^\s)>\]]+", open("notes.txt").read()))
```

```text
['https://example.com/docs?id=42']
```

**Extract ISO dates**

```python
import re
print(re.findall(r"\b\d{4}-\d{2}-\d{2}\b", open("notes.txt").read()))
```

```text
['2026-10-15']
```

**Extract every number (ints, floats, negatives, exponents)**

```python
import re
print([float(x) for x in re.findall(r"[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?", "x=-3.5, y=42, z=1e-3, w=.5")])
```

```text
[-3.5, 42.0, 0.001, 0.5]
```

**Valid IPv4 addresses only, using `ipaddress` instead of a regex**

```python
import re, ipaddress
def ok(s):
    try: return bool(ipaddress.IPv4Address(s))
    except ValueError: return False
print([ip for ip in re.findall(r"\b\d{1,3}(?:\.\d{1,3}){3}\b", open("notes.txt").read()) if ok(ip)])
```

```text
['10.0.0.5']
```

**Named groups → dict (parse an access log line)**

```python
import re
rx = re.compile(r'(?P<ip>\S+) .*?\[(?P<ts>[^]]+)\] "(?P<method>\w+) (?P<path>\S+) [^"]*" (?P<status>\d{3}) (?P<bytes>\d+)')
print(rx.match(open("access.log").readline()).groupdict())
```

```text
{'ip': '192.168.1.10', 'ts': '01/Oct/2026:10:00:01 +0000', 'method': 'GET', 'path': '/index.html', 'status': '200', 'bytes': '1043'}
```

**Status-code counts from a log**

```python
import re; from collections import Counter
print(Counter(re.findall(r'" (\d{3}) ', open("access.log").read())))
```

```text
Counter({'200': 3, '401': 1, '404': 1, '304': 1})
```

**Split on several delimiters**

```python
import re
print(re.split(r"[;,|\s]+", "a, b;c |d  e"))
```

```text
['a', 'b', 'c', 'd', 'e']
```

**Replace using a function**

```python
import re
print(re.sub(r"\d+", lambda m: str(int(m.group()) * 2), "3 apples and 10 pears"))
```

```text
6 apples and 20 pears
```

**Overlapping matches (lookahead)**

```python
import re
print([m.start() for m in re.finditer(r"(?=ANA)", "BANANANA")])
```

```text
[1, 3, 5]
```

**Non-greedy vs greedy**

```python
import re
print(re.findall(r"<.+>", "<a><b>"), re.findall(r"<.+?>", "<a><b>"))
```

```text
['<a><b>'] ['<a>', '<b>']
```

**Password strength check with lookaheads**

```python
import re
strong = lambda p: bool(re.fullmatch(r"(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^\w\s]).{12,}", p))
print(strong("Tr0ub4dor&3xyz"), strong("password123"))
```

```text
True False
```

**Validate a whole string with `fullmatch` (not `match`)**

```python
import re
print(bool(re.match(r"\d{5}", "123456")), bool(re.fullmatch(r"\d{5}", "123456")))
```

```text
True False
```

**Case-insensitive search with an inline flag**

```python
import re
print(re.findall(r"(?i)\btodo\b", "TODO: fix; todo later; mastodon"))
```

```text
['TODO', 'todo']
```

**Back-references: find doubled words**

```python
import re
print(re.findall(r"\b(\w+)\s+\1\b", "this is is a test test of the the regex"))
```

```text
['is', 'test', 'the']
```

---

## Lambdas, sorting and functional tools

**Sort a dict by value, descending**

```python
d = {"TP53": 12, "MYC": 30, "EGFR": 7}
print(dict(sorted(d.items(), key=lambda kv: kv[1], reverse=True)))
```

```text
{'MYC': 30, 'TP53': 12, 'EGFR': 7}
```

**Sort by several keys (one descending)**

```python
rows = [("ctrl", 3), ("treat", 9), ("ctrl", 7), ("treat", 1)]
print(sorted(rows, key=lambda r: (r[0], -r[1])))
```

```text
[('ctrl', 7), ('ctrl', 3), ('treat', 9), ('treat', 1)]
```

**Natural sort (`chr2` before `chr10`)**

```python
import re
nat = lambda s: [int(t) if t.isdigit() else t.lower() for t in re.split(r"(\d+)", s)]
print(sorted(["chr10", "chr2", "chrX", "chr1", "chr22"], key=nat))
```

```text
['chr1', 'chr2', 'chr10', 'chr22', 'chrX']
```

**`itemgetter` and `attrgetter` instead of lambdas**

```python
from operator import itemgetter
print(sorted([{"n": "b", "v": 2}, {"n": "a", "v": 3}], key=itemgetter("v")), max([(1, "x"), (3, "y")], key=itemgetter(0)))
```

```text
[{'n': 'b', 'v': 2}, {'n': 'a', 'v': 3}] (3, 'y')
```

**`map`, `filter` and `reduce` together**

```python
from functools import reduce
print(reduce(lambda a, b: a * b, filter(lambda x: x % 2, map(lambda x: x + 1, range(6)))))
```

```text
15
```

**Compose functions**

```python
from functools import reduce
compose = lambda *fs: reduce(lambda f, g: lambda x: f(g(x)), fs)
print(compose(str.upper, str.strip, lambda s: s.replace("-", " "))("  one-liner  "))
```

```text
ONE LINER
```

**Partial application**

```python
from functools import partial
to_int2 = partial(int, base=2); print(to_int2("1011"), list(map(partial(round, ndigits=1), [1.26, 3.14159])))
```

```text
11 [1.3, 3.1]
```

**Memoise a recursive lambda with `cache`**

```python
from functools import cache
fib = cache(lambda n: n if n < 2 else fib(n - 1) + fib(n - 2)); print(fib(90))
```

```text
2880067194370816120
```

**Immediately-invoked lambda**

```python
print((lambda x, y: x ** y)(2, 10))
```

```text
1024
```

**Conditional expression inside a lambda**

```python
grade = lambda s: "A" if s >= 90 else "B" if s >= 80 else "C" if s >= 70 else "F"
print([grade(s) for s in (95, 85, 72, 40)])
```

```text
['A', 'B', 'C', 'F']
```

**`max`/`min` with a key**

```python
words = ["kiwi", "banana", "fig", "cherry"]
print(max(words, key=len), min(words, key=lambda w: (len(w), w)))
```

```text
banana fig
```

**`argmax` / `argmin` without numpy**

```python
v = [3, 9, 2, 9, 5]
print(max(range(len(v)), key=v.__getitem__), min(range(len(v)), key=v.__getitem__))
```

```text
1 2
```

**Apply a function to every value in a dict**

```python
print({k: round(v ** 0.5, 2) for k, v in {"a": 4, "b": 10}.items()})
```

```text
{'a': 2.0, 'b': 3.16}
```

**Timing wrapper as a lambda (the walrus keeps the start time)**

<!-- nondeterministic -->
```python
import time
timed = lambda f: lambda *a, **k: (t := time.perf_counter(), r := f(*a, **k), print(f"{f.__name__}: {time.perf_counter() - t:.2e} s"), r)[-1]
print(timed(sorted)(range(100_000, 0, -1))[:3])
```

```text
sorted: 6.63e-03 s
[1, 2, 3]
```

---

## Collections and itertools

**Flatten one level / any depth**

```python
from itertools import chain
deep = lambda x: [z for y in x for z in (deep(y) if isinstance(y, list) else [y])]
print(list(chain.from_iterable([[1, 2], [3], [4, 5]])), deep([1, [2, [3, [4]], 5]]))
```

```text
[1, 2, 3, 4, 5] [1, 2, 3, 4, 5]
```

**Chunk a list into batches (3.12+ `batched`)**

```python
from itertools import batched
print(list(batched(range(10), 4)))
```

```text
[(0, 1, 2, 3), (4, 5, 6, 7), (8, 9)]
```

**Sliding window (pairs and n-wide)**

```python
from itertools import pairwise, islice
win = lambda s, n: zip(*(islice(s, i, None) for i in range(n)))
print(list(pairwise([1, 2, 3, 4])), list(win([1, 2, 3, 4, 5], 3)))
```

```text
[(1, 2), (2, 3), (3, 4)] [(1, 2, 3), (2, 3, 4), (3, 4, 5)]
```

**Run-length encoding**

```python
from itertools import groupby
print([(k, len(list(g))) for k, g in groupby("AAABBCAAA")], "".join(f"{len(list(g))}{k}" for k, g in groupby("AAABBCAAA")))
```

```text
[('A', 3), ('B', 2), ('C', 1), ('A', 3)] 3A2B1C3A
```

**Invert a dict (values become keys)**

```python
print({v: k for k, v in {"a": 1, "b": 2}.items()})
```

```text
{1: 'a', 2: 'b'}
```

**Invert a one-to-many dict**

```python
from collections import defaultdict
inv = defaultdict(list); [inv[v].append(k) for k, v in {"TP53": "chr17", "BRCA1": "chr17", "MYC": "chr8"}.items()]; print(dict(inv))
```

```text
{'chr17': ['TP53', 'BRCA1'], 'chr8': ['MYC']}
```

**Merge dicts (later keys win)**

```python
print({"a": 1, "b": 2} | {"b": 9, "c": 3})
```

```text
{'a': 1, 'b': 9, 'c': 3}
```

**Merge dicts by summing values**

```python
from collections import Counter
print(Counter({"a": 1, "b": 2}) + Counter({"b": 3, "c": 4}))
```

```text
Counter({'b': 5, 'c': 4, 'a': 1})
```

**Zip two lists into a dict**

```python
print(dict(zip(["gene", "chrom", "start"], ["TP53", "chr17", 7661779])))
```

```text
{'gene': 'TP53', 'chrom': 'chr17', 'start': 7661779}
```

**Unzip (transpose) a list of pairs**

```python
print(list(zip(*[("a", 1), ("b", 2), ("c", 3)])))
```

```text
[('a', 'b', 'c'), (1, 2, 3)]
```

**Every combination, permutation, product**

```python
from itertools import combinations, permutations, product
print(list(combinations("ABC", 2)), len(list(permutations("ABCD"))), ["".join(p) for p in product("01", repeat=3)])
```

```text
[('A', 'B'), ('A', 'C'), ('B', 'C')] 24 ['000', '001', '010', '011', '100', '101', '110', '111']
```

**All 16 dinucleotides**

```python
from itertools import product
print(["".join(p) for p in product("ACGT", repeat=2)])
```

```text
['AA', 'AC', 'AG', 'AT', 'CA', 'CC', 'CG', 'CT', 'GA', 'GC', 'GG', 'GT', 'TA', 'TC', 'TG', 'TT']
```

**Cumulative sum and running max**

```python
from itertools import accumulate
print(list(accumulate([3, 1, 4, 1, 5])), list(accumulate([3, 1, 4, 1, 5], max)))
```

```text
[3, 4, 8, 9, 14] [3, 3, 4, 4, 5]
```

**Get with a default, and a nested get**

```python
d = {"a": {"b": {"c": 42}}}
from functools import reduce
print(d.get("x", "missing"), reduce(lambda acc, k: (acc or {}).get(k), ["a", "b", "c"], d))
```

```text
missing 42
```

**Count with `Counter` and take the top N**

```python
from collections import Counter
print(Counter("mississippi").most_common(2))
```

```text
[('i', 4), ('s', 4)]
```

**Fixed-size history with `deque`**

```python
from collections import deque
q = deque(maxlen=3); [q.append(i) for i in range(6)]; print(list(q))
```

```text
[3, 4, 5]
```

**Named tuple record**

```python
from collections import namedtuple
Gene = namedtuple("Gene", "symbol chrom start"); g = Gene("TP53", "chr17", 7661779); print(g.symbol, g._asdict())
```

```text
TP53 {'symbol': 'TP53', 'chrom': 'chr17', 'start': 7661779}
```

**Interleave lists**

```python
from itertools import chain, zip_longest
print([x for x in chain.from_iterable(zip_longest([1, 2, 3], "ab")) if x is not None])
```

```text
[1, 'a', 2, 'b', 3]
```

**Remove items from a list in place, safely**

```python
xs = [1, 2, 3, 4, 5, 6]; xs[:] = [x for x in xs if x % 3]; print(xs)
```

```text
[1, 2, 4, 5]
```

---

## Maths and number theory

**GCD, LCM, factorial, combinations, permutations**

```python
import math
print(math.gcd(84, 36), math.lcm(4, 6, 10), math.factorial(10), math.comb(52, 5), math.perm(10, 3))
```

```text
12 60 3628800 2598960 720
```

**Product of a list**

```python
import math
print(math.prod([1, 2, 3, 4, 5]))
```

```text
120
```

**Sieve of Eratosthenes**

```python
n = 50; s = bytearray([1]) * (n + 1); s[:2] = b"\0\0"; [s.__setitem__(slice(i*i, n+1, i), bytes(len(range(i*i, n+1, i)))) for i in range(2, int(n**0.5) + 1) if s[i]]
print([i for i in range(n + 1) if s[i]])
```

```text
[2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
```

**Primality (trial division)**

```python
is_prime = lambda n: n > 1 and all(n % d for d in range(2, int(n**0.5) + 1))
print([n for n in range(30) if is_prime(n)], is_prime(7919))
```

```text
[2, 3, 5, 7, 11, 13, 17, 19, 23, 29] True
```

**Prime factorisation**

```python
def pf(n, d=2, out=()):
    while d * d <= n and n % d: d += 1
    return [*out, n] if d * d > n else pf(n // d, d, (*out, d))
print(pf(360), pf(97), pf(600851475143))
```

```text
[2, 2, 2, 3, 3, 5] [97] [71, 839, 1471, 6857]
```

**All divisors**

```python
divs = lambda n: sorted({d for i in range(1, int(n**0.5) + 1) if n % i == 0 for d in (i, n // i)})
print(divs(36))
```

```text
[1, 2, 3, 4, 6, 9, 12, 18, 36]
```

**Integer square root (exact for huge ints)**

```python
import math
print(math.isqrt(10**30 + 1), math.isqrt(99))
```

```text
1000000000000000 9
```

**Digit sum and digital root**

```python
n = 98765
print(sum(map(int, str(n))), 1 + (n - 1) % 9)
```

```text
35 8
```

**Base conversion, both ways**

```python
print(bin(42), oct(42), hex(42), int("101010", 2), int("ff", 16), int("z", 36), format(42, "08b"))
```

```text
0b101010 0o52 0x2a 42 255 35 00101010
```

**Any integer to any base (2–36)**

```python
import string
to_base = lambda n, b: "0" if n == 0 else to_base(n // b, b).lstrip("0") + (string.digits + string.ascii_lowercase)[n % b]
print(to_base(255, 2), to_base(255, 16), to_base(123456789, 36))
```

```text
11111111 ff 21i3v9
```

**Exact fractions and decimals**

```python
from fractions import Fraction; from decimal import Decimal, getcontext
getcontext().prec = 30; print(Fraction(1, 3) + Fraction(1, 6), 0.1 + 0.2, Decimal("0.1") + Decimal("0.2"), Decimal(1) / Decimal(7))
```

```text
1/2 0.30000000000000004 0.3 0.142857142857142857142857142857
```

**Compare floats safely**

```python
import math
print(0.1 + 0.2 == 0.3, math.isclose(0.1 + 0.2, 0.3))
```

```text
False True
```

**Rounding: banker's vs half-up**

```python
from decimal import Decimal, ROUND_HALF_UP
print(round(2.5), round(3.5), Decimal("2.5").quantize(Decimal("1"), rounding=ROUND_HALF_UP))
```

```text
2 4 3
```

**Euclidean distance and hypotenuse in n dimensions**

```python
import math
print(math.dist((0, 0, 0), (1, 2, 2)), math.hypot(3, 4))
```

```text
3.0 5.0
```

**Dot product, matrix multiply, transpose (pure Python)**

```python
A = [[1, 2], [3, 4]]; B = [[5, 6], [7, 8]]
print(sum(x * y for x, y in zip([1, 2, 3], [4, 5, 6])), [[sum(a * b for a, b in zip(r, c)) for c in zip(*B)] for r in A], list(map(list, zip(*A))))
```

```text
32 [[19, 22], [43, 50]] [[1, 3], [2, 4]]
```

**Clamp a value into a range**

```python
clamp = lambda x, lo, hi: max(lo, min(x, hi))
print(clamp(15, 0, 10), clamp(-3, 0, 10), clamp(5, 0, 10))
```

```text
10 0 5
```

**Linear interpolation and rescaling**

```python
lerp = lambda a, b, t: a + (b - a) * t; rescale = lambda x, a, b, c, d: c + (x - a) * (d - c) / (b - a)
print(lerp(10, 20, 0.25), rescale(50, 0, 100, -1, 1))
```

```text
12.5 0.0
```

**Compound interest and loan payment**

```python
P, r, n, years = 10_000, 0.05, 12, 10
print(round(P * (1 + r / n) ** (n * years), 2), round(P * (r / 12) / (1 - (1 + r / 12) ** -(12 * years)), 2))
```

```text
16470.09 106.07
```

**Percentage change**

```python
pct = lambda old, new: round((new - old) / old * 100, 2)
print(pct(80, 100), pct(100, 80))
```

```text
25.0 -20.0
```

**Newton's method square root**

```python
from functools import reduce
print(reduce(lambda x, _: (x + 2 / x) / 2, range(6), 1.0))
```

```text
1.414213562373095
```

**Estimate π (Leibniz series, 10⁶ terms)**

```python
print(4 * sum((-1) ** k / (2 * k + 1) for k in range(10**6)))
```

```text
3.1415916535897934
```

**Pascal's triangle**

```python
import math
print(*([math.comb(n, k) for k in range(n + 1)] for n in range(6)), sep="\n")
```

```text
[1]
[1, 1]
[1, 2, 1]
[1, 3, 3, 1]
[1, 4, 6, 4, 1]
[1, 5, 10, 10, 5, 1]
```

**Fibonacci up to N (iterative)**

```python
a, b, out = 0, 1, []
while a < 100: out.append(a); a, b = b, a + b
print(out)
```

```text
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
```

**Collatz steps**

```python
steps = lambda n: 0 if n == 1 else 1 + steps(n // 2 if n % 2 == 0 else 3 * n + 1)
print(steps(27), max(range(1, 1000), key=steps))
```

```text
111 871
```

**Numerical derivative and integral**

```python
import math
f = math.sin; h = 1e-6; n = 10_000
print(round((f(1 + h) - f(1 - h)) / (2 * h), 6), round(sum(f(i * math.pi / n) for i in range(n)) * math.pi / n, 6))
```

```text
0.540302 2.0
```

**Solve a quadratic**

```python
import cmath
roots = lambda a, b, c: ((-b + cmath.sqrt(b*b - 4*a*c)) / (2*a), (-b - cmath.sqrt(b*b - 4*a*c)) / (2*a))
print(roots(1, -3, 2), roots(1, 2, 5))
```

```text
((2+0j), (1-0j)) ((-1+2j), (-1-2j))
```

---

## Statistics

**Mean, median, mode, sample SD and variance**

```python
import statistics as st
x = [2, 4, 4, 4, 5, 5, 7, 9]; print(st.mean(x), st.median(x), st.mode(x), round(st.stdev(x), 4), round(st.pvariance(x), 4))
```

```text
5 4.5 4 2.1381 4
```

**Quartiles and IQR**

```python
import statistics as st
q = st.quantiles([1, 3, 5, 7, 9, 11, 13, 15], n=4); print(q, q[2] - q[0])
```

```text
[3.5, 8.0, 12.5] 9.0
```

**Geometric and harmonic mean**

```python
import statistics as st
print(round(st.geometric_mean([1, 2, 4, 8]), 4), st.harmonic_mean([40, 60]))
```

```text
2.8284 48.0
```

**Z-scores**

```python
import statistics as st
x = [10, 12, 23, 23, 16, 23, 21, 16]; m, s = st.mean(x), st.stdev(x); print([round((v - m) / s, 2) for v in x])
```

```text
[-1.53, -1.15, 0.95, 0.95, -0.38, 0.95, 0.57, -0.38]
```

**Min-max normalisation**

```python
x = [3, 7, 10, 15]; print([round((v - min(x)) / (max(x) - min(x)), 3) for v in x])
```

```text
[0.0, 0.333, 0.583, 1.0]
```

**Pearson correlation and linear regression (3.10+)**

```python
import statistics as st
x = [1, 2, 3, 4, 5]; y = [2.1, 3.9, 6.2, 7.8, 10.1]; print(round(st.correlation(x, y), 4), st.linear_regression(x, y))
```

```text
0.9987 LinearRegression(slope=1.9899999999999998, intercept=0.0500000000000016)
```

**Spearman rank correlation (3.12+)**

```python
import statistics as st
print(st.correlation([1, 2, 3, 4, 5], [5, 6, 7, 8, 7], method="ranked"))
```

```text
0.8207826816681233
```

**Moving average**

```python
x = [1, 2, 3, 4, 5, 6, 7]; k = 3
print([round(sum(x[i:i + k]) / k, 2) for i in range(len(x) - k + 1)])
```

```text
[2.0, 3.0, 4.0, 5.0, 6.0]
```

**Weighted mean**

```python
vals, w = [80, 90, 70], [0.2, 0.5, 0.3]
print(sum(v * wi for v, wi in zip(vals, w)) / sum(w))
```

```text
82.0
```

**Outliers by the IQR rule**

```python
import statistics as st
x = [10, 12, 11, 13, 12, 95, 11, 14, -40]; q1, _, q3 = st.quantiles(x, n=4); i = q3 - q1
print([v for v in x if v < q1 - 1.5 * i or v > q3 + 1.5 * i])
```

```text
[95, -40]
```

**Normal distribution: CDF, inverse CDF, overlap**

```python
from statistics import NormalDist
z = NormalDist(); print(round(z.cdf(1.96), 4), round(z.inv_cdf(0.975), 4), round(NormalDist(0, 1).overlap(NormalDist(1, 1)), 4))
```

```text
0.975 1.96 0.6171
```

**95% confidence interval of a mean (t-based, scipy)**

```python
import statistics as st; from scipy import stats
x = [5.1, 4.9, 5.6, 5.8, 6.0, 5.2, 5.5]; m, se = st.mean(x), st.stdev(x) / len(x) ** 0.5; t = stats.t.ppf(0.975, len(x) - 1); print(round(m - t * se, 3), round(m + t * se, 3))
```

```text
5.077 5.808
```

> [!WARNING]
> With n = 7, using z = 1.96 instead of t(0.975, 6) = 2.447 gives an interval that is too narrow (about 88% coverage instead of 95%).

**Two-sample t-test and Mann–Whitney U**

```python
from scipy import stats
a = [5.1, 4.9, 5.6, 5.8, 6.0]; b = [6.5, 6.9, 7.1, 6.4, 7.0]; print(stats.ttest_ind(a, b, equal_var=False).pvalue.round(6), stats.mannwhitneyu(a, b).pvalue.round(4))
```

```text
0.001281 0.0079
```

**Benjamini–Hochberg FDR (pure Python)**

```python
p = [0.01, 0.04, 0.03, 0.005, 0.2]; n = len(p); o = sorted(range(n), key=p.__getitem__); q = [0.0] * n; m = 1.0
for r, i in reversed(list(enumerate(o, 1))): m = min(m, p[i] * n / r); q[i] = round(m, 4)
print(q)
```

```text
[0.025, 0.05, 0.05, 0.025, 0.2]
```

**Benjamini–Hochberg, cross-checked with scipy**

```python
from scipy.stats import false_discovery_control
print(false_discovery_control([0.01, 0.04, 0.03, 0.005, 0.2]).round(4).tolist())
```

```text
[0.025, 0.05, 0.05, 0.025, 0.2]
```

**Bonferroni correction**

```python
p = [0.01, 0.04, 0.03, 0.005, 0.2]; print([min(1, x * len(p)) for x in p])
```

```text
[0.05, 0.2, 0.15, 0.025, 1]
```

**Chi-square goodness of fit (fair die?)**

```python
from scipy.stats import chisquare
print(chisquare([16, 18, 16, 14, 12, 24]))
```

```text
Power_divergenceResult(statistic=np.float64(5.119999999999999), pvalue=np.float64(0.4014115932460956))
```

**Bootstrap CI of the median (seeded)**

```python
import random, statistics as st
random.seed(1); x = [3, 5, 7, 8, 9, 12, 13, 15, 18, 21]; b = sorted(st.median(random.choices(x, k=len(x))) for _ in range(5000)); print(b[125], b[4874])
```

```text
6.5 15.5
```

---

## numpy one-liners

**Create and reshape**

```python
import numpy as np
print(np.arange(12).reshape(3, 4))
```

```text
[[ 0  1  2  3]
 [ 4  5  6  7]
 [ 8  9 10 11]]
```

**Boolean mask filtering**

```python
import numpy as np
a = np.array([3, -1, 7, 0, -5, 9]); print(a[a > 0], np.where(a < 0, 0, a))
```

```text
[3 7 9] [3 0 7 0 0 9]
```

**Column means, row sums, argmax**

```python
import numpy as np
m = np.array([[1, 5, 3], [4, 2, 6]]); print(m.mean(axis=0), m.sum(axis=1), m.argmax(), np.unravel_index(m.argmax(), m.shape))
```

```text
[2.5 3.5 4.5] [ 9 12] 5 (np.int64(1), np.int64(2))
```

**Standardise columns**

```python
import numpy as np
m = np.array([[1.0, 10], [2, 20], [3, 30]]); print(((m - m.mean(0)) / m.std(0, ddof=1)).round(3))
```

```text
[[-1. -1.]
 [ 0.  0.]
 [ 1.  1.]]
```

**Solve a linear system Ax = b**

```python
import numpy as np
print(np.linalg.solve([[3, 1], [1, 2]], [9, 8]))
```

```text
[2. 3.]
```

**Eigenvalues, determinant, inverse**

```python
import numpy as np
A = np.array([[2.0, 1], [1, 3]]); print(np.linalg.eigvalsh(A).round(4), round(np.linalg.det(A), 4), np.linalg.inv(A).round(3).tolist())
```

```text
[1.382 3.618] 5.0 [[0.6, -0.2], [-0.2, 0.4]]
```

**Pairwise distance matrix (broadcasting)**

```python
import numpy as np
P = np.array([[0, 0], [3, 4], [6, 8]]); print(np.sqrt(((P[:, None] - P[None]) ** 2).sum(-1)))
```

```text
[[ 0.  5. 10.]
 [ 5.  0.  5.]
 [10.  5.  0.]]
```

**Histogram counts**

```python
import numpy as np
print(np.histogram([1, 2, 2, 3, 3, 3, 4, 4, 5], bins=4))
```

```text
(array([1, 2, 3, 3]), array([1., 2., 3., 4., 5.]))
```

**Polynomial fit**

```python
import numpy as np
print(np.polyfit([0, 1, 2, 3], [1, 3, 7, 13], 2).round(6))
```

```text
[1. 1. 1.]
```

**Seeded random generator (the modern API)**

```python
import numpy as np
rng = np.random.default_rng(42); print(rng.integers(0, 10, 5), rng.normal(size=2).round(3))
```

```text
[0 7 6 4 4] [ 0.941 -1.951]
```

**Unique values with counts**

```python
import numpy as np
print(np.unique(["a", "b", "a", "c", "a"], return_counts=True))
```

```text
(array(['a', 'b', 'c'], dtype='<U1'), array([3, 1, 1]))
```

**One-hot encode a DNA sequence**

```python
import numpy as np
s = "ACGTN"; print((np.array(list(s))[:, None] == np.array(list("ACGT"))).astype(int))
```

```text
[[1 0 0 0]
 [0 1 0 0]
 [0 0 1 0]
 [0 0 0 1]
 [0 0 0 0]]
```

---

## Bioinformatics — sequences

**Reverse complement (IUPAC-aware, case-preserving)**

```python
rc = lambda s: s.translate(str.maketrans("ACGTRYKMBVDHNacgtrykmbvdhn", "TGCAYRMKVBHDNtgcayrmkvbhdn"))[::-1]
print(rc("ATGCRYNacgt"))
```

```text
acgtNRYGCAT
```

**GC content (ignoring N)**

```python
s = "ATGCGCNNAT"; print(round(100 * sum(c in "GCgc" for c in s) / sum(c in "ACGTacgt" for c in s), 2))
```

```text
50.0
```

**Transcription and back-transcription (coding strand)**

```python
print("ATGGCCTAA".replace("T", "U"), "AUGGCCUAA".replace("U", "T"))
```

```text
AUGGCCUAA ATGGCCTAA
```

**Build the standard codon table in one line**

```python
bases = "TCAG"; aas = "FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG"
table = {a + b + c: aa for (a, b, c), aa in zip(((a, b, c) for a in bases for b in bases for c in bases), aas)}; print(len(table), table["ATG"], table["TAA"], table["TGG"])
```

```text
64 M * W
```

**Translate DNA → protein**

```python
b = "TCAG"; aas = "FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG"; T = {x + y + z: aas[16 * b.index(x) + 4 * b.index(y) + b.index(z)] for x in b for y in b for z in b}
print("".join(T.get("ATGGCGTACGTTAGCTAA"[i:i + 3], "X") for i in range(0, 18 - 2, 3)))
```

```text
MAYVS*
```

**All six reading frames**

```python
b = "TCAG"; aas = "FFLLSSSSYY**CC*WLLLLPPPPHHQQRRRRIIIMTTTTNNKKSSRRVVVVAAAADDEEGGGG"; T = {x + y + z: aas[16 * b.index(x) + 4 * b.index(y) + b.index(z)] for x in b for y in b for z in b}
s = "ATGGCGTACGTTAGCTAA"; rc = s.translate(str.maketrans("ACGT", "TGCA"))[::-1]
print({f"{strand}{f + 1}": "".join(T[q[i:i + 3]] for i in range(f, len(q) - 2, 3)) for strand, q in (("+", s), ("-", rc)) for f in range(3)})
```

```text
{'+1': 'MAYVS*', '+2': 'WRTLA', '+3': 'GVR*L', '-1': 'LANVRH', '-2': '*LTYA', '-3': 'S*RTP'}
```

**Find ORFs (ATG … stop, same frame)**

```python
import re
print([(m.start(), m.group(1)) for m in re.finditer(r"(?=(ATG(?:[ACGT]{3})*?(?:TAA|TAG|TGA)))", "CCATGAAATTTTAGGATGCCCTGACC")])
```

```text
[(2, 'ATGAAATTTTAG'), (15, 'ATGCCCTGA')]
```

**Count k-mers**

```python
from collections import Counter
s, k = "ATGATGATCC", 3; print(Counter(s[i:i + k] for i in range(len(s) - k + 1)).most_common(3))
```

```text
[('ATG', 2), ('TGA', 2), ('GAT', 2)]
```

**Motif positions, overlapping, 1-based**

```python
import re
print([m.start() + 1 for m in re.finditer(r"(?=ATA)", "GATATATGCATATACTT")])
```

```text
[2, 4, 10, 12]
```

**Hamming distance and point mutations**

```python
a, b = "GAGCCTACTAACGGGAT", "CATCGTAATGACGGCCT"; print(sum(x != y for x, y in zip(a, b)), [(i + 1, x, y) for i, (x, y) in enumerate(zip(a, b)) if x != y][:3])
```

```text
7 [(1, 'G', 'C'), (3, 'G', 'T'), (5, 'C', 'G')]
```

**Transition/transversion classification**

```python
kind = lambda r, a: "Ti" if {r, a} in ({"A", "G"}, {"C", "T"}) else "Tv"
print([kind(r, a) for r, a in [("A", "G"), ("C", "T"), ("A", "C"), ("G", "T")]])
```

```text
['Ti', 'Ti', 'Tv', 'Tv']
```

**CpG observed/expected ratio**

```python
s = "CGCGATCGGACGTTACG"; print(round(s.count("CG") * len(s) / (s.count("C") * s.count("G")), 3))
```

```text
2.833
```

**Melting temperature: Wallace rule (≤ 14 nt) and basic GC formula**

```python
s = "AGCGGATAACAATTTC"; gc = sum(c in "GC" for c in s); at = len(s) - gc
print(2 * at + 4 * gc, round(64.9 + 41 * (gc - 16.4) / len(s), 1))
```

```text
44 38.3
```

**Sliding-window GC content**

```python
s, w, step = "ATGCGCGCATATATGCGCAA", 8, 4
print([(i, round(sum(c in "GC" for c in s[i:i + w]) / w, 2)) for i in range(0, len(s) - w + 1, step)])
```

```text
[(0, 0.75), (4, 0.5), (8, 0.25), (12, 0.5)]
```

**Approximate protein molecular weight (average residue masses)**

```python
m = dict(A=71.0788, R=156.1875, N=114.1038, D=115.0886, C=103.1388, E=129.1155, Q=128.1307, G=57.0519, H=137.1411, I=113.1594, L=113.1594, K=128.1741, M=131.1926, F=147.1766, P=97.1167, S=87.0782, T=101.1051, W=186.2132, Y=163.1760, V=99.1326)
print(round(sum(m[a] for a in "MAGIC") + 18.0153, 2))
```

```text
493.64
```

**Codon usage of a CDS**

```python
from collections import Counter
s = "ATGGCTGCAGCTAAATAA"; print(Counter(s[i:i + 3] for i in range(0, len(s) - 2, 3)))
```

```text
Counter({'GCT': 2, 'ATG': 1, 'GCA': 1, 'AAA': 1, 'TAA': 1})
```

**Consensus sequence from aligned reads**

```python
from collections import Counter
aln = ["ATCCAGCT", "GGGCAACT", "ATGGATCT", "AAGCAACC", "TTGGAACT", "ATGCCATT", "ATGGCACT"]
print("".join(Counter(col).most_common(1)[0][0] for col in zip(*aln)))
```

```text
ATGCAACT
```

**Phred quality string → scores and error probabilities**

```python
q = "II5+#!"; print([ord(c) - 33 for c in q], [f"{10 ** (-(ord(c) - 33) / 10):.0e}" for c in q])
```

```text
[40, 40, 20, 10, 2, 0] ['1e-04', '1e-04', '1e-02', '1e-01', '6e-01', '1e+00']
```

**Random DNA (seeded) and shuffle preserving composition**

```python
import random
random.seed(7); s = "".join(random.choices("ACGT", k=20)); print(s, "".join(random.sample(s, len(s))))
```

```text
CAGAGCAGACAACTAAGTGC GATGCAGAGAGCTCACAAAC
```

**Expand IUPAC ambiguity codes to every concrete sequence**

```python
from itertools import product
iu = dict(A="A", C="C", G="G", T="T", R="AG", Y="CT", S="GC", W="AT", K="GT", M="AC", N="ACGT")
print(["".join(p) for p in product(*(iu[c] for c in "ARY"))])
```

```text
['AAC', 'AAT', 'AGC', 'AGT']
```

**Restriction site search (EcoRI `GAATTC`), 0-based cut positions**

```python
import re
print([m.start() + 1 for m in re.finditer("GAATTC", "AAGAATTCTTGGAATTCAA")])
```

```text
[3, 12]
```

---

## Bioinformatics — file formats

**Parse FASTA into a dict (multi-line records)**

```python
fa, name = {}, None
for l in open("sample.fasta"):
    if l.startswith(">"): name = l[1:].split()[0]; fa[name] = ""
    else: fa[name] += l.strip()
print({k: len(v) for k, v in fa.items()})
```

```text
{'seq1': 64, 'seq2': 13, 'seq3': 44, 'seq4': 30}
```

> [!TIP]
> The idiomatic one-liner for the same thing uses `itertools.groupby`:

```python
from itertools import groupby
g = [list(x) for _, x in groupby(open("sample.fasta"), key=lambda l: l.startswith(">"))]
fa = {h[-1][1:].split()[0]: "".join(map(str.strip, s)) for h, s in zip(g[::2], g[1::2])}
print({k: len(v) for k, v in fa.items()})
```

```text
{'seq1': 64, 'seq2': 13, 'seq3': 44, 'seq4': 30}
```

**Sequence lengths, total, mean**

```python
from itertools import groupby
L = [sum(len(l.strip()) for l in g) for hdr, g in groupby(open("sample.fasta"), key=lambda l: l.startswith(">")) if not hdr]
print(L, sum(L), sum(L) / len(L))
```

```text
[64, 13, 44, 30] 151 37.75
```

**N50**

```python
from itertools import groupby, accumulate
L = sorted((sum(len(l.strip()) for l in g) for h, g in groupby(open("sample.fasta"), key=lambda l: l.startswith(">")) if not h), reverse=True)
print(next(l for l, c in zip(L, accumulate(L)) if c >= sum(L) / 2))
```

```text
44
```

**GC% per FASTA record**

```python
from itertools import groupby
g = [list(x) for _, x in groupby(open("sample.fasta"), key=lambda l: l.startswith(">"))]
print({h[-1][1:].split()[0]: round(100 * sum(map(s.count, "GC")) / len(s), 1) for h, s in ((h, "".join(map(str.strip, s))) for h, s in zip(g[::2], g[1::2]))})
```

```text
{'seq1': 51.6, 'seq2': 30.8, 'seq3': 88.6, 'seq4': 0.0}
```

**Linearise FASTA (one line per sequence)**

```python
from itertools import groupby
g = [list(x) for _, x in groupby(open("sample.fasta"), key=lambda l: l.startswith(">"))]
print("\n".join(f"{h[-1].strip()}\n{''.join(map(str.strip, s))}" for h, s in zip(g[::2], g[1::2])))
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

**Count FASTQ reads, total bases, mean quality per read**

```python
from itertools import batched
recs = list(batched(map(str.strip, open("sample.fastq")), 4))
print(len(recs), sum(len(r[1]) for r in recs), {r[0][1:].split()[0]: round(sum(ord(c) - 33 for c in r[3]) / len(r[3]), 1) for r in recs})
```

```text
4 76 {'read1': 40.0, 'read2': 20.5, 'read3': 10.0, 'read4': 40.0}
```

**Filter FASTQ by mean quality ≥ 30 and length ≥ 10**

```python
from itertools import batched
print([r[0].split()[0] for r in batched(map(str.strip, open("sample.fastq")), 4) if len(r[1]) >= 10 and sum(ord(c) - 33 for c in r[3]) / len(r[3]) >= 30])
```

```text
['@read1', '@read4']
```

**FASTQ → FASTA**

```python
from itertools import batched
print("".join(f">{h[1:]}\n{s}\n" for h, s, _, _ in batched(map(str.strip, open("sample.fastq")), 4)), end="")
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

**VCF: variants per chromosome**

```python
from collections import Counter
print(Counter(l.split("\t")[0] for l in open("sample.vcf") if not l.startswith("#")))
```

```text
Counter({'chr1': 4, 'chr2': 4})
```

**VCF: SNPs vs indels, PASS only**

```python
from collections import Counter
print(Counter("SNP" if len(f[3]) == 1 and all(len(a) == 1 for a in f[4].split(",")) else "INDEL" for f in (l.split("\t") for l in open("sample.vcf") if not l.startswith("#")) if f[6] == "PASS"))
```

```text
Counter({'SNP': 4, 'INDEL': 2})
```

**VCF: Ti/Tv ratio of biallelic SNPs**

```python
snps = [(f[3], f[4]) for f in (l.split("\t") for l in open("sample.vcf") if not l.startswith("#")) if len(f[3]) == len(f[4]) == 1]
ti = sum({r, a} in ({"A", "G"}, {"C", "T"}) for r, a in snps); print(ti, len(snps) - ti, round(ti / (len(snps) - ti), 2))
```

```text
4 1 4.0
```

**VCF: parse INFO into a dict**

```python
line = next(l for l in open("sample.vcf") if not l.startswith("#"))
print(dict(kv.split("=") if "=" in kv else (kv, True) for kv in line.split("\t")[7].split(";")))
```

```text
{'DP': '30', 'AF': '0.5'}
```

**VCF: filter by QUAL and DP**

```python
print([f"{f[0]}:{f[1]}" for f in (l.split("\t") for l in open("sample.vcf") if not l.startswith("#")) if float(f[5]) >= 30 and int(dict(x.split("=") for x in f[7].split(";"))["DP"]) >= 20])
```

```text
['chr1:100', 'chr1:300', 'chr1:420', 'chr2:50', 'chr2:200']
```

**VCF: genotype counts for one sample**

```python
from collections import Counter
print(Counter(l.rstrip("\n").split("\t")[9] for l in open("sample.vcf") if not l.startswith("#")))
```

```text
Counter({'0/1': 5, '1/1': 1, '0/0': 1, '1/2': 1})
```

**BED: total bases covered, per chromosome**

```python
from collections import Counter
c = Counter(); [c.update({f[0]: int(f[2]) - int(f[1])}) for f in (l.split("\t") for l in open("sample.bed"))]; print(dict(c))
```

```text
{'chr1': 250, 'chr2': 120}
```

**BED: merge overlapping intervals**

```python
from itertools import groupby
iv = sorted((f[0], int(f[1]), int(f[2])) for f in (l.split("\t") for l in open("sample.bed"))); out = []
[out.append([c, s, e]) if not out or out[-1][0] != c or s > out[-1][2] else out[-1].__setitem__(2, max(out[-1][2], e)) for c, s, e in iv]; print(out)
```

```text
[['chr1', 100, 250], ['chr1', 400, 450], ['chr2', 10, 110], ['chr2', 500, 520]]
```

**BED (0-based, half-open) ↔ 1-based closed region strings**

```python
print([f"{f[0]}:{int(f[1]) + 1}-{f[2]}" for f in (l.split("\t") for l in open("sample.bed"))][:3])
```

```text
['chr1:101-200', 'chr1:151-250', 'chr1:401-450']
```

**GFF3: list genes with their Name attribute**

```python
print([(f[0], f[3], f[4], f[6], dict(a.split("=") for a in f[8].strip().split(";"))["Name"]) for f in (l.split("\t") for l in open("sample.gff3") if not l.startswith("#")) if f[2] == "gene"])
```

```text
[('chr1', '100', '900', '+', 'ABC1'), ('chr2', '50', '400', '-', 'XYZ9')]
```

**GFF3: feature-type counts and total exon length**

```python
from collections import Counter
rows = [l.split("\t") for l in open("sample.gff3") if not l.startswith("#")]; print(Counter(r[2] for r in rows), sum(int(r[4]) - int(r[3]) + 1 for r in rows if r[2] == "exon"))
```

```text
Counter({'exon': 3, 'gene': 2, 'mRNA': 2}) 803
```

**SAM: decode a FLAG**

```python
names = "paired proper_pair unmapped mate_unmapped reverse mate_reverse read1 read2 secondary qcfail duplicate supplementary".split()
print({f: [n for i, n in enumerate(names) if f >> i & 1] for f in (99, 147, 4, 1024)})
```

```text
{99: ['paired', 'proper_pair', 'mate_reverse', 'read1'], 147: ['paired', 'proper_pair', 'reverse', 'read2'], 4: ['unmapped'], 1024: ['duplicate']}
```

**SAM: mapped / unmapped / duplicate counts and MAPQ ≥ 30**

```python
rows = [l.split("\t") for l in open("sample.sam") if not l.startswith("@")]
print(sum(not int(r[1]) & 4 for r in rows), sum(bool(int(r[1]) & 4) for r in rows), sum(bool(int(r[1]) & 1024) for r in rows), sum(int(r[4]) >= 30 for r in rows))
```

```text
5 1 1 4
```

**CIGAR → aligned reference length**

```python
import re
print({c: sum(int(n) for n, op in re.findall(r"(\d+)([MIDNSHP=X])", c) if op in "MDN=X") for c in ("20M", "5M2I5M", "10M100N10M", "3S7M1D4M")})
```

```text
{'20M': 20, '5M2I5M': 10, '10M100N10M': 120, '3S7M1D4M': 12}
```

---

## Biopython one-liners

> [!NOTE]
> These need `biopython` (`pip install biopython`) and were tested with 1.88.

**Read a FASTA into a dict of records**

```python
from Bio import SeqIO
print({k: len(v) for k, v in SeqIO.to_dict(SeqIO.parse("sample.fasta", "fasta")).items()})
```

```text
{'seq1': 64, 'seq2': 13, 'seq3': 44, 'seq4': 30}
```

**Reverse complement, transcribe, translate**

```python
from Bio.Seq import Seq
s = Seq("ATGGCGTACGTTAGCTAA"); print(s.reverse_complement(), s.transcribe(), s.translate(), s.translate(to_stop=True))
```

```text
TTAGCTAACGTACGCCAT AUGGCGUACGUUAGCUAA MAYVS* MAYVS
```

**GC fraction**

```python
from Bio.SeqUtils import gc_fraction
print(round(gc_fraction("ATGCGCNNAT"), 4), round(gc_fraction("ATGCGCNNAT", ambiguous="ignore"), 4))
```

```text
0.5 0.4
```

**Convert FASTQ → FASTA (returns the record count)**

```python
from Bio import SeqIO; import io
out = io.StringIO(); print(SeqIO.convert("sample.fastq", "fastq", out, "fasta")); print(out.getvalue().splitlines()[:2])
```

```text
4
['>read1 sample=A', 'ACGTACGTACGTACGTAAAA']
```

**Mean Phred per read**

```python
from Bio import SeqIO
print({r.id: round(sum(q := r.letter_annotations["phred_quality"]) / len(q), 1) for r in SeqIO.parse("sample.fastq", "fastq")})
```

```text
{'read1': 40.0, 'read2': 20.5, 'read3': 10.0, 'read4': 40.0}
```

**Melting temperature (nearest-neighbour)**

```python
from Bio.SeqUtils import MeltingTemp as mt
print(round(mt.Tm_NN("AGCGGATAACAATTTC"), 2), round(mt.Tm_Wallace("AGCGGATAACAATTTC"), 1))
```

```text
39.89 44.0
```

**Protein molecular weight and isoelectric point**

```python
from Bio.SeqUtils.ProtParam import ProteinAnalysis
p = ProteinAnalysis("MAGICKLVRSTEQ"); print(round(p.molecular_weight(), 2), round(p.isoelectric_point(), 2))
```

```text
1435.71 7.98
```

**Pairwise global alignment score**

```python
from Bio import Align
a = Align.PairwiseAligner(mode="global", match_score=1, mismatch_score=-1, open_gap_score=-2, extend_gap_score=-1); print(a.score("GATTACA", "GCATGCA")); print(a.align("GATTACA", "GCATGCA")[0])
```

```text
1.0
target            0 GATTACA 7
                  0 |..|.|| 7
query             0 GCATGCA 7

```

---

## Dates and times

**Now, as ISO 8601 with timezone**

<!-- nondeterministic -->
```python
from datetime import datetime, timezone
print(datetime.now(timezone.utc).isoformat(timespec="seconds"))
```

```text
2026-10-01T08:02:48+00:00
```

**Parse ISO dates and compute differences**

```python
from datetime import date
print((date.fromisoformat("2026-12-25") - date.fromisoformat("2026-10-01")).days)
```

```text
85
```

**Add days, weeks, business days**

```python
from datetime import date, timedelta
d = date(2026, 10, 1); print(d + timedelta(days=30), d + timedelta(weeks=2), [x for x in (d + timedelta(i) for i in range(1, 15)) if x.weekday() < 5][4])
```

```text
2026-10-31 2026-10-15 2026-10-08
```

**Unix epoch ↔ datetime**

```python
from datetime import datetime, timezone
print(datetime.fromtimestamp(1_700_000_000, tz=timezone.utc), int(datetime(2026, 1, 1, tzinfo=timezone.utc).timestamp()))
```

```text
2023-11-14 22:13:20+00:00 1767225600
```

**Convert between timezones (`zoneinfo`)**

```python
from datetime import datetime; from zoneinfo import ZoneInfo
t = datetime(2026, 10, 1, 9, 0, tzinfo=ZoneInfo("Asia/Kolkata")); print(t.astimezone(ZoneInfo("America/New_York")), t.astimezone(ZoneInfo("UTC")))
```

```text
2026-09-30 23:30:00-04:00 2026-10-01 03:30:00+00:00
```

**Age in whole years**

```python
from datetime import date
age = lambda b, t=date(2026, 10, 1): t.year - b.year - ((t.month, t.day) < (b.month, b.day)); print(age(date(1990, 10, 2)), age(date(1990, 10, 1)))
```

```text
35 36
```

**Day of the week, ISO week number, day of year**

```python
from datetime import date
d = date(2026, 10, 1); print(d.strftime("%A"), d.isocalendar().week, d.timetuple().tm_yday)
```

```text
Thursday 40 274
```

**Every date in a range**

```python
from datetime import date, timedelta
a, b = date(2026, 2, 26), date(2026, 3, 2); print([str(a + timedelta(i)) for i in range((b - a).days + 1)])
```

```text
['2026-02-26', '2026-02-27', '2026-02-28', '2026-03-01', '2026-03-02']
```

**Last day of a month and leap years**

```python
import calendar
print(calendar.monthrange(2028, 2)[1], calendar.isleap(2100), [y for y in range(2020, 2033) if calendar.isleap(y)])
```

```text
29 False [2020, 2024, 2028, 2032]
```

**Seconds → `H:MM:SS` and back**

```python
from datetime import timedelta
print(str(timedelta(seconds=98765)), sum(int(x) * 60 ** i for i, x in enumerate(reversed("27:26:05".split(":")))))
```

```text
1 day, 3:26:05 98765
```

**Parse a non-ISO date format**

```python
from datetime import datetime
print(datetime.strptime("01/Oct/2026:10:00:01 +0000", "%d/%b/%Y:%H:%M:%S %z").isoformat())
```

```text
2026-10-01T10:00:01+00:00
```

**Time a snippet**

<!-- nondeterministic -->
```python
import timeit
print(f"{min(timeit.repeat('sum(range(1000))', number=1000, repeat=3)) * 1e3:.2f} µs per loop")
```

```text
21.17 µs per loop
```

---

## Command-line python -c and python -m

These run in a shell, so the blocks are `bash`.

**Sum a CSV column from stdin, with quoting handled**

```bash
python3 -c 'import csv, sys; print(sum(float(r[3]) for r in list(csv.reader(sys.stdin))[1:] if r[3]))' < sample.csv
```

```text
98.0
```

> [!WARNING]
> `cut -d, -f4 sample.csv` breaks on the quoted field `"epsilon, jr"`: it returns `treat` for that row. Use the `csv` module (or `mlr`/`csvkit`) for real CSV.

<!-- expect-fail -->
```bash
cut -d, -f4 sample.csv | tail -n +2 | python3 -c 'import sys; print(sum(float(x) for x in sys.stdin if x.strip()))'
```

**Pretty-print / validate JSON**

```bash
echo '{"b":1,"a":[1,2]}' | python3 -m json.tool --sort-keys
```

```text
{
    "a": [
        1,
        2
    ],
    "b": 1
}
```

**Count lines matching a regex in a file**

```bash
python3 -c 'import re,sys; print(sum(bool(re.search(sys.argv[1], l)) for l in open(sys.argv[2])))' 'POST' access.log
```

```text
2
```

**Unique sorted words from a file**

```bash
python3 -c 'import re,sys; print(*sorted(set(re.findall(r"[a-z]+", open(sys.argv[1]).read().lower())))[:8])' notes.txt
```

```text
alice and before bob call com contact docs
```

**Reverse complement every sequence line of a FASTA**

```bash
python3 -c 'import sys; t=str.maketrans("ACGTN","TGCAN"); [print(l.strip() if l[0]==">" else l.strip().translate(t)[::-1]) for l in open(sys.argv[1])]' sample.fasta | head -4
```

```text
>seq1 Homo sapiens test gene A
TTAGCCTAGCTAGCTATCGGCTAACGTACGCCAT
GCATGCATCGATCGATGCTAGCTAGCTACG
>seq2 short fragment
```

**Quick HTTP server for the current folder**

<!-- no-run -->
```bash
python3 -m http.server 8000 --bind 127.0.0.1
```

**Base64 encode / decode**

```bash
echo -n 'one-liners' | python3 -m base64 && echo 'b25lLWxpbmVycw==' | python3 -m base64 -d; echo
```

```text
b25lLWxpbmVycw==
one-liners
```

**Generate a UUID (3.12+)**

<!-- nondeterministic -->
```bash
python3 -m uuid
```

```text
7380ebce-2d63-40b6-888c-738a54aae65a
```

**Print a calendar**

```bash
python3 -m calendar 2026 10
```

```text
    October 2026
Mo Tu We Th Fr Sa Su
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30 31
```

**Benchmark an expression**

<!-- nondeterministic -->
```bash
python3 -m timeit -n 1000 '"-".join(map(str, range(100)))'
```

```text
1000 loops, best of 5: 13.6 usec per loop
```

**List or create a zip archive**

```bash
z=$(mktemp -u).zip; python3 -m zipfile -c "$z" tree/docs && python3 -c 'import sys, zipfile; print(sorted(zipfile.ZipFile(sys.argv[1]).namelist()))' "$z"; rm -f "$z"
```

```text
['docs/', 'docs/copy_of_notes.txt', 'docs/notes.txt', 'docs/readme.md']
```

**Create a virtual environment**

<!-- no-run -->
```bash
python3 -m venv .venv && source .venv/bin/activate && python -m pip install -U pip
```

**Run a quick SQL query on a CSV with the built-in `sqlite3` (3.12+ CLI)**

```bash
python3 -c 'import csv,sqlite3; c=sqlite3.connect(":memory:"); c.execute("create table t(id,name,grp,value,date)"); c.executemany("insert into t values (?,?,?,?,?)", list(csv.reader(open("sample.csv")))[1:]); print(c.execute("select grp, count(*), round(avg(nullif(value,\"\")),2) from t group by grp").fetchall())'
```

```text
[('ctrl', 4, 10.81), ('treat', 4, 18.25)]
```

---

## System, hashing, encoding and security

**MD5 / SHA-256 of a file (streamed, 3.11+)**

```python
import hashlib
print(hashlib.file_digest(open("sample.fasta", "rb"), "sha256").hexdigest()[:16], hashlib.md5(open("sample.fasta", "rb").read()).hexdigest())
```

```text
bdd766bab498c04f 81806a9bd3f15ad5b737c85088d2566c
```

**Hash a string**

```python
import hashlib
print(hashlib.sha1(b"one-liners").hexdigest())
```

```text
c65bbe268d3905c1ffa6675dee7f9d3f5a3a7be7
```

**Cryptographically secure password, token and PIN**

<!-- nondeterministic -->
```python
import secrets, string
print("".join(secrets.choice(string.ascii_letters + string.digits + "!@#$%") for _ in range(16)), secrets.token_urlsafe(16), f"{secrets.randbelow(10**6):06d}")
```

```text
%0MXTSE6kcSZHZv5 3rWTExLA5VaIUpODPmzRaA 585988
```

**UUIDs**

<!-- nondeterministic -->
```python
import uuid
print(uuid.uuid4(), uuid.uuid5(uuid.NAMESPACE_DNS, "example.org"))
```

```text
0356f222-5e3b-4448-accd-3e1e4eef41f0 aad03681-8b63-5304-89e0-8ca8f49461b5
```

**Deterministic UUID from a name (`uuid5`)**

```python
import uuid
print(uuid.uuid5(uuid.NAMESPACE_URL, "https://example.org/sample/42"))
```

```text
446e9e61-7593-536b-9a1d-9d56fc18a10e
```

**Base64 and hex round-trips**

```python
import base64
print(base64.b64encode(b"ACGT").decode(), base64.b64decode("QUNHVA==").decode(), b"ACGT".hex(), bytes.fromhex("41434754"))
```

```text
QUNHVA== ACGT 41434754 b'ACGT'
```

**URL encode / decode and parse a query string**

```python
from urllib.parse import quote, unquote, urlparse, parse_qs
u = "https://example.com/search?q=" + quote("p53 & mdm2"); print(u, unquote(u)); print(parse_qs(urlparse("https://x.org/a?id=42&tag=a&tag=b").query))
```

```text
https://example.com/search?q=p53%20%26%20mdm2 https://example.com/search?q=p53 & mdm2
{'id': ['42'], 'tag': ['a', 'b']}
```

**Environment variable with a default**

```python
import os
print(os.environ.get("SOME_UNSET_VAR", "default-value"))
```

```text
default-value
```

**Platform and Python info**

<!-- nondeterministic -->
```python
import platform, sys, os
print(platform.system(), platform.machine(), sys.version.split()[0], os.cpu_count())
```

```text
Linux x86_64 3.14.6 8
```

**Which executable is on PATH?**

```python
import shutil
print(shutil.which("sed") is not None, shutil.which("definitely-not-a-command"))
```

```text
True None
```

**Run a shell command and capture its output**

```python
import subprocess
print(subprocess.run(["wc", "-l", "sample.csv"], capture_output=True, text=True).stdout.split()[0])
```

```text
9
```

**Memory size of an object (shallow)**

```python
import sys
print(sys.getsizeof([]), sys.getsizeof(list(range(1000))), sys.getsizeof("ACGT" * 1000))
```

```text
56 8056 4041
```

**Pickle round-trip**

```python
import pickle
print(pickle.loads(pickle.dumps({"genes": ["TP53", "MYC"], "n": 2})))
```

```text
{'genes': ['TP53', 'MYC'], 'n': 2}
```

**Suppress an expected exception in one line**

```python
from contextlib import suppress
from pathlib import Path
with suppress(FileNotFoundError): Path("no-such-file.tmp").unlink()
print("still running")
```

```text
still running
```

---

## Gotchas worth remembering

**Mutable default arguments are shared between calls**

```python
def add(x, acc=[]): acc.append(x); return acc
print(add(1), add(2))
def add_ok(x, acc=None): acc = [] if acc is None else acc; acc.append(x); return acc
print(add_ok(1), add_ok(2))
```

```text
[1, 2] [1, 2]
[1] [2]
```

**Late binding in lambdas created in a loop**

```python
print([f(10) for f in [lambda x: x + i for i in range(3)]], [f(10) for f in [lambda x, i=i: x + i for i in range(3)]])
```

```text
[12, 12, 12] [10, 11, 12]
```

**`str.strip`/`lstrip` remove characters, not substrings**

```python
print(repr("0o0".lstrip("0o")), "data.fasta".rstrip(".fasta"), "data.fasta".removesuffix(".fasta"))
```

```text
'' d data
```

**Integer division and modulo with negatives**

```python
print(-7 // 2, -7 % 2, int(-7 / 2), divmod(-7, 2))
```

```text
-4 1 -3 (-4, 1)
```

**`is` vs `==`**

```python
a = [1, 2]; b = [1, 2]; print(a == b, a is b, None is None)
```

```text
True False True
```

**`round` uses banker's rounding; floats aren't exact**

```python
print(round(0.5), round(1.5), round(2.675, 2))
```

```text
0 2 2.67
```

**Shallow vs deep copy**

```python
import copy
a = [[1, 2], [3]]; s = a.copy(); d = copy.deepcopy(a); a[0].append(99); print(s, d)
```

```text
[[1, 2, 99], [3]] [[1, 2], [3]]
```

**`[[0] * 3] * 3` repeats the same inner list**

```python
bad = [[0] * 3] * 3; bad[0][0] = 1; good = [[0] * 3 for _ in range(3)]; good[0][0] = 1; print(bad, good)
```

```text
[[1, 0, 0], [1, 0, 0], [1, 0, 0]] [[1, 0, 0], [0, 0, 0], [0, 0, 0]]
```
