# Laporan Ketidaksesuaian Diagram Bab 3 dengan Kode Java

Tanggal audit: 20 April 2026  
Auditor: GitHub Copilot  
Sumber kode: `tugasakhir/src/main/java/com/uhn/pmb/`

---

## ðŸ”´ KRITIS â€” Gambar Harus Dibuat Ulang

### 1. `figure/class-diagram.png` â€” Struktur Entitas Salah Total

**Masalah:**
- Diagram menampilkan `AdminPusat`, `AdminValidasi`, dan `Camaba` sebagai **class terpisah** â€” ini salah besar.
- Di kode nyata, hanya ada **satu entity `User`** dengan enum `UserRole` (`STUDENT`, `ADMIN_PUSAT`, `ADMIN_VALIDASI`). Tidak ada class `AdminPusat` atau `AdminValidasi` sama sekali.
- `Camaba` di diagram seharusnya adalah entity **`Student`** (dengan atribut: `fullName`, `nik`, `birthDate`, `birthPlace`, `gender`, `address`, `phoneNumber`, `parentName`, `parentPhone`, `schoolOrigin`, `schoolYear`) yang berelasi `@OneToOne` ke `User`.
- `KonfigurasiSistem` di diagram punya atribut `periode`, `harga_formulir`, `batas_pendaftaran` â€” di kode nyata ini adalah tiga entity terpisah: `RegistrationPeriod` (periode), `ProgramStudi` (harga per prodi), dan `SystemConfiguration` (key-value store untuk konfigurasi).
- `FormulirPendaftaran` punya `virtual_account: string` â€” di kode nyata `VirtualAccount` adalah entity **terpisah**, bukan field di AdmissionForm.
- `NilaiUjian` di diagram â†’ di kode nyata ada `ExamResult` dan `ExamSubmission` sebagai entity terpisah.
- `DataDaftarUlang` â†’ di kode nyata ada `ReEnrollment`, `ReEnrollmentData`, `ReEnrollmentDocument`, `ReEnrollmentValidation` sebagai entity terpisah.

**Entity yang sama sekali tidak ada di diagram tapi ada di kode:**
`ExamToken`, `CicilanRequest`, `SelectionType`, `GelombangLinkUjian`, `FormValidation`, `VirtualAccount`, `PaymentBriva`, `Announcement`, `SystemLink`, `ContactInfo`, `AdminMessage`, `PublicationSchedule`, `HasilAkhir`, `StudentNPM`, dll.

**Yang harus dilakukan:** Buat ulang class diagram dengan struktur berikut:
- `User` (id, email, password, role: UserRole, isActive, emailVerified) â†’ implements UserDetails
- `UserRole` enum: STUDENT, ADMIN_PUSAT, ADMIN_VALIDASI
- `Student` @OneToOne â†’ `User` (id, fullName, nik, birthDate, birthPlace, gender, address, phoneNumber, parentName, parentPhone, schoolOrigin, schoolYear)
- `AdmissionForm` @ManyToOne â†’ `Student`, @ManyToOne â†’ `RegistrationPeriod`
- `FormValidation` @OneToOne â†’ `AdmissionForm`
- `VirtualAccount` @OneToOne â†’ `AdmissionForm`
- `CicilanRequest` @ManyToOne â†’ `Student`
- `Exam` @ManyToOne â†’ `Student`, `ExamToken`, `ExamResult`
- `ReEnrollment` @OneToOne â†’ `Student`
- `HasilAkhir` @OneToOne â†’ `Student`
- `RegistrationPeriod`, `ProgramStudi`, `SelectionType`

> âš ï¸ Teks deskripsi di chapter-3.tex sudah **benar** menggambarkan kode, tapi **gambarnya yang salah**.

---

### 2. `figure/erd.png` â€” Entitas Database Salah

**Masalah:**
- Diagram menampilkan `CAMABA`, `Admin_Pusat`, `Admin_Validasi` sebagai entity/tabel terpisah â€” **salah**. Di database nyata hanya ada **satu tabel `users`** dengan kolom `role` (STUDENT/ADMIN_PUSAT/ADMIN_VALIDASI).
- Tidak ada tabel `students` yang terpisah di ERD â€” padahal di kode ada tabel `students` yang menyimpan profil camaba dengan `user_id` sebagai foreign key.
- Entity `Formulir` terlalu disederhanakan â€” tabel nyata `admission_forms` punya kolom `jenis_seleksi_id`, `selection_type_id`, `form_type`, `program_studi_1/2/3`, dan puluhan kolom data pribadi.
- Entity `Pembayaran` tidak merepresentasikan tabel nyata `virtual_accounts` dan `payment_briva` yang terpisah.
- Entity `Ujian` terlalu sederhana â€” di kode nyata ada `exams`, `exam_results`, `exam_submissions`, `exam_tokens` sebagai tabel terpisah.
- Missing di ERD: `exam_tokens`, `cicilan_requests`, `program_studi`, `selection_types`, `gelombang_link_ujian`, `form_validations`, `re_enrollment_documents`, `hasil_akhir`, `system_links`, `announcements`, dll.

**Yang harus dilakukan:** Buat ulang ERD berbasis tabel database nyata. Minimal tampilkan:
- `users` (id, email, password, role, is_active, email_verified)
- `students` (id, user_id FK, full_name, nik, birth_date, birth_place, gender, address, ...)
- `admission_forms` (id, student_id FK, period_id FK, jenis_seleksi_id, selection_type_id, form_type, program_studi_1/2/3, full_name, nik, ...)
- `virtual_accounts` (id, admission_form_id FK, no_va, nominal, status)
- `cicilan_requests` (id, student_id FK, jumlah_cicilan, status)
- `registration_periods` (id, name, start_date, end_date, is_active)
- `program_studi` (id, kode, nama, fakultas, harga, cicilan_1 s.d. cicilan_6)
- `exams` (id, student_id FK, exam_link_id FK, status)
- `exam_tokens` (id, token, exam_link_id FK, is_used)
- `re_enrollments` (id, student_id FK, status)
- `hasil_akhir` (id, student_id FK, npm, status_kelulusan)

---

