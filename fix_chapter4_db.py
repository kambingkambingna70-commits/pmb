with open('Latex-TA-IF-ITERA-main/chapters/chapter-4.tex', encoding='utf-8') as f:
    content = f.read()

# ===== REPLACEMENT 1: db-tables.png -> longtable of all DB tables =====
old1 = (
    "\\begin{figure}[H]\n"
    "\t\\centering\n"
    "\t% TODO: ganti dengan screenshot phpMyAdmin / DBeaver yang menampilkan 42 tabel pmb_uhn\n"
    "\t\\includegraphics[width=0.85\\textwidth]{figure/bab4/db-tables.png}\n"
    "\t\\caption{Daftar Tabel \\textit{Database} \\texttt{pmb\\_uhn} yang Dibuat Hibernate}\n"
    "\t\\label{fig:4.db.tables}\n"
    "\\end{figure}"
)

new1 = (
    "\\begin{longtable}{|p{0.38\\textwidth}|p{0.52\\textwidth}|}\n"
    "\t\\caption{Daftar Tabel \\textit{Database} \\texttt{pmb\\_uhn} yang Dibuat Hibernate}\n"
    "\t\\label{fig:4.db.tables}\\\\\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Tabel} & \\textbf{Deskripsi} \\\\\n"
    "\t\\hline\n"
    "\t\\endfirsthead\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Tabel} & \\textbf{Deskripsi} \\\\\n"
    "\t\\hline\n"
    "\t\\endhead\n"
    "\t\\texttt{users} & Akun autentikasi seluruh pengguna (camaba, admin pusat, admin validasi). \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{students} & Profil lengkap calon mahasiswa baru, berelasi 1:1 dengan \\texttt{users}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{program\\_studi} & Master data program studi beserta informasi biaya dan cicilan. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{registration\\_periods} & Data gelombang pendaftaran beserta jadwal dan jenis seleksi. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{selection\\_types} & Jenis seleksi yang tersedia dalam suatu gelombang pendaftaran. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{selection\\_program\\_studi} & Relasi banyak-ke-banyak antara seleksi dan program studi. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{period\\_jenis\\_seleksi} & Relasi antara gelombang pendaftaran dan jenis seleksi. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{jenis\\_seleksi} & Master data jenis seleksi (reguler, prestasi, ranking). \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{admission\\_forms} & Formulir pendaftaran yang diisi oleh camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{student\\_form\\_data} & Rincian isian formulir pendaftaran. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{form\\_validations} & Hasil validasi berkas pendaftaran oleh admin validasi. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{document\\_verification} & Status verifikasi dokumen yang diunggah camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{form\\_repair\\_status} & Catatan perbaikan formulir yang diminta admin. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{formula\\_selections} & Data pemilihan jalur seleksi oleh camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{virtual\\_accounts} & Nomor \\textit{virtual account} BRIVA untuk pembayaran formulir. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{payment\\_briva} & Rekaman transaksi pembayaran melalui BRIVA. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{cicilan\\_request} & Permintaan pembayaran cicilan biaya kuliah. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{university\\_bank\\_account} & Data rekening bank universitas untuk pembayaran manual. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exams} & Data ujian yang ditempuh oleh camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exam\\_tokens} & Token rahasia untuk mengakses sesi ujian. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exam\\_results} & Hasil akhir ujian setiap camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exam\\_submissions} & Rekaman submisi jawaban ujian per sesi. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exam\\_questions} & Bank soal ujian yang digunakan dalam sistem. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exam\\_links} & Tautan ujian yang ditetapkan per gelombang. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{gelombang\\_link\\_ujian} & Relasi antara gelombang pendaftaran dan tautan ujian. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reenrollments} & Data daftar ulang camaba yang dinyatakan lulus. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reenrollment\\_data} & Rincian isian formulir daftar ulang. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reenrollment\\_documents} & Dokumen yang diunggah pada proses daftar ulang. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reenrollment\\_validations} & Catatan validasi berkas daftar ulang oleh admin. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{hasil\\_akhir} & Rekaman final PMB: nomor BRIVA, nomor registrasi, dan status NPM. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{student\\_npm} & Nomor Pokok Mahasiswa (NPM) yang diterbitkan setelah daftar ulang. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{registration\\_status} & Pelacak status proses pendaftaran setiap camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{validation\\_status\\_tracker} & Pelacak status validasi admin secara mendetail. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{announcements} & Pengumuman publik yang ditampilkan di halaman beranda. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{admin\\_messages} & Pesan internal dari admin kepada camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{notifications} & Notifikasi sistem yang dikirimkan kepada pengguna. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{email\\_log} & Rekaman pengiriman email oleh sistem. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{password\\_reset\\_tokens} & Token sementara untuk proses \\textit{reset} kata sandi. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{contact\\_info} & Data kontak universitas yang ditampilkan di halaman publik. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{system\\_configurations} & Konfigurasi global sistem PMB. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{system\\_links} & Tautan eksternal yang digunakan dalam sistem. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{publication\\_schedule} & Jadwal publikasi pengumuman PMB. \\\\\n"
    "\t\\hline\n"
    "\\end{longtable}"
)

