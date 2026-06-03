f = r'd:\all code\aa\Latex-TA-IF-ITERA-main\DIAGRAM-MISMATCH-REPORT.md'
with open(f, encoding='utf-8') as fh:
    content = fh.read()

d3_start = content.find('## D3.')
enduml_pos = content.find('@enduml', d3_start)
close_pos = content.find('```', enduml_pos) + 3

new_d3 = (
    "## D3. `activity-formulir-kartu-ujian.png`\n"
    "\n"
    "```plantuml\n"
    "@startuml\n"
    "|Camaba|\n"
    "start\n"
    ":Akses Formulir\n"
    "Pendaftaran Gelombang Aktif;\n"
    "\n"
    "|Sistem|\n"
    ":Menampilkan Formulir Data;\n"
    "\n"
    "|Camaba|\n"
    ":Upload Berkas dan\n"
    "Isi Data Diri;\n"
    "\n"
    "|Sistem|\n"
    ":Validasi Kelengkapan\n"
    "dan Penulisan Data;\n"
    "\n"
    "if (Data valid?) then (Tidak)\n"
    "  :Peringatan Kesalahan\n"
    "  Input Data;\n"
    "  stop\n"
    "else (Ya)\n"
    "  :Simpan Formulir Pendaftaran;\n"
    "  :Buat FormValidation\n"
    "  (status PENDING);\n"
    "  :Kirim Notifikasi Email\n"
    "  ke Admin Validasi;\n"
    "endif\n"
    "\n"
    "|Admin Validasi|\n"
    ":Review Formulir Pendaftaran;\n"
    "\n"
    "if (Formulir sesuai?) then (Tidak)\n"
    "  |Sistem|\n"
    "  :Update Status Formulir\n"
    "  Perlu Revisi;\n"
    "  :Kirim Notifikasi Revisi\n"
    "  ke Camaba;\n"
    "  stop\n"
    "else (Ya)\n"
    "  |Sistem|\n"
    "  :Update Status Formulir\n"
    "  Terverifikasi (APPROVED);\n"
    "  :Generate Token Ujian\n"
    "  (ExamToken);\n"
    "  :Kirim Email Token Ujian\n"
    "  ke Camaba;\n"
    "endif\n"
    "\n"
    "|Camaba|\n"
    ":Terima Token Ujian\n"
    "via Email;\n"
    "stop\n"
    "\n"
    "@enduml\n"
    "```"
)

new_content = content[:d3_start] + new_d3 + content[close_pos:]
with open(f, 'w', encoding='utf-8') as fh:
    fh.write(new_content)
print('Done. Lines:', new_content.count('\n') + 1)
print('D3 preview:', new_content[d3_start:d3_start+200])