### 3. `figure/activity-pembayaran-formulir.png` â€” FILE SALAH/TERTUKAR

**Masalah KRITIS:**
- File ini berisi **gambar activity diagram LOGIN** (menampilkan alur Regristasi â†’ Login â†’ Menentukan Role â†’ Dashboard) â€” bukan diagram alur pembayaran formulir.
- Ini adalah kesalahan file yang sangat serius: dua file mungkin tertukar atau file pembayaran belum pernah dibuat.

**Yang harus dilakukan:** Buat file baru `activity-pembayaran-formulir.png` dengan alur yang benar:
1. Login â†’ Dashboard
2. Pilih Menu Pendaftaran â†’ Pilih Gelombang Aktif
3. Sistem cek status gelombang (aktif/tutup)
4. Pilih Jenis Seleksi (jenis formulir)
5. Isi Formulir Pendaftaran dan Upload Dokumen â†’ Submit
6. Sistem generate VA BRIVA â†’ Kirim email notifikasi VA ke Camaba
7. Camaba bayar via BRIVA
8. Sistem verifikasi pembayaran â†’ Update status Lunas â†’ Notifikasi berhasil

---

## ðŸŸ¡ SEDANG â€” Gambar Perlu Diperbaiki

### 4. `figure/activity-login-camaba.png` â€” Typo + Email vs Username

**Masalah:**
- Typo: **"Regristasi"** â†’ seharusnya "Registrasi"
- Typo: **"Memvalidasri"** â†’ seharusnya "Memvalidasi"
- Diagram menyebutkan **"Memeriksa Username dan password"** â€” di kode nyata login menggunakan **email** (bukan username). Entity `User` memakai `email` sebagai identifier, dan `getUsername()` mengembalikan `email`.

**Perbaikan:** Ganti teks "Username" â†’ "Email" di dalam diagram. Perbaiki typo.

---

### 5. `figure/activity-daftar-ulang.png` â€” Alur Login Salah

**Masalah:**
- Diagram menampilkan login daftar ulang dengan **"Input Nomor ujian dan tanggal lahir"** â€” ini salah. Di kode nyata, camaba login menggunakan **email dan password** yang sama dengan proses pendaftaran (bukan nomor ujian).
- Diagram menampilkan **"Pilih Menu Ganti Password"** sebagai bagian dari alur daftar ulang â€” ini tidak relevan dengan proses daftar ulang.
- Teks chapter-3 mendeskripsikan alur: camaba lulus â†’ login â†’ pilih menu daftar ulang â†’ isi formulir â†’ submit â†’ notif ke admin â†’ admin validasi â†’ terverifikasi/perlu revisi. Gambar tidak konsisten dengan teks.

**Perbaikan:** Hapus bagian "Input Nomor ujian dan tanggal lahir" serta "Ganti Password". Tunjukkan login biasa (email + password), lalu langsung ke alur daftar ulang.

---

### 6. `figure/activity-konfigurasi-admin.png` â€” Email vs Username + Fitur Tidak Ada

**Masalah:**
- Menampilkan **"Mengisi Username dan Password"** untuk tambah user â€” di kode nyata form tambah user menggunakan **email**, bukan username.
- Menampilkan **"Tambah/Edit/Hapus Field Form"** dan **"Set Status Wajib"** â€” fitur *dynamic form field management* ini **tidak ada** di kode nyata. Field formulir di kode bersifat tetap (hardcoded di entity `AdmissionForm`).
- Typo: **"Peringatan Ksealhan Data Login"** â†’ seharusnya "Peringatan Kesalahan Data Login"

**Perbaikan:** Ganti "Username" â†’ "Email". Hapus kotak "Tambah/Edit/Hapus Field Form" dan "Set Status Wajib" karena tidak sesuai kode. Perbaiki typo "Ksealhan".

---

### 7. `figure/activity-formulir-kartu-ujian.png` â€” Label Gelombang Membingungkan + Konten Terpotong

**Masalah:**
- Menampilkan **"Akses Formulir Gelombang 3"** di awal dan **"Akses Formulir Gelombang 2"** di tengah â€” label "Gelombang 3" dan "Gelombang 2" bersifat spesifik dan membingungkan; lebih tepat ditulis "Gelombang Aktif".
- Terdapat **kotak hitam besar** (black rectangle) di tengah diagram yang menutupi sebagian konten â€” ini adalah artefak editing yang mengganggu keterbacaan.
- Alur menampilkan "Menampilkan Halaman Pilih Metode" di bagian Gelombang 2 yang kemudian terpotong â€” tidak jelas apa yang terjadi selanjutnya.
- Langkah **pembayaran sebelum pengisian formulir** tidak terlihat jelas di diagram â€” padahal di kode, status pembayaran harus lunas sebelum formulir bisa diisi.

**Perbaikan:** Hapus black rectangle artifact. Ganti label "Gelombang 3/2" dengan "Gelombang Aktif". Tambahkan langkah pembayaran sebelum pengisian formulir.

---

## ðŸŸ¢ RINGAN â€” Catatan Minor

### 8. `figure/use-case-diagram.png` â€” Typo + Use Case Tidak Lengkap

- Typo: **"Regristasi"** â†’ "Registrasi"
- Use case **"Membuat VA Manual"** ada di tabel definisi use case di tex, tapi tidak tampil di diagram
- Beberapa use case dari kode tidak ada di diagram: cicilan, bulk download PDF, system links, pengumuman CRUD, token generation, status tracker
- **"Mengelola isi Formulir"** muncul di diagram tapi tidak ada di tabel definisi use case di tex â€” inkonsistensi

---

### 9. `figure/activity-ekspor-data.png` â€” Format Ekspor Tidak Sesuai

- Diagram menyebut format **"CSV/EXCEL"** â€” tapi chapter-3 text dan kode nyata mendukung **CSV, JSON, dan Cetak** (bukan Excel)
- Diagram menampilkan opsi "Kirim File ke admin pusat Melalui Gmail" â€” fitur ini tidak ada di kode nyata (hanya download langsung)
- Typo sama: "Peringatan Ksealhan Data Login" â†’ "Kesalahan"

---

