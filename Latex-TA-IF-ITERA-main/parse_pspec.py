import re

with open("pdf_full.txt", encoding="utf-8", errors="replace") as f:
    pdf = f.read()

# Extract pages 100-122 (PSPEC area)
m = re.search(r"--- PAGE 100 ---(.*?)--- PAGE 122 ---", pdf, re.DOTALL)
pspec_text = m.group(1) if m else ""

def clean(text):
    """Clean OCR artifacts from text."""
    # Fix mojibake encoding artifacts
    text = re.sub(r"[â€™â€\u0080-\u009f]+", "", text)
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    # Remove page numbers at start of line
    text = re.sub(r"^\d{1,3}\s*$", "", text, flags=re.MULTILINE)
    # Remove "--- PAGE N ---" markers
    text = re.sub(r"--- PAGE \d+ ---", "", text)
    # Collapse multiple spaces
    text = re.sub(r"[ \t]{2,}", " ", text)
    # Collapse multiple newlines
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()

def escape_latex(text):
    """Escape special LaTeX characters."""
    text = text.replace("&", "\\&")
    text = text.replace("%", "\\%")
    text = text.replace("_", "\\_")
    text = text.replace("#", "\\#")
    text = text.replace("$", "\\$")
    text = text.replace("{", "\\{").replace("}", "\\}")
    text = text.replace("^", "\\^{}")
    text = text.replace("~", "\\textasciitilde{}")
    text = text.replace("<", "\\textless{}").replace(">", "\\textgreater{}")
    return text

# Parse PSPEC tables from text
# Pattern: PSPEC table has fields: Nama Proses, Deskripsi Proses, Data Input, Data Output, Body/Keterangan
def parse_pspec_tables(text):
    """Parse all PSPEC tables from extracted PDF text."""
    tables = []
    
    # Find all PSPEC blocks - look for process titles
    # Pattern: "PSPEC Proses X.Y: Title" (section heading)
    pspec_section_pattern = re.compile(
        r"PSPEC\s+Proses\s+(\d+\.\d+)[:\s-]+([^\n]+)\n",
        re.IGNORECASE
    )
    
    # Also look for table content
    # Pattern: Nama Proses field followed by actual name
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
        proc_num = match.group(1) or ""
        nama = clean(match.group(2))
        deskripsi = clean(match.group(3))
        input_data = clean(match.group(4))
        output_data = clean(match.group(5))
        keterangan = clean(match.group(6))
        
        tables.append({
            "proc": proc_num.strip(),
            "nama": nama,
            "deskripsi": deskripsi,
            "input": input_data,
            "output": output_data,
            "keterangan": keterangan,
        })
    
    return tables

tables = parse_pspec_tables(pspec_text)
print(f"Found {len(tables)} PSPEC tables")
for t in tables[:3]:
    print(f"  Proc {t['proc']}: {t['nama'][:50]}")
    print(f"    Input: {t['input'][:60]}")
