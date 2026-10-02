#!/usr/bin/env python3
"""Run every code block in the one-liner notes and check its recorded output.

Convention inside the Markdown notes
------------------------------------
* A ```python / ```bash block is executed (cwd = test-data/).
* A ```text block directly after it (blank lines allowed) is its expected
  stdout. Blocks with no ```text block must simply exit 0.
* `# Output: X` comments inside Python code (the book note) must also be
  true: every claimed line has to appear, in order, in the real stdout.
* An HTML comment on the line just before a code block changes that
  (hidden on GitHub and in Obsidian's reading view):
      <!-- no-run -->           documented only (servers, venv, macOS syntax…)
      <!-- nondeterministic --> executed, exit status checked, output not compared
      <!-- expect-fail -->      a block that is SUPPOSED to fail

usage:
    python3 scripts/verify_blocks.py                 # check all notes
    python3 scripts/verify_blocks.py --fix           # rewrite ```text blocks
    python3 scripts/verify_blocks.py NOTE.md -v      # one note, show passes
"""
import argparse, os, re, subprocess, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "test-data"
NOTES = ["python-one-liners-book.md", "python-one-liners.md", "sed-awk-bioawk-one-liners.md"]
FENCE = re.compile(r"^```(\w*)\s*$")
RUNNERS = {
    "python": lambda code: [sys.executable, "-c", code],
    "bash": lambda code: ["bash", "-o", "pipefail", "-c", code],
}


def parse(lines):
    """Yield (start, end, lang, body) for every fenced block (end = closing fence)."""
    i = 0
    while i < len(lines):
        m = FENCE.match(lines[i])
        if m and m.group(1):
            j = i + 1
            while j < len(lines) and lines[j].rstrip() != "```":
                j += 1
            yield i, j, m.group(1), "".join(lines[i + 1:j])
            i = j + 1
        else:
            i += 1


def output_claims(code):
    """Lines promised by '# Output:' comments (skipping '# Output (varies)')."""
    claims, lines = [], code.splitlines()
    for i, l in enumerate(lines):
        m = re.match(r"\s*# Output: (.*)$", l)
        if m:
            claims.append(m.group(1))
        elif re.match(r"\s*# Output:\s*$", l):
            for nxt in lines[i + 1:]:
                m2 = re.match(r"\s*#(?:   (.*))?$", nxt)
                if not m2:
                    break
                claims.append(m2.group(1) or "")
    return claims


def claims_hold(claims, out):
    it = iter(out.splitlines())
    return all(any(c == o for o in it) for c in claims)


def run(lang, code):
    p = subprocess.run(RUNNERS[lang](code), cwd=DATA, capture_output=True, text=True, timeout=60,
                       env={**os.environ, "LC_ALL": "C.UTF-8", "PATH": f"{Path(sys.executable).parent}{os.pathsep}{os.environ.get('PATH', '')}", "PYTHONHASHSEED": "0", "TZ": "UTC"})
    return p.returncode, p.stdout, p.stderr


def check(path, fix, verbose):
    lines = path.read_text(encoding="utf-8").splitlines(keepends=True)
    blocks = list(parse(lines))
    edits, stats = [], {"pass": 0, "fail": 0, "skip": 0}
    for k, (s, e, lang, body) in enumerate(blocks):
        if lang not in RUNNERS:
            continue
        prev = lines[s - 1].strip() if s else ""
        if "no-run" in prev:
            stats["skip"] += 1
            continue
        # the expected-output block, if one follows
        nxt = blocks[k + 1] if k + 1 < len(blocks) else None
        has_out = nxt and nxt[2] == "text" and all(not l.strip() for l in lines[e + 1:nxt[0]])
        rc, out, err = run(lang, body)
        where = f"{path.name}:{s + 1}"
        if "expect-fail" in prev:
            ok, why = rc != 0, "expected a failure but it exited 0"
        elif rc != 0:
            ok, why = False, f"exit {rc}: {err.strip().splitlines()[-1] if err.strip() else ''}"
        elif "nondeterministic" in prev or not has_out:
            ok, why = True, ""
            if fix and not has_out and out.strip():
                edits.append((e + 1, e + 1, ["\n", "```text\n", out if out.endswith("\n") else out + "\n", "```\n"]))
            elif fix and has_out and nxt[3].strip() == "STALE":  # placeholder: record a fresh sample run
                edits.append((nxt[0] + 1, nxt[1], [out if out.endswith("\n") or not out else out + "\n"]))
        else:
            ok = out == nxt[3]
            why = f"output differs\n--- recorded\n{nxt[3]}--- actual\n{out}"
            if not ok and fix:
                edits.append((nxt[0] + 1, nxt[1], [out if out.endswith("\n") or not out else out + "\n"]))
                ok, why = True, "(fixed)"
        if ok and lang == "python" and rc == 0 and "nondeterministic" not in prev:
            claims = output_claims(body)
            if claims and not claims_hold(claims, out):
                ok, why = False, f"a '# Output:' comment is not what the code prints\n--- claimed\n" + "\n".join(claims) + f"\n--- actual\n{out}"
        stats["pass" if ok else "fail"] += 1
        if not ok or verbose or why == "(fixed)":
            print(f"{'PASS' if ok else 'FAIL'} {where} {why}")
    for a, b, new in sorted(edits, reverse=True):
        lines[a:b] = new
    if edits:
        path.write_text("".join(lines), encoding="utf-8")
    return stats


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("notes", nargs="*")
    ap.add_argument("--fix", action="store_true")
    ap.add_argument("-v", "--verbose", action="store_true")
    a = ap.parse_args()
    total = {"pass": 0, "fail": 0, "skip": 0}
    for n in a.notes or NOTES:
        p = Path(n) if Path(n).exists() else ROOT / n
        st = check(p, a.fix, a.verbose)
        print(f"{p.name}: {st}")
        for k in total:
            total[k] += st[k]
    sys.exit(1 if total["fail"] else 0)


if __name__ == "__main__":
    main()
