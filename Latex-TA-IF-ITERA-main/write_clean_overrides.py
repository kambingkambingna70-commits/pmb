"""
Write all corrected/clean PSPEC tables to pspec_clean_overrides.tex.
These override any corrupted entries from pspec_new_tables.tex.
"""

def make_table(proc, nama, deskripsi, inp, out, ket):
    def esc(s):
        s = s.replace("\\", "\\textbackslash{}")
        s = s.replace("&", "\\&")
        s = s.replace("%", "\\%")
        s = s.replace("#", "\\#")
        s = s.replace("$", "\\$")
        s = s.replace("_", "\\_")
        return s
    label = "pspec" + proc.replace(".", "")
    return (
        f"\n\\paragraph{{PSPEC Proses {proc}: {esc(nama)}}}~\\\\\n"
        f"\\begin{{longtable}}{{|p{{0.2\\textwidth}}|p{{0.7\\textwidth}}|}}\n"
        f"\t\\caption{{PSPEC Proses {proc} -- {esc(nama)}}}\n"
        f"\t\\label{{table:3.{label}}}\\\\\n"
        f"\t\\hline\n"
        f"\t\\textbf{{Nama Proses}} & {esc(nama)} \\\\\n"
        f"\t\\hline\n"
        f"\t\\textbf{{Deskripsi Proses}} & {esc(deskripsi)} \\\\\n"
        f"\t\\hline\n"
        f"\t\\textbf{{Data Input}} & {esc(inp)} \\\\\n"
        f"\t\\hline\n"
        f"\t\\textbf{{Data Output}} & {esc(out)} \\\\\n"
        f"\t\\hline\n"
        f"\t\\textbf{{Body / Keterangan}} & {esc(ket)} \\\\\n"
        f"\t\\hline\n"
        f"\\end{{longtable}}\n"
    )

clean_tables = [
    # 3.4: Fix unescaped & in Data Output (Kartu Ujian & Nomor Ujian)
    {
        "proc": "3.4",
        "nama": "Generate Kartu Ujian",
        "deskripsi": "Sistem secara otomatis menggenerasi kartu ujian setelah CAMABA berhasil mengisi dan menyimpan formulir pendaftaran.",
        "input": "Data CAMABA yang telah terverifikasi dari Data Formulir dan Berkas.",
        "output": "Kartu ujian dalam format PDF dengan QR Code, tersimpan di Kartu Ujian dan Nomor Ujian.",
        "ket": "Kartu ujian berisi informasi CAMABA, jadwal ujian, dan QR Code untuk absensi. Kartu dapat diunduh dan dicetak oleh CAMABA.",
    },
    # 3.5: Correct content (Validasi Nomor Ujian, not Generate Kartu Ujian)
    {
        "proc": "3.5",
        "nama": "Validasi Nomor Ujian",
        "deskripsi": "Sistem memvalidasi nomor ujian yang diinputkan oleh calon mahasiswa baru (CAMABA) untuk memastikan nomor tersebut terdaftar dan valid.",
        "input": "Nomor Ujian dari CAMABA.",
        "output": 'Notifikasi "Ditemukan No Pendaftaran" jika nomor valid atau "Tidak Ditemukan No Pendaftaran" jika tidak valid.',
        "ket": "Proses ini krusial untuk memastikan bahwa hanya CAMABA yang memiliki nomor ujian yang sah yang dapat melanjutkan ke tahap ujian. Jika nomor ujian tidak ditemukan, CAMABA akan menerima pesan kesalahan dan tidak dapat melanjutkan.",
    },
    # 4.4: Fix severely corrupted paragraph title
    {
        "proc": "4.4",
        "nama": "Akses Google Form Ujian",
        "deskripsi": "Sistem mengarahkan CAMABA ke Google Form yang berisi soal ujian. Nomor ujian CAMABA akan otomatis terisi (\\textit{prefilled}) di Google Form.",
        "input": 'Status "Waktu Tepat" dari proses 4.2 Validasi Tanggal Ujian.',
        "output": "Halaman Google Form Ujian dengan nomor ujian yang sudah terisi otomatis.",
        "ket": "Hal ini memudahkan CAMABA dalam mengikuti ujian karena tidak perlu menginput ulang nomor ujian, serta menjamin integritas data ujian dengan menghubungkan langsung ke nomor ujian yang valid.",
    },
    # 6.5: Fix corrupted paragraph title
    {
        "proc": "6.5",
        "nama": "Jawab Pertanyaan (oleh Admin Validasi)",
        "deskripsi": "Admin Validasi dapat menjawab pertanyaan yang diajukan oleh CAMABA.",
        "input": "Jawaban dari Admin Validasi.",
        "output": "Jawaban terkirim ke CAMABA.",
        "ket": "Adanya kotak masuk pesan dan tanda pesan yang belum terjawab membantu admin dalam melacak dan menanggapi pertanyaan CAMABA secara efisien.",
    },
    # 7.5: Fix OCR overflow
    {
        "proc": "7.5",
        "nama": "Kelola Info Landing Page",
        "deskripsi": "Admin Pusat mengelola konten informasi umum yang ditampilkan di halaman utama (\\textit{landing page}) sistem PMB, seperti jadwal, pengumuman, dll.",
        "input": "Konten informasi yang akan ditampilkan.",
        "output": "Konfigurasi informasi \\textit{landing page} tersimpan di Konfigurasi Sistem.",
        "ket": "Memungkinkan admin untuk selalu memperbarui informasi penting bagi CAMABA dan pengunjung.",
    },
    # 7.7: Clean version (remove OCR artifact "3.5.8.10 Data Store")
    {
        "proc": "7.7",
        "nama": "Pratinjau Tampilan UI",
        "deskripsi": "Admin Pusat dapat melihat tampilan sistem dari perspektif Admin Validasi atau CAMABA.",
        "input": "Permintaan pratinjau dari Admin Pusat.",
        "output": "Tampilan sistem sesuai perspektif yang dipilih.",
        "ket": "Ini membantu Admin Pusat untuk memverifikasi bagaimana informasi dan perubahan yang mereka buat akan terlihat oleh pengguna lain sebelum dipublikasikan secara luas.",
    },
]

output = "% ===== CLEAN OVERRIDE TABLES =====\n"
for t in clean_tables:
    output += make_table(t["proc"], t["nama"], t["deskripsi"], t["input"], t["output"], t["ket"])

with open("pspec_clean_overrides.tex", "w", encoding="utf-8") as f:
    f.write(output)

print(f"Written {len(clean_tables)} clean override tables")
