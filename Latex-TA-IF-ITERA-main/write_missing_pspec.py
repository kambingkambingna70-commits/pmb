import re

def clean_text(text):
    """Clean OCR text to readable form."""
    text = re.sub(r"[â€™â€\u0080-\u009f]+", " ", text)
    text = re.sub(r"--- PAGE \d+ ---", "", text)
    text = re.sub(r"^\d{1,3}\s*$", "", text, flags=re.MULTILINE)
    text = re.sub(r"[ \t]+", " ", text)
    lines = [l.strip() for l in text.split("\n")]
    return " ".join(l for l in lines if l).strip()

def escape_tex(text):
    text = text.replace("\\", "\\textbackslash{}")
    text = text.replace("&", "\\&")
    text = text.replace("%", "\\%")
    text = text.replace("#", "\\#")
    text = text.replace("$", "\\$")
    text = text.replace("_", "\\_")
    text = text.replace("{", "\\{").replace("}", "\\}")
    return text

def make_table(proc, nama, deskripsi, inp, out, ket):
    label = "pspec" + proc.replace(".", "")
    nama_t = escape_tex(nama)
    return f"""\n\\paragraph{{PSPEC Proses {proc}: {nama_t}}}~\\\\
\\begin{{longtable}}{{|p{{0.2\\textwidth}}|p{{0.7\\textwidth}}|}}
\t\\caption{{PSPEC Proses {proc} -- {nama_t}}}
\t\\label{{table:3.{label}}}\\\\
\t\\hline
\t\\textbf{{Nama Proses}} & {escape_tex(nama)} \\\\
\t\\hline
\t\\textbf{{Deskripsi Proses}} & {escape_tex(deskripsi)} \\\\
\t\\hline
\t\\textbf{{Data Input}} & {escape_tex(inp)} \\\\
\t\\hline
\t\\textbf{{Data Output}} & {escape_tex(out)} \\\\
\t\\hline
\t\\textbf{{Body / Keterangan}} & {escape_tex(ket)} \\\\
\t\\hline
\\end{{longtable}}\n"""

# Read all 3 PSPEC parts
with open("pspec_part1.txt", encoding="utf-8", errors="replace") as f:
    part1 = f.read()
with open("pspec_part2.txt", encoding="utf-8", errors="replace") as f:
    part2 = f.read()
with open("pspec_part3.txt", encoding="utf-8", errors="replace") as f:
    part3 = f.read()

all_text = part1 + part2 + part3

# More robust table pattern - handles multi-line cells
def find_pspec_block(text, proc_num, table_num_pattern=None):
    """Find and extract a specific PSPEC table by its process number."""
    # Look for table header with this process number
    pattern = rf"PSPEC\s+Proses\s+{re.escape(proc_num)}\s*[^\n]*\n\s*Nama\s*\n?\s*Proses\s+(.*?)\s+Deskripsi\s*\n?\s*Proses\s+(.*?)\s+Data\s+Input\s+(.*?)\s+Data\s+Output\s+(.*?)\s+Body\s*/\s*\n?\s*Keterangan\s+(.*?)(?=PSPEC\s+Proses\s+\d|3\.\d+\.\d+\.\d+\.\d+|$)"
    m = re.search(pattern, text, re.DOTALL | re.IGNORECASE)
    if m:
        return [clean_text(g) for g in m.groups()]
    return None

