import re

with open("pdf_full.txt", encoding="utf-8", errors="replace") as f:
    pdf = f.read()

# Extract pages 100-122 (PSPEC area)
m = re.search(r"--- PAGE 100 ---(.*?)--- PAGE 122 ---", pdf, re.DOTALL)
pspec_text = m.group(1) if m else ""

def clean(text):
    text = re.sub(r"[â€™â€\u0080-\u009f]+", "", text)
    text = re.sub(r"--- PAGE \d+ ---", "", text)
    text = re.sub(r"^\d{1,3}\s*$", "", text, flags=re.MULTILINE)
    # Remove section numbers like 3.5.8.9.5 or 3.5.8.9.10
    text = re.sub(r"\n\s*3\.\d+\.\d+\.\d+\.\d+\s*$", "", text)
    text = re.sub(r"\n\s*3\.\d+\.\d+\.\d+\.\d+\s*\n", "\n", text)
    # Collapse whitespace within text (preserve single newlines)
    text = re.sub(r"[ \t]+", " ", text)
    # Remove trailing/leading spaces per line, then rejoin
    lines = [l.strip() for l in text.split("\n")]
    text = " ".join(l for l in lines if l)
    return text.strip()

def escape_tex(text):
    text = text.replace("\\", "\\textbackslash{}")
    text = text.replace("&", "\\&")
    text = text.replace("%", "\\%")
    text = text.replace("#", "\\#")
    text = text.replace("$", "\\$")
    text = text.replace("_", "\\_")
    text = text.replace("{", "\\{").replace("}", "\\}")
    text = text.replace("^", "\\^{}")
    text = text.replace("~", "\\~{}")
    return text

def normalize_name(s, proc_num):
    """Remove PSPEC prefix from name."""
    s = re.sub(r"^PSPEC\s+Proses\s+[\d.]+\s*[–-]+\s*", "", s, flags=re.IGNORECASE)
    s = re.sub(r"^PSPEC\s+Proses\s+[\d.]+\s*", "", s, flags=re.IGNORECASE)
    return s.strip()

def parse_pspec_tables(text):
    tables = []
    table_pattern = re.compile(
        r"(?:Tabel\s+[\d. ]+PSPEC\s+Proses\s+(\d+\.\d+)[^\n]*\n)?"
        r"Nama\s+Proses\s+(.*?)\n"
        r"Deskripsi\s*\n?\s*Proses\s+(.*?)\n"
        r"Data\s+Input\s+(.*?)\n"
        r"Data\s+Output\s+(.*?)\n"
        r"Body\s*/\s*\n?Keterangan\s+(.*?)(?=(?:Nama\s+Proses|PSPEC\s+Proses|\d+\s*\n|Tabel\s+\d|$))",
        re.DOTALL | re.IGNORECASE
    )
    for match in table_pattern.finditer(text):
        proc_num = (match.group(1) or "").strip()
        nama = clean(match.group(2))
        deskripsi = clean(match.group(3))
        input_data = clean(match.group(4))
        output_data = clean(match.group(5))
        keterangan = clean(match.group(6))
        
        nama = normalize_name(nama, proc_num)
        
        tables.append({
            "proc": proc_num,
            "nama": nama,
            "deskripsi": deskripsi,
            "input": input_data,
            "output": output_data,
            "keterangan": keterangan,
        })
    return tables

tables = parse_pspec_tables(pspec_text)
print(f"Found {len(tables)} PSPEC tables")

# Already in LaTeX individually
already_done = {"1.1", "1.2", "1.3", "2.1"}

def make_proc_label(proc_num):
    return "pspec" + proc_num.replace(".", "")

def gen_latex(t):
    proc = t["proc"]
    nama = escape_tex(t["nama"])
    deskripsi = escape_tex(t["deskripsi"])
    inp = escape_tex(t["input"])
    out = escape_tex(t["output"])
    ket = escape_tex(t["keterangan"])
    label = make_proc_label(proc)
    
    return f"""
\\paragraph{{PSPEC Proses {proc}: {nama}}}~\\\\
\\begin{{longtable}}{{|p{{0.2\\textwidth}}|p{{0.7\\textwidth}}|}}
\t\\caption{{PSPEC Proses {proc} -- {nama}}}
\t\\label{{table:3.{label}}}\\\\
\t\\hline
\t\\textbf{{Nama Proses}} & {nama} \\\\
\t\\hline
\t\\textbf{{Deskripsi Proses}} & {deskripsi} \\\\
\t\\hline
\t\\textbf{{Data Input}} & {inp} \\\\
\t\\hline
\t\\textbf{{Data Output}} & {out} \\\\
\t\\hline
\t\\textbf{{Body / Keterangan}} & {ket} \\\\
\t\\hline
\\end{{longtable}}
"""

# Generate LaTeX for all new tables
output_lines = ["% ===== ADDITIONAL PSPEC TABLES =====\n"]

# First: PSPEC 1.4 through 1.8 (if found)
# Then: grouped ones

found_procs = [t["proc"] for t in tables]
print(f"Found process numbers: {sorted(set(found_procs))}")

for t in tables:
    proc = t["proc"]
    if proc not in already_done and t["nama"]:
        output_lines.append(gen_latex(t))

with open("pspec_new_tables.tex", "w", encoding="utf-8") as f:
    f.write("\n".join(output_lines))

print(f"Generated {len(output_lines)-1} new PSPEC tables")
print("Written to pspec_new_tables.tex")
