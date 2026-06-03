# Fitur yang ADA di Sistem (HTML) tapi TIDAK ADA / BERBEDA di Laporan

> Perbandingan antara implementasi di folder `tugasakhir/` dengan deskripsi di laporan LaTeX `Latex-TA-IF-ITERA-main/`
> 
> **Legenda Status:**
> - ✅ = Sudah sesuai / sudah diperbaiki di laporan
> - ⚠️ = Sebagian tercakup di laporan, tapi kurang detail
> - ❌ = Belum ada sama sekali di laporan
> - 🔧 = Masalah di sistem (bukan laporan)

---

## A. FITUR YANG ADA DI SISTEM TAPI TIDAK DISEBUTKAN DI LAPORAN

### ✅ 1. Halaman Pilih Formula / Jenis Seleksi (`formula-selection.html`) — **SUDAH DIPERBAIKI**
- Sistem memiliki halaman tersendiri untuk memilih jenis seleksi/formula setelah memilih gelombang (step 2: Gelombang → **Formula** → Formulir)
- Menampilkan kartu-kartu formula dengan ikon, deskripsi, fitur, dan harga
- Endpoint: `GET /api/camaba/all-formulas?periodId={id}`
- **Di laporan**: F043 sekarang menyebutkan "memilih gelombang, memilih jenis seleksi (formula) melalui halaman pilihan yang menampilkan detail harga dan deskripsi". **SUDAH DIPERBAIKI**

### ❌ 2. Upload Pembayaran Manual (`payment-briva.html`)
- Sistem mendukung **dua metode pembayaran**: Virtual Account BRIVA dan Upload Manual (bukti transfer)
- Ada modal upload file (JPG, PNG, PDF max 10MB) dengan drag-and-drop
- Endpoint: `submitManualPayment()` untuk upload bukti pembayaran
- **Di laporan**: F017 hanya menyebutkan pembayaran via BRIVA Virtual Account. Tidak ada opsi upload manual

### ✅ 3. Halaman Pembayaran Cicilan Mahasiswa (`payment-cicilan.html`) — **SUDAH DIPERBAIKI**
- Sistem memiliki halaman cicilan dengan flow multi-step:
  1. Pilih program studi + jumlah cicilan (1–6x)
  2. Tunggu approval admin
  3. Bayar via VA simulasi atau upload manual
- Ada kalkulasi otomatis: `cicilan lainnya = (total - cicilan1) ÷ sisa cicilan`
- Auto-refresh status setiap 30 detik
- **Di laporan**: F011 sekarang mencakup approval/rejection cicilan oleh admin. F012 sekarang menyebutkan "Camaba dapat memilih jumlah cicilan dan memantau status persetujuan serta pembayaran cicilan". **SUDAH DIPERBAIKI**

### ✅ 4. Halaman Revisi Formulir (`revision-form.html`) — **SUDAH DIPERBAIKI**
- Sistem memiliki halaman khusus untuk merevisi formulir setelah ditolak admin
- Menampilkan alasan penolakan admin + status pembayaran tetap terjaga
- Pre-fill semua data sebelumnya dari API
- Field lengkap: data pribadi, alamat, data ayah, data ibu, alamat orang tua, data sekolah, upload dokumen
- Endpoint: `PUT /api/camaba/submit-revision/${formId}`
- **Di laporan**: F033 sekarang menyebutkan "disertai alasan penolakan, dan camaba dapat merevisi formulir melalui halaman revisi khusus yang menampilkan data sebelumnya". **SUDAH DIPERBAIKI**

### ✅ 5. Mode Ujian Offline (`ujian.html`)
- Sistem mendukung **dua mode ujian**: Online (Google Form) dan Offline (upload bukti foto)
- Mode offline: mahasiswa upload foto bukti ujian
- **Di laporan**: ~~Hanya menyebutkan ujian online~~ → **SUDAH DIPERBAIKI**. F021 dan F045 sekarang menyebutkan "Google Form dalam iframe atau opsi unggah bukti ujian offline"

### ✅ 6. Konfigurasi Link Ujian Online/Offline (`dashboard-admin-pusat.html`)
- Admin Pusat bisa mengatur link ujian per gelombang sebagai:
  - **Online**: URL Google Form
  - **Offline**: Tanggal, tempat, dan waktu ujian