### 10. `figure/arsitektur-mvc.png` â€” Nama Controller Disederhanakan

- Diagram menampilkan `CamabaController, AdminController` â€” kode nyata punya controller lebih banyak: `AuthController`, `StudentController`, `AdminPusatController`, `AdminValidasiController`, `PaymentController`, dll.
- Label **"Result Test"** di sisi SQL database tidak lazim â€” lebih tepat "Result Set" atau "Response"
- Secara konsep diagram ini masih bisa diterima sebagai representasi arsitektur tingkat tinggi

---

## Ringkasan

| File | Tingkat | Status |
|------|---------|--------|
| `class-diagram.png` | ðŸ”´ KRITIS | Buat ulang â€” struktur entity salah total |
| `erd.png` | ðŸ”´ KRITIS | Buat ulang â€” entity database salah total |
| `activity-pembayaran-formulir.png` | ðŸ”´ KRITIS | Buat baru â€” file berisi diagram login, bukan pembayaran |
| `activity-login-camaba.png` | ðŸŸ¡ SEDANG | Perbaiki typo + ganti Username â†’ Email + tambah end state |
| `activity-daftar-ulang.png` | ðŸŸ¡ SEDANG | Perbaiki alur login + tambah end state di semua cabang |
| `activity-konfigurasi-admin.png` | ðŸŸ¡ SEDANG | Ganti Username â†’ Email, hapus dynamic field + tambah end state |
| `activity-formulir-kartu-ujian.png` | ðŸŸ¡ SEDANG | Hapus black rectangle + tambah end state + perbaiki label |
| `activity-ekspor-data.png` | ðŸŸ¡ SEDANG | Ganti Excel â†’ JSON/Cetak + tambah end state + perbaiki typo |
| `activity-proses-ujian.png` | ðŸŸ¡ SEDANG | Tambah end state di cabang error |
| `sequence-user-login.png` | ðŸŸ¡ SEDANG | Kolom terlalu rapat â€” perlebar jarak antar lifeline |
| `sequence-pendaftaran-ujian.png` | ðŸŸ¡ SEDANG | Kolom terlalu rapat â€” perlebar jarak antar lifeline |
| `sequence-daftar-ulang.png` | ðŸŸ¡ SEDANG | Kolom agak rapat â€” perlebar sedikit |
| `use-case-diagram.png` | ðŸŸ¢ RINGAN | Perbaiki typo, tambah use case yang hilang |
| `arsitektur-mvc.png` | ðŸŸ¢ RINGAN | Opsional â€” bisa diterima sebagai diagram tingkat tinggi |
| `sequence-validasi.png` | âœ… OK | Jarak lifeline sudah cukup |
| `sequence-konfigurasi.png` | âœ… OK | Jarak lifeline sudah cukup |
| `diagram-konteks.png` | âœ… OK | Sudah sesuai dengan kode dan kebutuhan fungsional |
| `alur-penelitian.png` | âœ… OK | Tidak terkait langsung dengan kode |
| Semua `ui-*.png` | âœ… OK | Mockup UI, tidak perlu diverifikasi ke kode |

---

---

# BAGIAN B â€” Masalah End State Activity Diagram

Semua activity diagram **wajib** memiliki simbol **Activity Final Node âŠ™** (lingkaran penuh di dalam lingkaran) di **setiap jalur yang berakhir**, bukan hanya jalur sukses.

---

## B1. `activity-login-camaba.png` â€” End State Kurang di 3 Titik

**Yang sudah ada:** âŠ™ hanya di bawah "Menampilkan Halaman Dashboard" (jalur sukses)

**Yang harus ditambahkan âŠ™:**
1. Di bawah kotak **"Kembali Kehalaman Login"** â€” cabang setelah "Menampilkan Peringatan Akun Terdaftar"
2. Di bawah kotak **"Peringatan Kesalahan Email"** â€” cabang No dari verifikasi email lupa password
3. Di bawah kotak **"Peringatan Kesalahan Data Login"** â€” cabang No dari cek username/password

---

## B2. `activity-pembayaran-formulir.png` â€” File Ini DIAGRAM LOGIN, Bukan Pembayaran

File ini isinya sama persis dengan `activity-login-camaba.png` â€” file **salah total**. Harus dibuat ulang sebagai diagram pembayaran formulir (lihat Bagian C untuk prompt pembuatan ulang).

---

## B3. `activity-formulir-kartu-ujian.png` â€” End State Kurang + Black Rectangle

**Yang sudah ada:** âŠ™ hanya di paling bawah kanan (jalur Gelombang 2 â†’ Mengirim Notifikasi)

**Yang harus ditambahkan âŠ™:**
1. Di bawah kotak **"Peringatan Kesalahan Input data"** â€” cabang No dari decision validasi data
2. Di bawah kotak **"Download Kartu Ujian"** â€” jalur ini harus punya end state sebelum lanjut ke Gelombang 2 ATAU tandai dengan merge node jika memang dilanjutkan
3. Di bawah kotak **"Melakukan Ujian"** â€” cabang ini menggantung tanpa end state

**Tambahan:** Hapus kotak hitam besar (black rectangle artifact) di tengah diagram.

---

## B4. `activity-proses-ujian.png` â€” End State Kurang di 3 Titik

**Yang sudah ada:** âŠ™ hanya di jalur sukses "Menampilkan Status Kelulusan"

**Yang harus ditambahkan âŠ™:**
1. Di bawah kotak **"Peringatan Kesalahan Nomor"** â€” cabang No dari validasi token
2. Di bawah kotak **"Peringatan Ujian Belum Dimulai"** â€” cabang "waktu belum sesuai"
3. Jika ada cabang "Admin menolak" hasil ujian â†’ tambahkan âŠ™

---

## B5. `activity-daftar-ulang.png` â€” End State Kurang di 2 Titik

**Yang sudah ada:** âŠ™ tidak terlihat di semua cabang terminal

**Yang harus ditambahkan âŠ™:**
1. Di bawah alur **"Terverifikasi"** â†’ setelah "Status Terverifikasi" kirim ke camaba
2. Di bawah alur **"Perlu Revisi"** â†’ setelah notifikasi revisi dikirim ke camaba (lalu panah loop kembali ke "Isi Formulir" atau end state tergantung desain)

