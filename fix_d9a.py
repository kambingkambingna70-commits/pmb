f = r'd:\all code\aa\Latex-TA-IF-ITERA-main\DIAGRAM-MISMATCH-REPORT.md'
with open(f, encoding='utf-8') as fh:
    content = fh.read()

d9a_start = content.find('## D9a.')
enduml_pos = content.find('@enduml', d9a_start)
close_pos = content.find('```', enduml_pos) + 3

new_d9a = (
    "## D9a. `sequence-pendaftaran-formulir.png` *(Diagram 1 dari 2 - Formulir, VA & Pembayaran)*\n"
    "\n"
    "```plantuml\n"
    "@startuml\n"
    "skinparam participantPadding 50\n"
    "skinparam responseMessageBelowArrow true\n"
    "\n"
    "actor Camaba\n"
    'boundary "UI_PMB" as UI\n'
    'control "PMBController" as Controller\n'
    'entity "BRIVAService" as BRIVA\n'
    'database "Database" as DB\n'
    "\n"
    "== Pemilihan Gelombang & Jenis Seleksi ==\n"
    "Camaba -> UI : Pilih Menu Pendaftaran\n"
    "UI -> Controller : GET /api/camaba/registration-periods\n"
    "Controller -> DB : Query Gelombang Aktif\n"
    "DB --> Controller : Daftar Gelombang\n"
    "Controller --> UI : Daftar Gelombang Aktif\n"
    "UI --> Camaba : Tampilkan Pilihan Gelombang\n"
    "\n"
    "Camaba -> UI : Pilih Gelombang\n"
    "UI -> Controller : POST /api/camaba/select-gelombang\n"
    "Controller -> DB : Simpan Pilihan Gelombang\n"
    "\n"
    "UI -> Controller : GET /api/camaba/all-formulas?periodId=\n"
    "Controller -> DB : Query JenisSeleksi by Period\n"
    "DB --> Controller : Daftar Jenis Seleksi\n"
    "Controller --> UI : Daftar Jenis Seleksi\n"
    "UI --> Camaba : Tampilkan Pilihan Jenis Seleksi\n"
    "\n"
    "Camaba -> UI : Pilih Jenis Seleksi\n"
    "\n"
    "== Pengisian Formulir ==\n"
    "Camaba -> UI : Isi Formulir dan Upload Dokumen\n"
    "UI -> Controller : POST /api/camaba/submit-admission-form\n"
    "Controller -> DB : Simpan AdmissionForm (status VERIFIED)\n"
    "Controller -> DB : Buat FormValidation (status PENDING)\n"
    "DB --> Controller : Konfirmasi Tersimpan\n"
    "Controller --> UI : Formulir Tersimpan\n"
    "UI --> Camaba : Tampilkan Konfirmasi Submit\n"
    "\n"
    "== Pembuatan VA dan Pembayaran ==\n"
    "Camaba -> UI : Lanjut ke Halaman Pembayaran\n"
    "UI -> Controller : POST /api/camaba/create-virtual-account\n"
    "Controller -> BRIVA : Request Generate VA\n"
    "\n"
    "alt BRIVA Gagal\n"
    "  BRIVA --> Controller : Error\n"
    "  Controller --> UI : Pembuatan VA Gagal\n"
    "  UI --> Camaba : Tampilkan Pesan Gagal\n"
    "else BRIVA Berhasil\n"
    "  BRIVA --> Controller : Nomor VA\n"
    "  Controller -> DB : Simpan VirtualAccount (status ACTIVE)\n"
    "  Controller --> UI : Nomor VA + Detail Pembayaran\n"
    "  UI --> Camaba : Tampilkan Nomor VA BRIVA\n"
    "end\n"
    "\n"
    "Camaba -> BRIVA : Bayar ke BRIVA\n"
    "BRIVA -> Controller : Notifikasi Pembayaran Berhasil\n"
    "Controller -> DB : Update VirtualAccount status = PAID\n"
    "Controller --> UI : Status Lunas\n"
    "UI --> Camaba : Tampilkan Status Lunas\n"
    "\n"
    "@enduml\n"
    "```"
)

new_content = content[:d9a_start] + new_d9a + content[close_pos:]
with open(f, 'w', encoding='utf-8') as fh:
    fh.write(new_content)
print('Done. Lines:', new_content.count('\n') + 1)
print('D9a preview:', new_content[d9a_start:d9a_start+120])