- Endpoint: `POST /admin/api/exam-links`, `POST /admin/api/ujian-links`
- **Di laporan**: ~~Hanya menyebutkan Google Form~~ → **SUDAH DIPERBAIKI**. F007 sekarang menyebutkan "tautan ujian (Google Form atau ujian offline) dan mengelola token ujian"

### ❌ 7. Manajemen System Links (`dashboard-admin-pusat.html`)
- Admin Pusat bisa mengelola link sistem eksternal (YouTube, Google Drive, Google Form, External URL)
- CRUD lengkap: nama, tipe, URL, deskripsi
- **Di laporan**: Tidak disebutkan fitur manajemen system links

### ❌ 8. Manajemen Informasi Kontak (`dashboard-admin-pusat.html`)
- Admin Pusat bisa mengedit informasi kontak (alamat, telepon, email, jam layanan)
- Footer halaman publik mengambil data kontak secara dinamis dari API (`GET /api/public/settings/contact-info`)
- **Di laporan**: Tidak disebutkan sebagai fitur terpisah

### ✅ 9. Modul Pengumuman CRUD (`dashboard-admin-pusat.html`) — **SUDAH DIPERBAIKI**
- Admin Pusat memiliki modul pengumuman lengkap (Create/Read/Update/Delete)
- Endpoint: `GET/POST/PUT/DELETE /admin/api/announcements`
- **Di laporan**: F005 sekarang menyebutkan "mengelola modul pengumuman dengan operasi CRUD (Create, Read, Update, Delete)". **SUDAH DIPERBAIKI**

### ✅ 10. Sistem Token Ujian (`dashboard-admin-validasi.html`, `ujian.html`)
- Admin Validasi men-generate token ujian per mahasiswa
- Mahasiswa harus memasukkan token untuk mengakses ujian
- Flow: Admin generate → mahasiswa lihat token → input token → validasi → mulai ujian
- Endpoint: `POST /admin/api/validasi/formulir/{id}/generate-exam-token`, `POST /api/exam/validate-token`
- **Di laporan**: ~~Menyebutkan validasi nomor ujian~~ → **SUDAH DIPERBAIKI**. F007, F021, F022, F045 sekarang semua menyebutkan "token ujian yang di-generate admin"

### ❌ 11. Verifikasi Pembayaran Manual oleh Admin (`dashboard-admin-validasi.html`)
- Admin Validasi bisa memverifikasi/menolak pembayaran manual mahasiswa
- Endpoint: `POST /admin/payment/manual/{id}/verify`, `POST /admin/payment/manual/{id}/reject`
- **Di laporan**: Tidak disebutkan. Laporan hanya menyebutkan BRIVA otomatis

### ✅ 12. Manajemen Cicilan oleh Admin (`dashboard-admin-validasi.html`) — **SUDAH DIPERBAIKI**
- Admin Validasi bisa approve/reject request cicilan mahasiswa
- Endpoint: `POST /admin/cicilan/{id}/approve`, `POST /admin/cicilan/{id}/reject`
- **Di laporan**: F011 sekarang menyebutkan "Admin validasi dapat menyetujui atau menolak permintaan cicilan dari camaba". Tabel karakteristik Admin Validasi juga diupdate. **SUDAH DIPERBAIKI**

### ✅ 13. Download PDF Bulk (`dashboard-admin-validasi.html`) — **SUDAH DIPERBAIKI**
- Admin bisa download semua PDF mahasiswa yang disetujui sekaligus
- Endpoint: `GET /admin/api/download-all-approved-pdf`
- **Di laporan**: F032 sekarang menyebutkan "Admin juga dapat mengunduh dokumen PDF camaba secara massal (bulk download)". Tabel karakteristik Admin Validasi juga diupdate. **SUDAH DIPERBAIKI**

### ⚠️ 14. 4 Halaman Export Terpisah
- `export-admission-forms.html` — Export data formulir pendaftaran
- `export-reenrollments.html` — Export data daftar ulang
- `export-hasil-akhir.html` — Export hasil akhir + dokumen
- `export-hasil-akhir-by-wave.html` — Export hasil akhir per gelombang
- Semua mendukung format: **CSV, JSON, Print**
- **Di laporan**: F032 menyebutkan export CSV/XLSX. **Sudah tercakup secara umum**, tapi tidak mendeskripsikan 4 halaman terpisah dan format JSON