---

## B6. `activity-konfigurasi-admin.png` â€” End State Kurang di 4 Titik

**Yang sudah ada:** âŠ™ tidak ada sama sekali di diagram ini

**Yang harus ditambahkan âŠ™:**
1. Di bawah **"Peringatan Ksealhan Data Login"** â€” cabang No dari cek login
2. Setelah **"Mengedit Akun Admin Validasi"** â€” jika alur selesai
3. Setelah **"Menghapus Akun Admin Validasi"** â€” jika alur selesai
4. Setelah **"Menyimpan konfigurasi sistem"** / akhir alur konfigurasi gelombang

---

## B7. `activity-ekspor-data.png` â€” End State Kurang di 2 Titik

**Yang sudah ada:** âŠ™ hanya di bawah "pilih Download File" jalur bawah

**Yang harus ditambahkan âŠ™:**
1. Di bawah **"Peringatan Ksealhan Data Login"** â€” cabang No dari cek login
2. Di bawah **"Kirim File ke admin pusat"** â€” cabang ini menggantung tanpa end state

---

---

# BAGIAN C â€” Masalah Sequence Diagram (Kolom Terlalu Rapat)

---

## C1. `sequence-user-login.png` â€” 8 Lifeline Terlalu Sesak

**Masalah:** Diagram memiliki 8 participant (User, Form Register, Control Register, Form Login, Control Login, Dashboard, Control Data, Database). Dengan lebar kanvas standar, jarak antar lifeline hanya Â±1â€“2 cm sehingga pesan-pesan seperti "Validasi Pembuatan Gagal" dan "Validasi Pembuatan Berhasil" yang ada di sisi kanan **terpotong keluar dari bingkai** dan label panah berhimpitan.

**Perbaikan:**
- Perlebar kanvas diagram minimal **3Ã— lebar saat ini** (dari ~800px ke ~2400px)
- Jarak antar lifeline minimal **200px**
- Font label pesan minimal **11pt** agar terbaca
- Atau kurangi participant: gabungkan "Form Register" + "Control Register" menjadi satu layer "RegisterModule", dan "Form Login" + "Control Login" menjadi "LoginModule"

---

## C2. `sequence-pendaftaran-ujian.png` â€” 9 Lifeline Paling Parah

**Masalah:** Diagram memiliki 9 participant (Camaba, UI_PMB, PMB Controller, Pembelian Formulir, Formulir Pendaftaran, Ujian, BRIVA, Google Form, Database). Ini adalah diagram yang **paling rapat** â€” label panah "Request ke BRIVA", "Nomor VA", "Simpan Nilai" dll. saling tumpang tindih dengan lifeline-lifeline yang berdempetan.

**Perbaikan:**
- Perlebar kanvas minimal **3500px**
- Jarak antar lifeline minimal **250px** karena ada 9 participant
- Atau pisah menjadi 2 diagram terpisah: (1) diagram alur pembayaran+formulir, (2) diagram alur ujian
- Hapus participant "Ujian" yang hanya menerima satu pesan â€” gabungkan ke "PMB Controller"

---

## C3. `sequence-daftar-ulang.png` â€” 6 Lifeline Agak Rapat

**Masalah:** Label "Menampilkan Halaman Dashboard PMB dan Peringatan" terlalu panjang dan memotong antar lifeline. "Tidak Diverifikasi" dan "Diverfikasi" (typo: harusnya "Diverifikasi") tumpang tindih di sisi Admin Validasi.

**Perbaikan:**
- Perlebar kanvas ~20%
- Perbaiki typo "Diverfikasi" â†’ "Diverifikasi"
- Persingkat label panjang: "Menampilkan Dashboard PMB"

---

---

# BAGIAN D â€” Kode PlantUML Siap Render

