f = r'd:\all code\aa\Latex-TA-IF-ITERA-main\DIAGRAM-MISMATCH-REPORT.md'
with open(f, encoding='utf-8') as fh:
    content = fh.read()

old_text = (
    "  :Generate Dokumen\n"
    "  NPM Sementara dan\n"
    "  KTM Sementara;\n"
    "  :Kirim Dokumen ke Camaba;\n"
    "  :Notifikasi ke Camaba\n"
    "  dan Admin Pusat;\n"
    "  stop\n"
)

new_text = (
    "  :Upload Dokumen\n"
    "  NPM Sementara dan\n"
    "  KTM Sementara (PDF);\n"
    "  :Kirim Dokumen ke Camaba;\n"
    "  :Notifikasi ke Camaba;\n"
    "  stop\n"
)

if old_text in content:
    new_content = content.replace(old_text, new_text, 1)
    with open(f, 'w', encoding='utf-8') as fh:
        fh.write(new_content)
    print('D5 updated. Lines:', new_content.count('\n') + 1)
else:
    print('Pattern not found!')
    idx = content.find('Generate Dokumen')
    print('Found at:', idx)
    print(repr(content[idx-50:idx+200]))