### ❌ 15. Modal UKT (`components/header.html`, `index.html`)
- Header memiliki tombol "Biaya/UKT" yang membuka modal berisi PDF dari Google Drive
- Endpoint: `GET /api/public/settings/system-links/name/UKT`
- **Di laporan**: Tidak disebutkan fitur modal UKT

### ❌ 16. Dropdown Fakultas dengan Link Eksternal (`components/header.html`, `index.html`)
- Navigasi memiliki dropdown berisi 11 link ke website fakultas eksternal
- **Di laporan**: Tidak disebutkan

### ⚠️ 17. Customer Service Chat Widget (`dashboard-camaba.html`, `components/header.html`)
- Floating button CS di halaman mahasiswa yang membuka modal chat
- Badge notifikasi pesan belum dibaca
- Polling pesan baru setiap 5 detik
- **Di laporan**: F034, F035, F044 menyebutkan pengiriman pesan. **Sudah tercakup konsepnya**, tapi tidak mendeskripsikan implementasi sebagai floating chat widget

### ✅ 18. Admin Pusat Bisa Membuat Semua Jenis Akun (`dashboard-admin-pusat.html`) — **SUDAH DIPERBAIKI**
- Admin Pusat bisa membuat akun: ADMIN_PUSAT, ADMIN_VALIDASI, dan CAMABA
- **Di laporan**: F010 sekarang menyebutkan "Manajemen akun pengguna — Admin pusat dapat menambah atau menghapus akun admin pusat, admin validasi, dan camaba". **SUDAH DIPERBAIKI**

### ❌ 19. Password Strength Indicator (`register.html`)
- Indikator kekuatan password visual (5 level: Lemah → Sangat Kuat)
- Mengecek: panjang ≥8, huruf kecil, huruf besar, angka, karakter spesial
- **Di laporan**: Tidak disebutkan

### ❌ 20. Gallery Carousel di Landing Page (`index.html`)
- Hero carousel (3 slide, auto-rotate 3 detik) dan gallery carousel (4 gambar kampus, auto-rotate 5 detik)
- **Di laporan**: Tidak disebutkan desain carousel

### ✅ 21. Program Studi CRUD Lengkap (`dashboard-admin-pusat.html`) — **SUDAH DIPERBAIKI**
- Admin Pusat CRUD penuh untuk program studi: kode, nama, tipe, harga per tahun, cicilan 1, status aktif
- **Di laporan**: Tabel karakteristik Admin Pusat sekarang menyebutkan "Mengelola program studi (kode, nama, tipe, harga, status)". **SUDAH DIPERBAIKI**

---

## B. PERBEDAAN ALUR / IMPLEMENTASI

### ✅ 1. Urutan Alur Pendaftaran — **SUDAH DIPERBAIKI**
- **Sebelumnya di laporan**: Bayar → Baru isi formulir (PSPEC 2.6, 3.1, TC004)
- **Di sistem**: Pilih Gelombang → Pilih Formula → **Isi Formulir** → Bayar
- **Status**: PSPEC 2.6, PSPEC 3.1, TC004, dan tabel karakteristik pengguna sudah diupdate. Activity diagram dan flowchart sudah sesuai (formulir → bayar). **SELESAI**

### ✅ 2. Step Pendaftaran di Landing Page — **SUDAH DIPERBAIKI**
- **Sebelumnya di laporan**: Hanya menyebutkan alur umum tanpa 8-step tracker
- **Di sistem** (`dashboard-camaba.html`): 8 step progress tracker (Data Diri → Gelombang & Formulir → Pembayaran → Ujian → Bayar Cicilan → Daftar Ulang → Status Validasi → Hasil Akhir)
- **Status**: Paragraf baru ditambahkan di section Flowchart yang menjelaskan 8 tahap progress tracker. **SELESAI**

### ✅ 3. Metode Akses Ujian — **SUDAH SESUAI**
- **Di laporan**: F021, F022, F045, PSPEC 3.5, PSPEC 4.4, activity diagram, TC008 — semua sudah menggunakan **"token ujian"** (bukan nomor ujian) + Google Form dalam iframe atau opsi upload offline
- **Di sistem**: Masukkan token → validasi → Google Form iframe atau mode offline
- **Status**: Tidak ada perbedaan. **SUDAH SESUAI**

