# Handy One Liners

A collection of **tested** one-liners for everyday work: processing CSV/TSV files, bioinformatics formats (FASTA, FASTQ, VCF, BED, GFF3, SAM), text and regex, maths and statistics, file sizes and counts, dates, and more. It covers Python, sed, awk, bioawk and the standard shell tools.

Every example in this repository has been **executed**, and the output shown under it is the real output. A test suite re-runs all of them.

## Contents

| File | What's inside | Count |
|---|---|---|
| [python-one-liners.md](python-one-liners.md) | Python one-liners by topic: files and folders, CSV/TSV/JSON, stdlib data processing, pandas, text, regex, lambdas and functional tools, itertools, maths, statistics (with scipy), numpy, **bioinformatics** (sequences and file formats), Biopython, dates and times, `python -c` / `python -m`, hashing and security, common gotchas | ~275 |
| [sed-awk-bioawk-one-liners.md](sed-awk-bioawk-one-liners.md) | sed, awk and bioawk one-liners for delimited and biological files and everyday text work; shell companions (`find`, `du`, `sort`, `join`, `comm`, `xargs`, …); and the classic *Handy One-Liners for Sed* by Eric Pement, tested against GNU sed | ~220 + 93 classic |
| [python-one-liners-book.md](python-one-liners-book.md) | All 264 one-liners from *250+ Killer Python One-Liners*, **tested and corrected**, with a corrections log and a topic index | 264 |

### A taste

```bash
# Count files per extension in a folder
find . -type f -name '*.*' | sed 's/.*\.//' | sort | uniq -c | sort -rn

# Length and GC content of every FASTA record
bioawk -c fastx '{printf "%s\t%d\t%.3f\n", $name, length($seq), gc($seq)}' sample.fasta

# Remove duplicate lines without sorting
awk '!seen[$0]++' file.txt

# Sum a CSV column, handling quoted commas
python3 -c 'import csv, sys; print(sum(float(r[3]) for r in list(csv.reader(sys.stdin))[1:] if r[3]))' < sample.csv
```

```python
# Reverse complement (IUPAC-aware)
rc = lambda s: s.translate(str.maketrans("ACGTRYKMBVDHNacgtrykmbvdhn", "TGCAYRMKVBHDNtgcayrmkvbhdn"))[::-1]

# Total size of a folder, in bytes
from pathlib import Path; print(sum(p.stat().st_size for p in Path(".").rglob("*") if p.is_file()))
```

## Testing

```bash
bash scripts/run_tests.sh
```

This runs two checks.

1. **`scripts/verify_blocks.py`** executes every `python` and `bash` code block in the three notes inside a local `test-data/` folder, and compares stdout with the `text` block under it. In the book note it also checks that every `# Output:` comment in the code matches what the code really prints. After an intentional change, `python3 scripts/verify_blocks.py --fix` re-records the outputs.
2. **`scripts/test_pement_sed.sh`** runs all 93 Unix commands from Eric Pement's sed list. It also diffs each "emulates `tac`/`rev`/`uniq`/…" command against the real tool. It builds its own input, so it needs no sample files.

> [!NOTE]
> The sample files the examples read (`sample.csv`, `sample.fasta`, `sample.vcf`, `expression.tsv`, …) are **not included** in this repository. To run `verify_blocks.py`, put your own files with those names in a `test-data/` folder at the repository root; outputs will differ from the recorded ones unless the files match.

Current result: **760 code blocks pass** (264 + 277 + 219, with 3 documentation-only blocks skipped). In the Pement list, 93/93 commands run and 35/39 emulation checks are identical. The 4 differences are documented: 2 are format-only, and 2 are original commands that fail on GNU sed, which now have tested corrected versions.

Small HTML comments before some blocks tune the checks:

| Marker | Effect |
|---|---|
| `<!-- nondeterministic -->` | The block is run, but its output (random values, current time, disk sizes) is a sample. |
| `<!-- no-run -->` | Documentation only: servers, virtual environments, macOS-only syntax. |
| `<!-- expect-fail -->` | The block demonstrates a failure on purpose. |

### Requirements

- **Python ≥ 3.12** (tested on 3.14.6), with `pandas` (3.x), `numpy`, `scipy` and `biopython` for their sections.
- **GNU** `sed` (4.9), `gawk` (5.3), coreutils, `bc`, and [`bioawk`](https://github.com/lh3/bioawk) (`conda install -c bioconda bioawk` or `brew install bioawk`).
- On macOS, install `gsed` and `gawk`. BSD `sed -i`, `\t`, `\n` and `0~5` addresses behave differently (see the notes).

## Corrections and findings

Testing turned up real errors. These were corrected, and each correction is documented next to the entry.

- **Book: 56 of 264 entries had problems.**
  - **33** had wrong logic and now contain corrected code (the original is shown for reference). One example: #50 "DNA to RNA" computed the complement instead of replacing T with U.
  - **22** had correct code but a wrong stated output. All `# Output:` comments are now generated from real execution.
  - **1** keeps an explanatory note.
- **Classic sed list: 2 commands fail on GNU sed 4.9.**
  - "Delete trailing blank lines" (`N` prints at end of file) fails outright.
  - "Delete non-consecutive duplicate lines" does nothing in a UTF-8 locale.

  Both originals are kept as published, with tested fixes beside them.
- **bioawk `-c gff`:** the column names are shifted from the GFF3 spec. `$strand` returns the phase and `$attribute` is empty. Use `$7` and `$9`.
- **CSV with quoted commas:** `awk -F,` and `cut -d,` split `"epsilon, jr"`. The notes show `gawk FPAT` and Python `csv` alternatives.

## Repository layout

```
├── README.md
├── LICENSE
├── python-one-liners.md            # Python one-liners
├── sed-awk-bioawk-one-liners.md    # sed / awk / bioawk / shell + classic sed list
├── python-one-liners-book.md       # the book's 264 one-liners, tested and corrected
└── scripts/
    ├── run_tests.sh                # runs everything
    ├── verify_blocks.py            # executes code blocks, checks outputs and # Output comments
    ├── test_pement_sed.sh          # differential test of the classic sed list
    └── pement_commands.txt
```

The notes are plain Markdown. They render on GitHub and open directly as an [Obsidian](https://obsidian.md) vault: callouts use the `> [!NOTE]` syntax that both understand, and test markers are HTML comments that both hide.

## License

The original material in this repository (the one-liners written for it, the notes, the corrections and the test scripts) is released under the [MIT License](LICENSE).

Third-party content is **not** covered by that license and remains the property of its authors: the one-liners reproduced from *250+ Killer Python One-Liners* in [python-one-liners-book.md](python-one-liners-book.md), and Eric Pement's *Handy One-Liners for Sed* in [sed-awk-bioawk-one-liners.md](sed-awk-bioawk-one-liners.md). See the Acknowledgements below.

## Acknowledgements

- **_250+ Killer Python One-Liners_** by **Hernando Abella** (Aluna Publishing House). It is the source of the 264 one-liners in [python-one-liners-book.md](python-one-liners-book.md), and the book's content belongs to its author.
- **_Handy One-Liners for Sed_** (version 5.1), compiled by **Eric Pement**, with contributions from Al Aab, Edgar Allen, Yiorgos Adamopoulos, Dale Dougherty, Carlos Duarte, Ken Pizzini, S.G. Ravenhall and Greg Ubben.
- **[bioawk](https://github.com/lh3/bioawk)** by Heng Li.
- Several bioinformatics examples (motif search, Hamming distance, consensus) use the sample data from the [Rosalind](https://rosalind.info) problems as a check.
