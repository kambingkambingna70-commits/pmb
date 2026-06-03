import re

with open('pspec_combined.tex', encoding='utf-8') as f:
    content = f.read()

# Split by paragraph entries
tables = re.split(r'(?=\\paragraph\{PSPEC Proses [\d.]+:)', content)
corrupt = []
for t in tables:
    m = re.search(r'\\paragraph\{PSPEC Proses ([\d.]+):', t)
    if not m: continue
    proc = m.group(1)
    issues = []
    if re.search(r'3\.5\.8\.\d', t): issues.append('section_number')
    if re.search(r'Tabel 3\.\d+ \d', t): issues.append('table_ref')
    if re.search(r'\xe2\x80', t.encode('utf-8', errors='replace').decode('utf-8', errors='replace')):
        issues.append('mojibake')
    if re.search(r'Nama\s+Proses\s+PSPEC\s+Proses', t): issues.append('OCR_overflow')
    # Check unescaped & in cell values
    cell_lines = [l for l in t.split('\n') if re.match(r'\s*\\textbf\{', l)]
    for cl in cell_lines:
        amp_matches = re.findall(r'(?<!\\)&', cl)
        if len(amp_matches) > 1:
            issues.append(f'unescaped_amp({len(amp_matches)-1})')
            break
    if issues:
        corrupt.append(f'{proc}: {issues}')

print(f'Total corrupted: {len(corrupt)}')
for c in corrupt:
    print(' ', c)
