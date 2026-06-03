"""
Replace the existing PSPEC 2.1 table and grouped paragraphs in chapter-3.tex
with individual tables from pspec_combined.tex.
"""
import re

chapter_path = "chapters/chapter-3.tex"
combined_path = "pspec_combined.tex"

with open(chapter_path, encoding="utf-8") as f:
    chapter = f.read()

with open(combined_path, encoding="utf-8") as f:
    combined = f.read()

# Find the start: \paragraph{PSPEC Proses 2.1: ...}
# Find the end: just before \subsubsection{\textit{Data Store}}
start_marker = r"\paragraph{PSPEC Proses 1.4: Pemilihan Gelombang Pendaftaran}~\\"
end_marker = r"\subsubsection{\textit{Data Store}} \label{III.DataStore}"

start_idx = chapter.find(start_marker)
end_idx = chapter.find(end_marker)

if start_idx == -1:
    print("ERROR: start marker not found!")
elif end_idx == -1:
    print("ERROR: end marker not found!")
else:
    print(f"Start at char {start_idx}, end at char {end_idx}")
    print(f"Section to replace: {end_idx - start_idx} chars")
    
    # Build replacement: combined tables + newline before data store section
    replacement = combined.strip() + "\n\n"
    
    new_chapter = chapter[:start_idx] + replacement + chapter[end_idx:]
    
    with open(chapter_path, "w", encoding="utf-8") as f:
        f.write(new_chapter)
    
    print(f"Successfully replaced PSPEC 2.1+groups with 44 individual tables")
    print(f"New file size: {len(new_chapter)} chars")