if old1 in content:
    content = content.replace(old1, new1, 1)
    print('OK: replaced db-tables.png')
else:
    print('ERROR: db-tables.png not found')
    # Debug
    idx = content.find('db-tables.png')
    print('Raw idx:', idx)

# ===== REPLACEMENT 2: db-users.png -> longtable users schema =====
old2 = (
    "\\begin{figure}[H]\n"
    "\t\\centering\n"
    "\t% TODO: ganti dengan screenshot struktur tabel users (DESC users) atau tampilan tabel di phpMyAdmin\n"
    "\t\\includegraphics[width=0.85\\textwidth]{figure/bab4/db-users.png}\n"
    "\t\\caption{Struktur Tabel \\texttt{users} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.users}\n"
    "\\end{figure}"
)

new2 = (
    "\\begin{longtable}{|p{0.28\\textwidth}|p{0.20\\textwidth}|p{0.42\\textwidth}|}\n"
    "\t\\caption{Struktur Tabel \\texttt{users} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.users}\\\\\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endfirsthead\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endhead\n"
    "\t\\texttt{id} & BIGINT & Kunci utama (\\textit{auto-increment}). \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{email} & VARCHAR(255) & Alamat surel unik sebagai identitas login. \\textit{NOT NULL, UNIQUE}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{password} & VARCHAR(255) & Kata sandi yang dienkripsi dengan BCrypt. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{role} & ENUM & Peran pengguna: \\texttt{STUDENT}, \\texttt{ADMIN\\_PUSAT}, atau \\texttt{ADMIN\\_VALIDASI}. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{is\\_active} & TINYINT(1) & Status aktif akun. \\textit{DEFAULT TRUE}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{email\\_verified} & TINYINT(1) & Status verifikasi surel. \\textit{DEFAULT FALSE}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{email\\_verification\\_token} & VARCHAR(255) & Token sementara untuk verifikasi surel. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{created\\_at} & DATETIME & Waktu pembuatan akun. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{updated\\_at} & DATETIME & Waktu terakhir akun diperbarui. \\\\\n"
    "\t\\hline\n"
    "\\end{longtable}"
)

if old2 in content:
    content = content.replace(old2, new2, 1)
    print('OK: replaced db-users.png')
else:
    print('ERROR: db-users.png not found')

# ===== REPLACEMENT 3: db-students.png -> longtable students schema =====
old3 = (
    "\\begin{figure}[H]\n"
    "\t\\centering\n"
    "\t% TODO: ganti dengan screenshot struktur tabel students\n"
    "\t\\includegraphics[width=0.85\\textwidth]{figure/bab4/db-students.png}\n"
    "\t\\caption{Struktur Tabel \\texttt{students} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.students}\n"
    "\\end{figure}"
)

new3 = (
    "\\begin{longtable}{|p{0.28\\textwidth}|p{0.20\\textwidth}|p{0.42\\textwidth}|}\n"
    "\t\\caption{Struktur Tabel \\texttt{students} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.students}\\\\\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endfirsthead\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endhead\n"
    "\t\\texttt{id} & BIGINT & Kunci utama (\\textit{auto-increment}). \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{user\\_id} & BIGINT & Kunci asing ke tabel \\texttt{users} (\\textit{ONE-TO-ONE, UNIQUE, NOT NULL}). \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{full\\_name} & VARCHAR(255) & Nama lengkap camaba. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{nik} & VARCHAR(255) & Nomor Induk Kependudukan. \\textit{UNIQUE, NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{birth\\_date} & DATE & Tanggal lahir camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{birth\\_place} & VARCHAR(255) & Tempat lahir camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{gender} & ENUM & Jenis kelamin: \\texttt{MALE} atau \\texttt{FEMALE}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{address} & TEXT & Alamat domisili camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{phone\\_number} & VARCHAR(255) & Nomor telepon camaba. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{parent\\_name} & VARCHAR(255) & Nama orang tua/wali. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{parent\\_phone} & VARCHAR(255) & Nomor telepon orang tua/wali. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{school\\_origin} & VARCHAR(255) & Nama sekolah asal. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{school\\_year} & VARCHAR(255) & Tahun kelulusan sekolah. \\\\\n"
    "\t\\hline\n"
    "\\end{longtable}"
)

if old3 in content:
    content = content.replace(old3, new3, 1)
    print('OK: replaced db-students.png')
else:
    print('ERROR: db-students.png not found')

# ===== REPLACEMENT 4: db-program-studi.png -> longtable program_studi schema =====
old4 = (
    "\\begin{figure}[H]\n"
    "\t\\centering\n"
    "\t% TODO: ganti dengan screenshot tabel program_studi beserta data 26 prodi\n"
    "\t\\includegraphics[width=0.9\\textwidth]{figure/bab4/db-program-studi.png}\n"
    "\t\\caption{Struktur dan Data Tabel \\texttt{program\\_studi} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.prodi}\n"
    "\\end{figure}"
)

