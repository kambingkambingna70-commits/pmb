"""
Generate PNG class diagrams from CLASS-DIAGRAM.md using either:
1. mmdc (Mermaid CLI) if installed
2. mermaid.ink API as fallback
"""
import re
import os
import subprocess
import base64
import urllib.request
import json

MD_FILE = os.path.join(os.path.dirname(__file__), "CLASS-DIAGRAM.md")
OUT_DIR = os.path.join(os.path.dirname(__file__), "class-diagrams")
os.makedirs(OUT_DIR, exist_ok=True)

DIAGRAM_NAMES = [
    "01-overview-sistem",
    "02-auth-pengguna",
    "03-pendaftaran-formulir",
    "04-ujian",
    "05-pembayaran",
    "06-daftar-ulang",
    "07-komunikasi-sistem",
]

def extract_mermaid_blocks(md_path):
    with open(md_path, encoding="utf-8") as f:
        content = f.read()
    pattern = re.compile(r"```mermaid\n(.*?)```", re.DOTALL)
    return pattern.findall(content)

def save_mmd(diagram_text, name):
    path = os.path.join(OUT_DIR, f"{name}.mmd")
    with open(path, "w", encoding="utf-8") as f:
        f.write(diagram_text.strip())
    return path

def render_with_mmdc(mmd_path, out_png):
    result = subprocess.run(
        ["mmdc", "-i", mmd_path, "-o", out_png, "-b", "white", "--width", "2000"],
        capture_output=True, text=True
    )
    return result.returncode == 0, result.stderr

def render_with_api(diagram_text, out_png):
    """Use Kroki.io POST API to render diagram (handles large diagrams)."""
    import zlib
    url = "https://kroki.io/mermaid/png"
    body = diagram_text.strip().encode("utf-8")
    try:
        req = urllib.request.Request(
            url,
            data=body,
            method="POST",
            headers={
                "Content-Type": "text/plain; charset=utf-8",
                "Accept": "image/png",
                "User-Agent": "Mozilla/5.0",
            },
        )
        with urllib.request.urlopen(req, timeout=60) as resp:
            data = resp.read()
        with open(out_png, "wb") as f:
            f.write(data)
        return True, ""
    except Exception as e:
        return False, str(e)

def check_mmdc():
    try:
        result = subprocess.run(["mmdc", "--version"], capture_output=True, text=True)
        return result.returncode == 0
    except FileNotFoundError:
        return False

def main():
    print(f"Reading: {MD_FILE}")
    blocks = extract_mermaid_blocks(MD_FILE)
    print(f"Found {len(blocks)} Mermaid diagram(s)")

    has_mmdc = check_mmdc()
    print(f"mmdc available: {has_mmdc}")
    if not has_mmdc:
        print("Falling back to mermaid.ink API")

    names = DIAGRAM_NAMES[:len(blocks)]
    if len(blocks) > len(names):
        for i in range(len(names), len(blocks)):
            names.append(f"diagram-{i+1:02d}")

    for i, (block, name) in enumerate(zip(blocks, names)):
        print(f"\n[{i+1}/{len(blocks)}] {name}")
        mmd_path = save_mmd(block, name)
        out_png = os.path.join(OUT_DIR, f"{name}.png")

        if has_mmdc:
            ok, err = render_with_mmdc(mmd_path, out_png)
            method = "mmdc"
        else:
            ok, err = render_with_api(block, out_png)
            method = "mermaid.ink API"

        if ok:
            size = os.path.getsize(out_png)
            print(f"  OK via {method} -> {out_png} ({size:,} bytes)")
        else:
            print(f"  FAILED via {method}: {err}")
            if has_mmdc:
                print("  Retrying with mermaid.ink API...")
                ok2, err2 = render_with_api(block, out_png)
                if ok2:
                    size = os.path.getsize(out_png)
                    print(f"  OK via mermaid.ink API -> {out_png} ({size:,} bytes)")
                else:
                    print(f"  FAILED via mermaid.ink API: {err2}")

    print(f"\nDone. Output folder: {OUT_DIR}")

if __name__ == "__main__":
    main()