**Cara pakai:**
1. Copy kode `@startuml` ... `@enduml` di bawah
2. Paste ke [plantuml.com/plantuml/uml/](https://www.plantuml.com/plantuml/uml/) atau VS Code extension PlantUML
3. Export PNG â†’ Ganti file di folder `figure/`

> **Catatan D2:** `activity-pembayaran-formulir.png` filenya salah total (isinya diagram login), kode di bawah adalah diagram pembayaran dari nol.
> **Catatan D9:** `sequence-pendaftaran-ujian.png` dipecah jadi 2 diagram terpisah karena 9 lifeline terlalu padat.

---

## D1. `activity-login-camaba.png`

```plantuml
@startuml
|Camaba|
start
:Akses Halaman Registrasi / Login;

if (Pilih Aksi?) then (Registrasi)
  :Mengisi Email, Password,
  dan Data Diri;

  |Sistem|
  :Memvalidasi Data;

  if (Email sudah terdaftar?) then (Ya)
    :Menampilkan Peringatan
    Akun Sudah Terdaftar;
    stop
  else (Tidak)
    :Menyimpan Akun;
    :Mengirim Email
    Verifikasi ke Camaba;
    stop
  endif

else if (Pilih Aksi?) then (Lupa Password)
  :Masukkan Email;

  |Sistem|
  :Memeriksa Email di Database;

  if (Email terdaftar?) then (Tidak)
    :Peringatan Kesalahan Email;
    stop
  else (Ya)
    :Mengirim Link Pemulihan
    Password ke Email;
    stop
  endif

else (Login)
  :Masukkan Email dan Password;

  |Sistem|
  :Memeriksa Email dan Password;

  if (Data valid?) then (Tidak)
    :Peringatan Kesalahan Data Login;
    stop
  else (Ya)
    if (Email terverifikasi?) then (Tidak)
      :Peringatan Email
      Belum Diverifikasi;
      stop
    else (Ya)
      :Menentukan Role;
      :Login Berhasil;
      :Menampilkan Halaman Dashboard;
      stop
    endif
  endif

endif

@enduml
```

---

## D2. `activity-pembayaran-formulir.png` *(buat dari nol â€” file lama isinya salah)*

```plantuml
@startuml
|Camaba|
start
:Login dengan
Email dan Password;

|Sistem|
:Verifikasi Login;
:Menampilkan Dashboard;

|Camaba|
:Pilih Menu Pendaftaran;

|Sistem|
:Cek Status Gelombang;

if (Gelombang aktif?) then (Tidak)
  :Menampilkan Pesan
  Gelombang Tutup;
  stop
else (Ya)
  :Tampilkan Pilihan
  Jenis Seleksi;
endif

|Camaba|
:Pilih Jenis Seleksi;
:Isi Formulir Pendaftaran
dan Upload Dokumen;
:Submit Formulir;

|Sistem|
:Simpan Formulir Pendaftaran;
:Generate Nomor
Virtual Account (BRIVA);
:Kirim Email
Notifikasi VA ke Camaba;

|Camaba|
:Bayar via BRIVA;

|Sistem|
:Verifikasi Pembayaran;

if (Pembayaran valid?) then (Tidak)
  :Notifikasi Gagal
  ke Camaba;
  stop
else (Ya)
  :Update Status
  Menjadi Lunas;
  :Notifikasi Berhasil
  ke Camaba;
  stop
endif

@enduml
```

---

## D3. `activity-formulir-kartu-ujian.png`

```plantuml
@startuml
|Camaba|
start
:Akses Formulir
Pendaftaran Gelombang Aktif;

|Sistem|
:Menampilkan Formulir Data;

|Camaba|
:Upload Berkas dan
Isi Data Diri;

|Sistem|
:Validasi Kelengkapan
dan Penulisan Data;

if (Data valid?) then (Tidak)
  :Peringatan Kesalahan
  Input Data;
  stop
else (Ya)
  :Simpan Formulir Pendaftaran;
  :Buat FormValidation
  (status PENDING);
  :Kirim Notifikasi Email
  ke Admin Validasi;
endif

|Admin Validasi|
:Review Formulir Pendaftaran;

if (Formulir sesuai?) then (Tidak)
  |Sistem|
  :Update Status Formulir
  Perlu Revisi;
  :Kirim Notifikasi Revisi
  ke Camaba;
  stop
else (Ya)
  |Sistem|
  :Update Status Formulir
  Terverifikasi (APPROVED);
  :Generate Token Ujian
  (ExamToken);
  :Kirim Email Token Ujian
  ke Camaba;
endif

|Camaba|
:Terima Token Ujian
via Email;
stop

@enduml
```

---

## D4. `activity-proses-ujian.png`

```plantuml
@startuml
|Camaba|
start
:Masukkan Token Ujian;

|Sistem|
:Validasi Token;

if (Token valid?) then (Tidak)
  :Peringatan Token Tidak Valid
  atau Sudah Kadaluarsa;
  stop
else (Ya)
  :Tampilkan Halaman Ujian
  (Google Form dari sistem);
endif

|Camaba|
:Submit Hasil Ujian;

|Sistem|
:Simpan Hasil Ujian;

|Admin|
:Verifikasi Hasil Ujian;
:Tentukan Status Kelulusan;

|Sistem|
:Update Status Kelulusan;
:Tampilkan Status
Kelulusan ke Camaba;
stop

@enduml
```

---

## D5. `activity-daftar-ulang.png`

```plantuml
@startuml
|Camaba|
start
:Login dengan
Email dan Password;

|Sistem|
:Verifikasi Login;
:Menampilkan Dashboard;

|Camaba|
:Pilih Menu Daftar Ulang;

|Sistem|
:Tampilkan Formulir
Daftar Ulang;

|Camaba|
:Isi Formulir dan Submit;

|Sistem|
:Simpan Data;
:Kirim Notifikasi
ke Admin Validasi;

|Admin Validasi|
:Konfirmasi Data;

if (Data sesuai?) then (Tidak)
  |Sistem|
  :Update Status
  Ditolak (REJECTED);
  :Notifikasi Penolakan
  ke Camaba;
  stop
else (Ya)
  |Sistem|
  :Update Status
  Tervalidasi (VALIDATED);
  :Upload Dokumen
  NPM Sementara dan
  KTM Sementara (PDF);
  :Kirim Dokumen ke Camaba;
  :Notifikasi ke Camaba;
  stop
endif

@enduml
```

---

## D6. `activity-konfigurasi-admin.png`

```plantuml
@startuml
|Admin Pusat|
start
:Login dengan
Email dan Password;

|Sistem|
:Cek Login;

if (Data valid?) then (Tidak)
  :Peringatan Kesalahan
  Data Login;
  stop
else (Ya)
  :Menampilkan Dashboard;
endif

|Admin Pusat|
if (Pilih Menu?) then (Kelola Akun)
  |Sistem|
  :Tampilkan Daftar Akun;
  |Admin Pusat|
  if (Aksi?) then (Ubah Role)
    :Pilih Akun User;
    :Pilih Role Baru
    (mis. ADMIN_VALIDASI);
    |Sistem|
    :Update Role User;
    :Konfirmasi Tersimpan;
    stop
  else (Hapus)
    :Pilih Akun User;
    |Sistem|
    :Hapus Akun User;
    stop
  endif
else if (Pilih Menu?) then (Konfigurasi Sistem)
  |Sistem|
  :Tampilkan Form Konfigurasi;
  |Admin Pusat|
  :Atur Jadwal Gelombang
  dan Harga Formulir;
  |Sistem|
  :Simpan Konfigurasi;
  stop
else (Kelola Program Studi)
  |Sistem|
  :Tampilkan Daftar
  Program Studi;
  |Admin Pusat|
  :Edit Harga Total Per Tahun
  dan Harga Per Cicilan (1-6);
  |Sistem|
  :Simpan Data Program Studi;
  stop
endif

@enduml
```

---

## D7. `activity-ekspor-data.png`

```plantuml
@startuml
|Admin Validasi|
start
:Login dengan
Email dan Password;

|Sistem|
:Cek Login;

if (Data valid?) then (Tidak)
  :Peringatan Kesalahan
  Data Login;
  stop
else (Ya)
  :Menampilkan Dashboard;
endif

|Admin Validasi|
:Pilih Menu Ekspor Data;
:Set Filter
(Fakultas/Prodi/Gelombang);
:Pilih Format
(CSV / JSON / Cetak);
:Tekan Tombol Ekspor;

|Sistem|
:Query Database
Sesuai Filter;
:Generate File
Sesuai Format;

|Admin Validasi|
:Download File;
stop

@enduml
```

---

## D8. `sequence-user-login.png`

```plantuml
@startuml
skinparam participantPadding 40
skinparam boxPadding 20
skinparam responseMessageBelowArrow true

actor User
boundary "LoginRegisterPage" as Page
control "AuthController" as Auth
control "UserService" as Service
database "Database" as DB

== Registrasi ==
User -> Page : Buka Website
Page --> User : Tampilkan Form
User -> Page : Isi Email & Password,\nKlik Register
Page -> Auth : POST /register
Auth -> Service : Validasi dan Simpan User
Service -> DB : INSERT user

alt Email Sudah Terdaftar
  DB --> Service : Duplikat
  Service --> Auth : Error email duplikat
  Auth --> Page : Gagal Register
  Page --> User : Peringatan Akun Sudah Ada
else Berhasil
  DB --> Service : Konfirmasi
  Service --> Auth : User tersimpan
  Auth -> Service : Kirim Email Verifikasi
  Service --> User : Email berisi link verifikasi
  Auth --> Page : Register Berhasil
  Page --> User : Pesan: Cek Email untuk Verifikasi
end

== Verifikasi Email ==
User -> Auth : Klik Link Verifikasi di Email
Auth -> Service : Validasi token verifikasi
Service -> DB : UPDATE email_verified = true
DB --> Service : Konfirmasi
Service --> Auth : Verifikasi Berhasil
Auth --> User : Akun Aktif, Silakan Login

== Login ==
User -> Page : Isi Email & Password,\nKlik Login
Page -> Auth : POST /login
Auth -> Service : Autentikasi email+password
Service -> DB : SELECT user WHERE email=?

alt Kredensial Salah
  DB --> Service : Not Found / Password salah
  Service --> Auth : Autentikasi Gagal
  Auth --> Page : Gagal Login
  Page --> User : Pesan Gagal Login
else Email Belum Diverifikasi
  DB --> Service : Data User (email_verified=false)
  Service --> Auth : Error: Email belum diverifikasi
  Auth --> Page : Gagal Login
  Page --> User : Pesan: Verifikasi Email Terlebih Dahulu
else Berhasil
  DB --> Service : Data User
  Service --> Auth : Generate JWT Token
  Auth --> Page : Token + Role
  Page --> User : Redirect ke Dashboard\nsesuai Role
end

@enduml
```

---

## D9a. `sequence-pendaftaran-formulir.png` *(Diagram 1 dari 2 - Formulir, VA & Pembayaran)*

```plantuml
@startuml
skinparam participantPadding 50
skinparam responseMessageBelowArrow true

actor Camaba
boundary "UI_PMB" as UI
control "PMBController" as Controller
entity "BRIVAService" as BRIVA
database "Database" as DB

== Pemilihan Gelombang & Jenis Seleksi ==
Camaba -> UI : Pilih Menu Pendaftaran
UI -> Controller : GET /api/camaba/registration-periods
Controller -> DB : Query Gelombang Aktif
DB --> Controller : Daftar Gelombang
Controller --> UI : Daftar Gelombang Aktif
UI --> Camaba : Tampilkan Pilihan Gelombang

Camaba -> UI : Pilih Gelombang
UI -> Controller : POST /api/camaba/select-gelombang
Controller -> DB : Simpan Pilihan Gelombang

UI -> Controller : GET /api/camaba/all-formulas?periodId=
Controller -> DB : Query JenisSeleksi by Period
DB --> Controller : Daftar Jenis Seleksi
Controller --> UI : Daftar Jenis Seleksi
UI --> Camaba : Tampilkan Pilihan Jenis Seleksi

Camaba -> UI : Pilih Jenis Seleksi

== Pengisian Formulir ==
Camaba -> UI : Isi Formulir dan Upload Dokumen
UI -> Controller : POST /api/camaba/submit-admission-form
Controller -> DB : Simpan AdmissionForm (status VERIFIED)
Controller -> DB : Buat FormValidation (status PENDING)
DB --> Controller : Konfirmasi Tersimpan
Controller --> UI : Formulir Tersimpan
UI --> Camaba : Tampilkan Konfirmasi Submit

== Pembuatan VA dan Pembayaran ==
Camaba -> UI : Lanjut ke Halaman Pembayaran
UI -> Controller : POST /api/camaba/create-virtual-account
Controller -> BRIVA : Request Generate VA

alt BRIVA Gagal
  BRIVA --> Controller : Error
  Controller --> UI : Pembuatan VA Gagal
  UI --> Camaba : Tampilkan Pesan Gagal
else BRIVA Berhasil
  BRIVA --> Controller : Nomor VA
  Controller -> DB : Simpan VirtualAccount (status ACTIVE)
  Controller --> UI : Nomor VA + Detail Pembayaran
  UI --> Camaba : Tampilkan Nomor VA BRIVA
end

Camaba -> BRIVA : Bayar ke BRIVA
BRIVA -> Controller : Notifikasi Pembayaran Berhasil
Controller -> DB : Update VirtualAccount status = PAID
Controller --> UI : Status Lunas
UI --> Camaba : Tampilkan Status Lunas

@enduml
```

## D9b. `sequence-pendaftaran-ujian.png` *(Diagram 2 dari 2 â€” Proses Ujian)*

```plantuml
@startuml
skinparam participantPadding 50
skinparam responseMessageBelowArrow true

actor Camaba
boundary "UI_PMB" as UI
control "PMBController" as Controller
entity "GoogleForm" as GF
database "Database" as DB

== Proses Ujian ==
Camaba -> UI : Masukkan Token Ujian
UI -> Controller : Validasi Token
Controller -> DB : Cek ExamToken

alt Token Salah
  DB --> Controller : Token tidak valid
  Controller --> UI : Tampilkan Error Token
  UI --> Camaba : Peringatan Token Salah
else Token Valid
  DB --> Controller : Token valid
  Controller --> UI : Tampilkan Halaman Ujian\n(iframe Google Form)
  Camaba -> GF : Ikuti Ujian
  GF -> Controller : Submit Jawaban
  Controller -> DB : Simpan ExamResult
  DB --> Controller : Konfirmasi
  Controller --> UI : Nilai tersimpan
  UI --> Camaba : Notifikasi Hasil / Lulus
end

@enduml
```

---

## D10. `sequence-daftar-ulang.png`

```plantuml
@startuml
skinparam participantPadding 40
skinparam responseMessageBelowArrow true

actor User
boundary "UI_PMB" as UI
control "PMBController" as Controller
control "ReEnrollmentService" as ReEnroll
actor "Admin Validasi" as Admin
database "Database" as DB

User -> UI : Login Berhasil
UI -> Controller : Ambil Data Formulir
Controller -> DB : Query data +\ncek status kelulusan

alt Belum Lulus Ujian
  DB --> Controller : Status belum lulus
  Controller --> UI : Tampilkan Dashboard +\nPeringatan Belum Lulus
  UI --> User : Peringatan Belum Bisa Daftar Ulang
else Sudah Lulus Ujian
  DB --> Controller : Data Camaba
  Controller --> UI : Data Camaba
  UI --> User : Tampilkan PMB
end

User -> UI : Pilih Menu Daftar Ulang
UI -> Controller : Isi Formulir Daftar Ulang
Controller -> ReEnroll : Simpan Data
ReEnroll -> DB : INSERT re_enrollment
DB --> ReEnroll : Berhasil Disimpan
ReEnroll -> Admin : Kirim Notifikasi Validasi

alt Ditolak
  Admin -> Controller : Tolak (dengan alasan)
  Controller -> DB : Update Status REJECTED
  DB --> Controller : Konfirmasi
  Controller --> UI : Notifikasi Status
  UI --> User : Daftar Ulang Ditolak
else Disetujui
  Admin -> Controller : Setujui
  Controller -> DB : Update Status VALIDATED
  DB --> Controller : Konfirmasi
  Controller --> UI : Notifikasi Status Tervalidasi
  UI --> User : Daftar Ulang Berhasil
end

@enduml
```

---

## D11. `class-diagram.png`

```plantuml
@startuml
skinparam classAttributeIconSize 0
skinparam classFontSize 12
skinparam shadowing false

enum UserRole {
  CAMABA
  ADMIN_PUSAT
  ADMIN_VALIDASI
}

enum Gender {
  MALE
  FEMALE
}

enum VAStatus {
  ACTIVE
  PAID
  EXPIRED
  CANCELLED
}

enum PaymentType {
  REGISTRATION_FORM
  INSTALLMENT_1
  INSTALLMENT_2
  INSTALLMENT_3
}

enum TokenStatus {
  ACTIVE
  USED
  EXPIRED
  REVOKED
}

enum HasilAkhirStatus {
  PENDING
  ACTIVE
  INACTIVE
}

class User {
  - id : Long
  - email : String
  - password : String
  - role : UserRole
  - isActive : Boolean
  - emailVerified : Boolean
  - emailVerificationToken : String
  - createdAt : LocalDateTime
  - updatedAt : LocalDateTime
}

class Student {
  - id : Long
  - fullName : String
  - nik : String
  - birthDate : LocalDate
  - birthPlace : String
  - gender : Gender
  - address : String
  - phoneNumber : String
  - parentName : String
  - parentPhone : String
  - schoolOrigin : String
  - schoolYear : String
}

class AdmissionForm {
  - id : Long
  - jenisSeleksiId : Long
  - selectionTypeId : Long
  - formType : String
  - programStudi1 : String
  - programStudi2 : String
  - programStudi3 : String
  - status : FormStatus
  - createdAt : LocalDateTime
}

class FormValidation {
  - id : Long
  - validationStatus : ValidationStatus
  - rejectionReason : String
  - validatedAt : LocalDateTime
}

class VirtualAccount {
  - id : Long
  - vaNumber : String
  - amount : BigDecimal
  - paymentType : PaymentType
  - status : VAStatus
  - expiredAt : LocalDateTime
  - createdAt : LocalDateTime
}

class CicilanRequest {
  - id : Long
  - jumlahCicilan : Integer
  - briva : String
  - status : String
  - createdAt : LocalDateTime
}

class RegistrationPeriod {
  - id : Long
  - name : String
  - waveType : WaveType
  - regStartDate : LocalDate
  - regEndDate : LocalDate
  - examDate : LocalDate
  - isActive : Boolean
}

class ProgramStudi {
  - id : Long
  - kode : String
  - nama : String
  - hargaTotalPerTahun : Long
  - cicilan1 : Long
  - cicilan2 : Long
  - cicilan3 : Long
  - cicilan4 : Long
  - cicilan5 : Long
  - cicilan6 : Long
}

class SelectionType {
  - id : Long
  - nama : String
  - deskripsi : String
}

class Exam {
  - id : Long
  - examNumber : String
  - gformUrl : String
  - status : ExamStatus
  - createdAt : LocalDateTime
}

class ExamToken {
  - id : Long
  - tokenValue : String
  - status : TokenStatus
  - expiresAt : LocalDateTime
  - usedAt : LocalDateTime
  - revokedAt : LocalDateTime
  - createdAt : LocalDateTime
}

class ExamResult {
  - id : Long
  - score : Double
  - status : ResultStatus
  - tokenValidated : Boolean
  - verifiedAt : LocalDateTime
}

class ReEnrollment {
  - id : Long
  - status : ReEnrollmentStatus
  - submittedAt : LocalDateTime
  - validatedAt : LocalDateTime
}

class HasilAkhir {
  - id : Long
  - nomorRegistrasi : String
  - brivaNumber : String
  - programStudiName : String
  - waveType : String
  - status : HasilAkhirStatus
  - createdAt : LocalDateTime
}

User "1" -- "1" Student : has >
User --> UserRole
Student --> Gender
Student "1" -- "0..*" AdmissionForm : submits >
AdmissionForm --> RegistrationPeriod
AdmissionForm "1" -- "0..1" FormValidation : validated by >
AdmissionForm "1" -- "0..*" VirtualAccount : paid via >
Student "1" -- "0..*" VirtualAccount : has >
Student "1" -- "0..*" CicilanRequest : requests >
Student "1" -- "0..*" Exam : takes >
Student "1" -- "0..*" ExamToken : owns >
Exam "1" -- "0..1" ExamResult : produces >
ExamResult "1" -- "0..1" ReEnrollment : triggers >
Student "1" -- "0..1" ReEnrollment : re-enrolls >
Student "1" -- "0..1" HasilAkhir : has result >
User "1" -- "0..1" HasilAkhir : linked to >
AdmissionForm --> SelectionType

@enduml
```

---

## D12. `erd.png`

```plantuml
@startuml
!define TABLE(name,desc) class name as "desc" << (T,#FFAAAA) >>
!define PK(x) <u>x</u>
!define FK(x) <i>x</i>
skinparam classFontSize 11
skinparam shadowing false
hide methods
hide stereotypes

TABLE(users, "users") {
  PK(id) : BIGINT
  email : VARCHAR(255)
  password : VARCHAR(255)
  role : ENUM('CAMABA','ADMIN_PUSAT','ADMIN_VALIDASI')
  is_active : TINYINT(1)
  email_verified : TINYINT(1)
  created_at : DATETIME
  updated_at : DATETIME
}

TABLE(students, "students") {
  PK(id) : BIGINT
  FK(user_id) : BIGINT
  full_name : VARCHAR(255)
  nik : VARCHAR(20)
  birth_date : DATE
  birth_place : VARCHAR(100)
  gender : ENUM('MALE','FEMALE')
  address : TEXT
  phone_number : VARCHAR(20)
  parent_name : VARCHAR(255)
  parent_phone : VARCHAR(20)
  school_origin : VARCHAR(255)
  school_year : VARCHAR(10)
}

TABLE(admission_forms, "admission_forms") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  FK(period_id) : BIGINT
  FK(selection_type_id) : BIGINT
  form_type : VARCHAR(50)
  program_studi_1 : VARCHAR(100)
  program_studi_2 : VARCHAR(100)
  program_studi_3 : VARCHAR(100)
  status : VARCHAR(50)
  created_at : DATETIME
}

TABLE(virtual_accounts, "virtual_accounts") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  FK(admission_form_id) : BIGINT
  va_number : VARCHAR(50)
  amount : DECIMAL(15,2)
  payment_type : ENUM('REGISTRATION_FORM','INSTALLMENT_1','INSTALLMENT_2','INSTALLMENT_3')
  status : ENUM('ACTIVE','PAID','EXPIRED','CANCELLED')
  expired_at : DATETIME
  created_at : DATETIME
}

TABLE(cicilan_requests, "cicilan_requests") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  jumlah_cicilan : INT
  briva : VARCHAR(50)
  status : VARCHAR(50)
  created_at : DATETIME
}

TABLE(registration_periods, "registration_periods") {
  PK(id) : BIGINT
  name : VARCHAR(100)
  wave_type : ENUM('EARLY_NO_TEST','RANKING_NO_TEST','REGULAR_TEST')
  reg_start_date : DATE
  reg_end_date : DATE
  exam_date : DATE
  is_active : TINYINT(1)
}

TABLE(program_studi, "program_studi") {
  PK(id) : BIGINT
  kode : VARCHAR(20)
  nama : VARCHAR(100)
  harga_total_per_tahun : BIGINT
  cicilan1 : BIGINT
  cicilan2 : BIGINT
  cicilan3 : BIGINT
  cicilan4 : BIGINT
  cicilan5 : BIGINT
  cicilan6 : BIGINT
}

TABLE(selection_types, "selection_types") {
  PK(id) : BIGINT
  nama : VARCHAR(100)
  deskripsi : TEXT
}

TABLE(exams, "exams") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  FK(period_id) : BIGINT
  exam_number : VARCHAR(50)
  gform_url : VARCHAR(500)
  status : ENUM('PENDING','STARTED','COMPLETED','GRADED','SUBMITTED','NOT_STARTED')
  created_at : DATETIME
}

TABLE(exam_tokens, "exam_tokens") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  token_value : VARCHAR(50)
  status : ENUM('ACTIVE','USED','EXPIRED','REVOKED')
  expires_at : DATETIME
  used_at : DATETIME
  revoked_at : DATETIME
  approved_form_id : BIGINT
  created_at : DATETIME
}

TABLE(exam_results, "exam_results") {
  PK(id) : BIGINT
  FK(exam_id) : BIGINT
  FK(student_id) : BIGINT
  score : DOUBLE
  status : ENUM('PASSED','FAILED','PENDING')
  token_validated : TINYINT(1)
  verified_at : DATETIME
}

TABLE(reenrollments, "reenrollments") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  FK(exam_result_id) : BIGINT
  status : ENUM('SUBMITTED','VALIDATED','REJECTED')
  submitted_at : DATETIME
  validated_at : DATETIME
}

TABLE(hasil_akhir, "hasil_akhir") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  FK(user_id) : BIGINT
  nomor_registrasi : VARCHAR(100)
  briva_number : VARCHAR(50)
  program_studi_name : VARCHAR(255)
  wave_type : VARCHAR(50)
  selection_type : VARCHAR(100)
  status : VARCHAR(50)
  created_at : DATETIME
}

users "1" -- "1" students : user_id
students "1" -- "0..*" admission_forms : student_id
students "1" -- "0..*" cicilan_requests : student_id
students "1" -- "0..*" exams : student_id
students "1" -- "0..*" exam_tokens : student_id
students "1" -- "0..*" virtual_accounts : student_id
students "1" -- "0..1" reenrollments : student_id
students "1" -- "0..1" hasil_akhir : student_id
users "1" -- "0..1" hasil_akhir : user_id
admission_forms "1" -- "0..*" virtual_accounts : admission_form_id
admission_forms --> registration_periods : period_id
admission_forms --> selection_types : selection_type_id
exams "1" -- "0..1" exam_results : exam_id
exam_results "1" -- "0..1" reenrollments : exam_result_id

@enduml
```
