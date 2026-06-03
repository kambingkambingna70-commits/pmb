"""
Clean build of PSPEC combined file.
Extracts only the proper paragraph + longtable block for each entry.
"""
import re

def get_clean_blocks(filepath):
    """Extract clean \paragraph + \begin{longtable}...\end{longtable} blocks."""
    with open(filepath, encoding="utf-8") as f:
        content = f.read()
    pattern = re.compile(
        r'(\\paragraph\{PSPEC Proses [\d.]+:[^}]+\}~\\\\[^\n]*\n'
        r'\\begin\{longtable\}.*?\\end\{longtable\})',
        re.DOTALL
    )
    blocks = {}
    for m in pattern.finditer(content):
        block = m.group(1)
        num_m = re.search(r'\\paragraph\{PSPEC Proses ([\d.]+):', block)
        if num_m:
            num = num_m.group(1)
            if num not in blocks:
                blocks[num] = block
            else:
                print(f"  Duplicate {num} in {filepath}, keeping first")
    return blocks

new_blocks = get_clean_blocks("pspec_new_tables.tex")
miss_blocks = get_clean_blocks("pspec_missing_tables.tex")
override_blocks = get_clean_blocks("pspec_clean_overrides.tex")
print(f"pspec_new_tables.tex: {sorted(new_blocks.keys())}")
print(f"pspec_missing_tables.tex: {sorted(miss_blocks.keys())}")
print(f"pspec_clean_overrides.tex: {sorted(override_blocks.keys())}")

# Priority: override_blocks > miss_blocks > new_blocks
tables = {}
tables.update(new_blocks)
tables.update(miss_blocks)
tables.update(override_blocks)  # clean versions always win
print(f"\nCombined: {sorted(tables.keys())}")

# Correct ORDER based on actual PDF table labels (45 total, minus 1.1-1.3 already in chapter-3)
ORDER = [
    "1.4", "1.5", "1.6", "1.7", "1.8",
    "2.5", "2.6",
    "3.1", "3.2", "3.3", "3.4", "3.5",
    "4.2", "4.3", "4.4", "4.5", "4.6", "4.7", "4.8", "4.9", "4.10", "4.11",
    "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8",
    "6.1", "6.2", "6.3", "6.4", "6.5",
    "7.1", "7.2", "7.3", "7.4", "7.5", "7.6", "7.7",
]

missing = [p for p in ORDER if p not in tables]
if missing:
    print(f"WARNING: Missing tables: {missing}")
else:
    print(f"All {len(ORDER)} tables accounted for.")

parts = [tables.get(p, f"% MISSING PSPEC {p}\n") for p in ORDER]
combined = "\n\n".join(parts)

with open("pspec_combined.tex", "w", encoding="utf-8") as f:
    f.write(combined)

para_count = len(re.findall(r'\\paragraph\{PSPEC Proses [\d.]+:', combined))
print(f"Written pspec_combined.tex: {para_count} paragraph entries, {len(combined)} chars")
