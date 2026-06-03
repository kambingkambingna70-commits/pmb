import re

def normalize(text):
    text = re.sub(r"\\[a-zA-Z]+\{[^}]*\}", " ", text)
    text = re.sub(r"\\[a-zA-Z]+", " ", text)
    text = re.sub(r"[{}]", " ", text)
    text = re.sub(r"\s+", " ", text)
    return text.strip().lower()

with open("pdf_full.txt", encoding="utf-8", errors="replace") as f:
    pdf = f.read()

with open("chapters/chapter-1.tex", encoding="utf-8", errors="replace") as f:
    ch1_tex = f.read()

with open("chapters/chapter-2.tex", encoding="utf-8", errors="replace") as f:
    ch2_tex = f.read()

with open("chapters/chapter-3.tex", encoding="utf-8", errors="replace") as f:
    ch3_tex = f.read()

def check_chapter(pdf_text, tex_text, label):
    sentences = [s.strip() for s in re.split(r"[.\n]", pdf_text) if len(s.strip()) > 45]
    tex_norm = normalize(tex_text)
    found = 0
    missed = []
    for s in sentences[:30]:
        key = normalize(s)[:55]
        if key and key in tex_norm:
            found += 1
        else:
            missed.append(s[:100])
    pct = round(found / min(len(sentences), 30) * 100)
    print(f"\n{'='*60}")
    print(f"{label}: {found}/{min(len(sentences),30)} key sentences found => ~{pct}% match")
    if missed:
        print(f"  POSSIBLY MISSING ({len(missed)} items):")
        for m in missed[:10]:
            print(f"    - {m}")
    return pct

# BAB I: pages 13-18
m = re.search(r"--- PAGE 13 ---(.*?)--- PAGE 19 ---", pdf, re.DOTALL)
bab1 = m.group(1) if m else ""

# BAB II: pages 19-41
m = re.search(r"--- PAGE 19 ---(.*?)--- PAGE 42 ---", pdf, re.DOTALL)
bab2 = m.group(1) if m else ""

# BAB III: pages 42-136
m = re.search(r"--- PAGE 42 ---(.*?)--- PAGE 137 ---", pdf, re.DOTALL)
bab3 = m.group(1) if m else ""

# REFERENCES - check for key bibkeys
with open("references.bib", encoding="utf-8", errors="replace") as f:
    bib = f.read()
bib_keys = re.findall(r"@[a-zA-Z]+\{([^,]+),", bib)
print(f"\n{'='*60}")
print(f"REFERENCES.BIB: {len(bib_keys)} entries: {', '.join(bib_keys[:5])}...")

pct1 = check_chapter(bab1, ch1_tex, "BAB I (pages 13-18)")
pct2 = check_chapter(bab2, ch2_tex, "BAB II (pages 19-41)")
pct3 = check_chapter(bab3, ch3_tex, "BAB III (pages 42-136)")

total = round((pct1 + pct2 + pct3) / 3)
print(f"\n{'='*60}")
print(f"OVERALL ESTIMATED SIMILARITY: ~{total}%")
print(f"  BAB I:   ~{pct1}%")
print(f"  BAB II:  ~{pct2}%")
print(f"  BAB III: ~{pct3}%")
print(f"  References: {len(bib_keys)} entries in .bib")