new4 = (
    "\\begin{longtable}{|p{0.30\\textwidth}|p{0.18\\textwidth}|p{0.42\\textwidth}|}\n"
    "\t\\caption{Struktur Tabel \\texttt{program\\_studi} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.prodi}\\\\\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endfirsthead\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endhead\n"
    "\t\\texttt{id} & BIGINT & Kunci utama (\\textit{auto-increment}). \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{kode} & VARCHAR(255) & Kode singkat program studi, misalnya \\texttt{TI}, \\texttt{SI}. \\textit{UNIQUE, NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{nama} & VARCHAR(255) & Nama lengkap program studi. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{fakultas} & VARCHAR(100) & Nama fakultas yang menaungi program studi. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{is\\_medical} & TINYINT(1) & Penanda apakah program studi termasuk jalur kedokteran. \\textit{DEFAULT FALSE}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{is\\_active} & TINYINT(1) & Status aktif program studi. \\textit{NOT NULL, DEFAULT TRUE}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{harga\\_total\\_per\\_tahun} & BIGINT & Total biaya pendidikan per tahun. \\textit{DEFAULT 0}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{cicilan\\_1} & BIGINT & Nominal cicilan pertama. \\textit{DEFAULT 0}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{cicilan\\_2} & BIGINT & Nominal cicilan kedua. \\textit{DEFAULT 0}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{cicilan\\_3} & BIGINT & Nominal cicilan ketiga. \\textit{DEFAULT 0}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{cicilan\\_4} & BIGINT & Nominal cicilan keempat. \\textit{DEFAULT 0}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{cicilan\\_5} & BIGINT & Nominal cicilan kelima. \\textit{DEFAULT 0}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{cicilan\\_6} & BIGINT & Nominal cicilan keenam. \\textit{DEFAULT 0}. \\\\\n"
    "\t\\hline\n"
    "\\end{longtable}"
)

if old4 in content:
    content = content.replace(old4, new4, 1)
    print('OK: replaced db-program-studi.png')
else:
    print('ERROR: db-program-studi.png not found')

# ===== REPLACEMENT 5: db-registration-periods.png -> longtable schema =====
old5 = (
    "\\begin{figure}[H]\n"
    "\t\\centering\n"
    "\t% TODO: ganti dengan screenshot tabel registration_periods\n"
    "\t\\includegraphics[width=0.85\\textwidth]{figure/bab4/db-registration-periods.png}\n"
    "\t\\caption{Struktur Tabel \\texttt{registration\\_periods} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.periods}\n"
    "\\end{figure}"
)

new5 = (
    "\\begin{longtable}{|p{0.33\\textwidth}|p{0.18\\textwidth}|p{0.39\\textwidth}|}\n"
    "\t\\caption{Struktur Tabel \\texttt{registration\\_periods} pada \\textit{Database} \\texttt{pmb\\_uhn}}\n"
    "\t\\label{fig:4.db.periods}\\\\\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endfirsthead\n"
    "\t\\hline\n"
    "\t\\textbf{Nama Kolom} & \\textbf{Tipe Data} & \\textbf{Keterangan} \\\\\n"
    "\t\\hline\n"
    "\t\\endhead\n"
    "\t\\texttt{id} & BIGINT & Kunci utama (\\textit{auto-increment}). \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{name} & VARCHAR(255) & Nama gelombang, misalnya \\textit{Gelombang 1}. \\textit{UNIQUE, NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reg\\_start\\_date} & DATETIME & Tanggal mulai periode pendaftaran. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reg\\_end\\_date} & DATETIME & Tanggal berakhir periode pendaftaran. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exam\\_date} & DATETIME & Tanggal pelaksanaan ujian seleksi. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{exam\\_end\\_date} & DATETIME & Tanggal berakhir sesi ujian. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{announcement\\_date} & DATETIME & Tanggal pengumuman hasil seleksi. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reenrollment\\_start\\_date} & DATETIME & Tanggal mulai periode daftar ulang. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{reenrollment\\_end\\_date} & DATETIME & Tanggal berakhir periode daftar ulang. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{wave\\_type} & ENUM & Jenis gelombang: \\texttt{REGULAR\\_TEST}, \\texttt{EARLY\\_NO\\_TEST}, atau \\texttt{RANKING\\_NO\\_TEST}. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\t\\texttt{status} & ENUM & Status gelombang: \\texttt{OPEN}, \\texttt{CLOSED}, atau \\texttt{UPCOMING}. \\textit{NOT NULL}. \\\\\n"
    "\t\\hline\n"
    "\\end{longtable}"
)

if old5 in content:
    content = content.replace(old5, new5, 1)
    print('OK: replaced db-registration-periods.png')
else:
    print('ERROR: db-registration-periods.png not found')

with open('Latex-TA-IF-ITERA-main/chapters/chapter-4.tex', 'w', encoding='utf-8') as f:
    f.write(content)

print('File saved.')