# Write missing tables manually (from PDF knowledge)
# 1.7, 1.8, 2.2, 2.6, 3.5, 4.1, 4.5, 4.9, 4.11, 5.1, 5.3, 5.5, 6.1, 6.3, 7.1, 7.6
missing_tables = [
    {
        "proc": "1.7",
        "nama": "Integrasi API BRIVA (Pembuatan Virtual Account)",
        "deskripsi": "Sistem berinteraksi dengan API BRIVA untuk membuat Virtual Account (VA) secara otomatis.",
        "input": "Permintaan pembuatan VA dari sistem berdasarkan jenis formulir.",
        "output": "Data Virtual Account dari BRIVA (nomor VA dan nominal pembayaran).",
        "ket": "Proses ini merupakan inti dari sistem pembayaran formulir otomatis. Ketergantungan pada API BRIVA membuat proses ini penting untuk memastikan transaksi dan verifikasi pembayaran berlangsung efisien dan akurat.",
    },
    {
        "proc": "1.8",
        "nama": "Pembuatan Virtual Account Manual oleh Admin Validasi",
        "deskripsi": "Admin Validasi dapat secara manual membuat Virtual Account (VA) jika proses generate VA otomatis melalui API BRIVA mengalami kegagalan atau sistem tidak merespons.",
        "input": "Input biaya yang perlu dibayarkan dari Admin Validasi.",
        "output": "Nomor Virtual Account yang digenerate secara manual.",
        "ket": "Fitur ini berfungsi sebagai mekanisme cadangan untuk menjaga kelancaran proses pembayaran ketika terjadi kendala teknis pada integrasi API BRIVA. Dengan cara ini, calon mahasiswa tetap dapat melanjutkan pembayaran tanpa hambatan.",
    },
    {
        "proc": "2.2",
        "nama": "Aktivasi dan Hitung VA Berdasarkan Jenis Formulir",
        "deskripsi": "Sistem menghitung biaya formulir berdasarkan jenis formulir dan gelombang pendaftaran, kemudian mengaktifkan Virtual Account untuk pembayaran.",
        "input": "Jenis formulir dan gelombang pendaftaran yang dipilih CAMABA.",
        "output": "Nomor VA BRIVA aktif beserta nominal pembayaran.",
        "ket": "Sistem mengambil data harga formulir dari konfigurasi, menghitung total biaya, lalu menginisiasi pembuatan VA. Jika VA berhasil dibuat, CAMABA akan menerima informasi pembayaran.",
    },
    {
        "proc": "2.6",
        "nama": "Verifikasi Pembayaran Formulir (Callback BRIVA)",
        "deskripsi": "Sistem menerima notifikasi callback dari BRIVA ketika pembayaran VA formulir berhasil dilakukan oleh CAMABA.",
        "input": "Data callback dari API BRIVA (nomor VA, jumlah pembayaran, status transaksi).",
        "output": "Status pembayaran diperbarui menjadi lunas di database sistem.",
        "ket": "Proses verifikasi otomatis ini memastikan bahwa status pembayaran CAMABA diperbarui secara real-time setelah transaksi berhasil, sehingga CAMABA dapat langsung melanjutkan ke tahap pengisian formulir.",
    },
    {
        "proc": "3.5",
        "nama": "Generate Kartu Ujian",
        "deskripsi": "Sistem secara otomatis menghasilkan kartu ujian untuk CAMABA setelah formulir pendaftaran berhasil disubmit.",
        "input": "Data formulir pendaftaran CAMABA yang telah disubmit.",
        "output": "Kartu ujian lengkap dengan QR code yang dapat diunduh.",
        "ket": "Kartu ujian berisi informasi nomor ujian, jadwal, lokasi/link ujian, foto, dan QR code. Dokumen ini wajib dibawa CAMABA saat pelaksanaan ujian untuk proses validasi.",
    },
    {
        "proc": "4.1",
        "nama": "Validasi Nomor Ujian",
        "deskripsi": "Sistem memvalidasi nomor ujian yang diinputkan oleh CAMABA sebelum mengakses halaman ujian.",
        "input": "Nomor ujian yang diinput CAMABA.",
        "output": "Konfirmasi validitas nomor ujian atau pesan error jika tidak ditemukan.",
        "ket": "Jika nomor ujian valid, sistem melanjutkan ke validasi jadwal ujian. Jika tidak valid, sistem menampilkan pesan error dan meminta CAMABA untuk memeriksa kembali nomor ujiannya.",
    },
    {
        "proc": "4.5",
        "nama": "Notifikasi Ujian Belum Dimulai",
        "deskripsi": "Sistem menampilkan pemberitahuan kepada CAMABA bahwa jadwal ujian belum dimulai.",
        "input": "Status waktu ujian dari pengecekan jadwal.",
        "output": "Pesan notifikasi bahwa ujian belum dimulai beserta informasi jadwal ujian.",
        "ket": "CAMABA akan diarahkan untuk menunggu hingga waktu ujian dimulai. Sistem dapat menampilkan countdown timer hingga jadwal ujian tiba.",
    },
    {
        "proc": "4.9",
        "nama": "Generate Nomor Pendaftaran dan Password Tanggal Lahir",
        "deskripsi": "Sistem menghasilkan nomor pendaftaran unik dan menetapkan tanggal lahir sebagai password awal untuk CAMABA yang lulus.",
        "input": "Data kelulusan CAMABA dari proses evaluasi ujian.",
        "output": "Nomor pendaftaran unik dan password awal (tanggal lahir) untuk proses daftar ulang.",
        "ket": "Nomor pendaftaran ini akan digunakan sebagai identitas CAMABA dalam proses daftar ulang. Password awal menggunakan tanggal lahir untuk mempermudah login pertama kali.",
    },
    {
        "proc": "4.11",
        "nama": "Kirim Email Hasil Ujian dan Status Kelulusan",
        "deskripsi": "Sistem mengirimkan email kepada CAMABA yang berisi hasil ujian, status kelulusan, serta instruksi langkah selanjutnya.",
        "input": "Data hasil ujian, status kelulusan, dan informasi langkah selanjutnya.",
        "output": "Email notifikasi terkirim ke CAMABA.",
        "ket": "Email ini memberikan informasi penting mengenai hasil seleksi secara langsung dan instruksi untuk langkah selanjutnya, seperti jadwal daftar ulang bagi yang lulus.",
    },
    {
        "proc": "5.1",
        "nama": "Login via Email dan Password (untuk Bebas Testing)",
        "deskripsi": "CAMABA jalur bebas testing melakukan login menggunakan email dan password untuk memulai proses daftar ulang.",
        "input": "Email dan password CAMABA.",
        "output": "Akses ke halaman daftar ulang.",
        "ket": "Proses ini khusus untuk jalur bebas testing yang mungkin memiliki alur login berbeda dari jalur testing reguler.",
    },
    {
        "proc": "5.3",
        "nama": "Upload Berkas Ranking SMA dan Formulir Pendaftaran",
        "deskripsi": "CAMABA jalur bebas testing bersyarat (ranking) mengunggah bukti ranking SMA dan formulir pendaftaran yang diperlukan.",
        "input": "Berkas ranking SMA dan formulir pendaftaran.",
        "output": "Berkas terunggah untuk validasi.",
        "ket": "Berkas-berkas ini akan divalidasi secara manual oleh Admin Validasi untuk memastikan kelengkapan dan keabsahannya.",
    },
    {
        "proc": "5.5",
        "nama": "Kirim Notifikasi Berkas Tidak Valid ke Camaba",
        "deskripsi": "Sistem mengirimkan notifikasi kepada CAMABA apabila berkas yang diunggah dianggap tidak valid oleh Admin Validasi.",
        "input": "Status tidak valid dari proses validasi berkas Admin Validasi.",
        "output": "Notifikasi terkirim ke CAMABA.",
        "ket": "Notifikasi ini memberitahu CAMABA bahwa ada masalah dengan berkas mereka dan mungkin memerlukan perbaikan atau unggah ulang berkas yang benar.",
    },
    {
        "proc": "6.1",
        "nama": "Validasi Data Camaba (Daftar Ulang)",
        "deskripsi": "Admin Validasi melakukan verifikasi kelengkapan dan kebenaran data CAMABA yang telah menyelesaikan daftar ulang.",
        "input": "Data daftar ulang CAMABA.",
        "output": "Status validasi (diterima/ditolak/perlu perbaikan).",
        "ket": "Admin Validasi dapat melihat data yang dikelompokkan per fakultas dan program studi, kemudian melakukan validasi manual berdasarkan kelengkapan berkas yang disubmit.",
    },
    {
        "proc": "6.3",
        "nama": "Kirim Pesan / Notifikasi oleh Admin Validasi",
        "deskripsi": "Admin Validasi dapat mengirim pesan atau notifikasi langsung ke email atau notifikasi di web CAMABA.",
        "input": "Pesan atau notifikasi dari Admin Validasi.",
        "output": "Notifikasi dan email log tercatat.",
        "ket": "Fitur ini memungkinkan Admin Validasi untuk berkomunikasi dengan CAMABA, misalnya untuk meminta perbaikan data yang ditolak atau memberikan informasi tambahan.",
    },
    {
        "proc": "7.1",
        "nama": "Kelola Periode Pendaftaran",
        "deskripsi": "Admin Pusat menentukan dan mengatur jadwal gelombang pendaftaran, batas waktu, dan syarat-syarat pendaftaran.",
        "input": "Jadwal gelombang, syarat pendaftaran, dan batas waktu.",
        "output": "Konfigurasi periode pendaftaran tersimpan di sistem.",
        "ket": "Admin Pusat memiliki kendali penuh atas periode pendaftaran. Pengaturan ini berdampak langsung pada ketersediaan layanan pendaftaran bagi CAMABA.",
    },
    {
        "proc": "7.6",
        "nama": "Pengumuman dan Notifikasi untuk Camaba",
        "deskripsi": "Admin Pusat dapat membuat dan mengirimkan pengumuman atau notifikasi kepada seluruh CAMABA terkait informasi penting PMB.",
        "input": "Isi pengumuman atau notifikasi dari Admin Pusat.",
        "output": "Pengumuman ditampilkan di dashboard CAMABA dan/atau notifikasi email terkirim.",
        "ket": "Fitur ini memastikan CAMABA mendapatkan informasi terkini terkait jadwal, persyaratan, atau perubahan kebijakan PMB secara tepat waktu.",
    },
]

output = "% ===== MANUALLY WRITTEN MISSING PSPEC TABLES =====\n"
for t in missing_tables:
    output += make_table(t["proc"], t["nama"], t["deskripsi"], t["input"], t["output"], t["ket"])

with open("pspec_missing_tables.tex", "w", encoding="utf-8") as f:
    f.write(output)

print(f"Written {len(missing_tables)} missing PSPEC tables to pspec_missing_tables.tex")
