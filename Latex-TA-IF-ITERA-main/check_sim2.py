import re

def strip_latex(text):
    text = re.sub(r"\\[a-zA-Z]+\*?\{[^}]*\}", " ", text)
    text = re.sub(r"\\[a-zA-Z]+\*?", " ", text)
    text = re.sub(r"[{}%&$#_^~]", " ", text)
    text = re.sub(r"\s+", " ", text)
    return text.strip().lower()

def strip_ocr(text):
    # Remove OCR spacing artifacts, normalize
    text = re.sub(r"\s+", " ", text)  # collapse spaces
    text = text.lower()
    return text

def keyword_overlap(pdf_text, tex_text, min_len=6):
    """Extract meaningful words (>= min_len chars) from both texts and compute overlap."""
    pdf_words = set(re.findall(r"[a-zA-ZÀ-ÿ\u00C0-\u017E]{%d,}" % min_len, strip_ocr(pdf_text)))
    tex_words = set(re.findall(r"[a-zA-ZÀ-ÿ\u00C0-\u017E]{%d,}" % min_len, strip_latex(tex_text)))
    if not pdf_words:
        return 0, set(), set()
    both = pdf_words & tex_words
    only_pdf = pdf_words - tex_words
    return len(both) / len(pdf_words) * 100, both, only_pdf

with open("pdf_full.txt", encoding="utf-8", errors="replace") as f:
    pdf = f.read()
with open("chapters/chapter-1.tex", encoding="utf-8", errors="replace") as f:
    ch1 = f.read()
with open("chapters/chapter-2.tex", encoding="utf-8", errors="replace") as f:
    ch2 = f.read()
with open("chapters/chapter-3.tex", encoding="utf-8", errors="replace") as f:
    ch3 = f.read()

# Extract BAB sections from PDF
def get_pages(pdf, start, end):
    m = re.search(rf"--- PAGE {start} ---(.*?)--- PAGE {end} ---", pdf, re.DOTALL)
    return m.group(1) if m else ""

bab1 = get_pages(pdf, 13, 19)
bab2 = get_pages(pdf, 19, 42)
bab3 = get_pages(pdf, 42, 137)

# Also get references pages
ref_match = re.search(r"--- PAGE 137 ---(.*?)--- PAGE 148 ---", pdf, re.DOTALL)
refs_pdf = ref_match.group(1) if ref_match else ""

# Get appendix/lampiran
lmpran_match = re.search(r"--- PAGE 148 ---(.*?)$", pdf, re.DOTALL)
lampiran_pdf = lmpran_match.group(1) if lmpran_match else ""

print("CONTENT SIMILARITY ANALYSIS (word overlap, words >= 6 chars)")
print("="*65)

for label, pdf_sec, tex_sec in [
    ("BAB I   (PDF pp.13-18)", bab1, ch1),
    ("BAB II  (PDF pp.19-41)", bab2, ch2),
    ("BAB III (PDF pp.42-136)", bab3, ch3),
]:
    pct, both, only_pdf = keyword_overlap(pdf_sec, tex_sec)
    print(f"\n{label}")
    print(f"  PDF unique words:   {len(set(re.findall(r'[a-zA-ZÀ-ÿ]{6,}', pdf_sec.lower())))}")
    print(f"  LaTeX unique words: {len(set(re.findall(r'[a-zA-ZÀ-ÿ]{6,}', strip_latex(tex_sec))))}")
    print(f"  Overlap:            {pct:.1f}%")
    
    # Show top 20 words only in PDF (truly missing)
    top_missing = sorted(only_pdf, key=len, reverse=True)[:20]
    # filter out common false positives (page numbers, headers, etc.)
    real_missing = [w for w in top_missing if len(w) >= 8 and not w.isdigit()][:15]
    if real_missing:
        print(f"  Key words only in PDF (not in LaTeX):")
        for w in real_missing:
            print(f"    - {w}")

# Check abstract
print("\n" + "="*65)
print("CHECKING ABSTRACT & SUMMARY...")
with open("chapters/abstract-id.tex", encoding="utf-8", errors="replace") as f:
    abstr = f.read()
# Find abstract in PDF (pages around 145+)
abs_match = re.search(r"ABSTRAK(.*?)(?:ABSTRACT|BAB\s+I)", pdf, re.DOTALL | re.IGNORECASE)
if abs_match:
    pct, _, _ = keyword_overlap(abs_match.group(1), abstr)
    print(f"  Abstrak ID: {pct:.1f}% overlap")
else:
    print("  Abstrak: not found in PDF (may be front matter)")

print("\n" + "="*65)
print("STRUCTURE CHECK - Key Sections Present:")
checks = [
    ("Latar Belakang", "latar belakang", ch1),
    ("Rumusan Masalah", "rumusan masalah", ch1),
    ("Tujuan Penelitian", "tujuan penelitian", ch1),
    ("Batasan Masalah", "batasan masalah", ch1),
    ("Manfaat Penelitian", "manfaat penelitian", ch1),
    ("Sistematika Penulisan", "sistematika", ch1),
    ("Tinjauan Pustaka", "tinjauan pustaka", ch2),
    ("Dasar Teori", "dasar teori", ch2),
    ("Spring Framework", "spring", ch2),
    ("MVC", "model-view-controller", ch2),
    ("DFD", "data flow diagram", ch2),
    ("UML", "uml", ch2),
    ("Metode Penelitian", "metode penelitian", ch3),
    ("Use Case Diagram", "use case", ch3),
    ("Activity Diagram", "activity diagram", ch3),
    ("Flowchart", "flowchart", ch3),
    ("Class Diagram", "class diagram", ch3),
    ("Sequence Diagram", "sequence diagram", ch3),
    ("ERD", "entity relationship", ch3),
    ("DFD Level", "dfd", ch3),
    ("Rancangan Antarmuka", "antarmuka", ch3),
    ("Black Box Testing", "black box", ch3),
    ("SUS Testing", "system usability", ch3),
]

for name, keyword, tex in checks:
    found = keyword.lower() in strip_latex(tex)
    status = "OK" if found else "MISSING"
    print(f"  [{status:7s}] {name}")