### ✅ 4. Login Daftar Ulang — **SUDAH SESUAI**
- **Di laporan**: Activity diagram dan sequence diagram sudah menyebutkan "login ke sistem menggunakan akun yang telah terdaftar" kemudian "memilih menu daftar ulang dari dashboard"
- **Di sistem**: Menggunakan auth token yang sama (login reguler)
- **Status**: Tidak ada perbedaan. **SUDAH SESUAI**

### 🔧 5. VA Generation — MASALAH SISTEM
- **Di laporan** (F017): BRIVA VA di-generate otomatis melalui API BRIVA yang terintegrasi
- **Di sistem** (`payment-method.html`): VA number di-generate **client-side** menggunakan timestamp + random digits (format: `8860XXXXXXXXXX`)
- **Di sistem** (`payment-briva.html`): Ada tombol "SIMULASI: Bayar Sukses (DEMO)" — menunjukkan integrasi BRIVA masih dalam mode simulasi
- **Perbedaan**: Integrasi BRIVA belum sepenuhnya terhubung ke API BRIVA asli. **Ini masalah implementasi sistem, bukan laporan**

### 🔧 6. Notifikasi — MASALAH SISTEM
- **Di laporan** (F020): Notifikasi sistem real-time (status kelulusan, pengisian data, aktivasi VA)
- **Di sistem** (`notifications.html`): Menggunakan **data hardcoded** (3 notifikasi sampel), belum terhubung ke API
- **Perbedaan**: Halaman notifikasi belum terintegrasi dengan backend. **Ini masalah implementasi sistem, bukan laporan**

### 🔧 7. Admin Re-enrollment — MASALAH SISTEM
- **Di laporan**: Admin Validasi memvalidasi data daftar ulang yang terhubung ke database
- **Di sistem** (`admin-reenroll.html`): Menggunakan **mock data** (data hardcoded), belum terhubung ke API
- **Catatan**: `dashboard-admin-validasi.html` SUDAH memiliki fitur reenrollment yang terhubung API. Jadi ada 2 halaman admin reenrollment — satu mock, satu real. **Ini masalah implementasi sistem, bukan laporan**

---

## C. FITUR TEST/DEBUG YANG ADA DI SISTEM (TIDAK DI LAPORAN)

File-file ini ada di sistem tapi bukan bagian dari laporan (wajar, tapi perlu diperhatikan):

| File | Tujuan |
|------|--------|
| `debug-auth.html` | Debug autentikasi & JWT |
| `test-token.html` | Test token & auth |
| `test-login.html` | Test login API (port 9091) |
| `test-form-fix.html` | Test form fix (port 9092) |
| `test-student-profile.html` | Test student profile access |
| `test-jwt-authorities.html` | Test JWT authorities/roles |
| `test-api.html` | Test login + form access |
| `test-admission-form.html` | Test admission form API |
| `test-admin-accounts.html` | Test admin accounts API |

> **Catatan**: File test/debug ini normal dalam development, tapi perlu dihapus sebelum deployment production.

---

## D. RINGKASAN STATUS

### Bagian A — Fitur di Sistem tapi Tidak/Kurang di Laporan
| Status | Item | Jumlah |
|--------|------|--------|
| ✅ Sudah sesuai | A1, A3, A4, A5, A6, A9, A10, A12, A13, A18, A21 | **11** |
| ⚠️ Sebagian tercakup (cukup screenshot Bab 4) | A14, A17 | **2** (di Iterasi 1) |
| ❌ Belum ada di laporan | A2, A11 | **2** |
| 🔕 Diabaikan (UI minor) | A7, A8, A15, A16, A19, A20 | **6** |

Note: A7 dan A8 masuk Iterasi 1 (akan ditambahkan), A14 dan A17 juga Iterasi 1.

### Bagian B — Perbedaan Alur
| Status | Item | Jumlah |
|--------|------|--------|
| ✅ Sudah diperbaiki/sesuai | B1, B2, B3, B4 | **4** |
| 🔧 Masalah sistem (bukan laporan) | B5, B6, B7 | **3** |

### Prioritas Penulisan untuk Chapter 4 (Implementasi)
Yang masih perlu ditambahkan ke laporan:
1. **A2 + A11** — Upload pembayaran manual + verifikasi admin (fitur pembayaran alternatif)
2. **A7, A8, A14, A17** — Iterasi 1 (system links, kontak, export, CS chat)
