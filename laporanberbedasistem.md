# Fitur yang ADA di Laporan tapi TIDAK ADA / BELUM DIBUAT di Sistem

> Perbandingan antara deskripsi di laporan LaTeX `Latex-TA-IF-ITERA-main/` dengan implementasi di folder `tugasakhir/`

---

## A. FITUR LAPORAN YANG BELUM TERIMPLEMENTASI DI SISTEM

> ✅ F009, F013, F025, F048 sudah ditangani:
> - **F009 & F013**: Sudah diimplementasikan di sistem (lihat Section D)
> - **F025 & F048**: Sudah dihapus dari laporan (chapter-3.tex)

*Saat ini tidak ada fitur laporan yang belum terimplementasi di kategori ini.*

---

## B. FITUR LAPORAN YANG HANYA SEBAGIAN TERIMPLEMENTASI

### 1. F005: Mengelola Konten Landing Page
- **Di laporan**: Admin Pusat mengelola konten landing page (jadwal, pengumuman, informasi umum)
- **Di sistem**: Admin bisa mengelola **pengumuman** dan **informasi kontak** dan **system links**, tapi konten landing page utama (hero carousel, section "Tentang", alur pendaftaran, dll.) **hardcoded** di `index.html`
- **Status**: Sebagian terimplementasi
- **Sumber**: Chapter 3 — Functional Requirement F005

### 2. F008: Mengelola Konten Daftar Ulang
- **Di laporan**: Admin mengelola konten/pengumuman daftar ulang
- **Di sistem**: Tidak ada editor konten khusus untuk halaman daftar ulang. Konten di `daftar-ulang.html` bersifat statis
- **Status**: Belum terimplementasi secara spesifik
- **Sumber**: Chapter 3 — Functional Requirement F008

### 3. F017: Integrasi BRIVA API Asli
- **Di laporan**: Generate dan verifikasi pembayaran BRIVA via API asli (auto VA creation per mahasiswa)
- **Di sistem**:
  - `payment-method.html`: VA di-generate client-side (`8860` + timestamp + random)
  - `payment-briva.html`: Ada tombol "SIMULASI: Bayar Sukses (DEMO)"
  - Belum terhubung ke API BRIVA asli
- **Status**: Implementasi simulasi/demo, belum integrasi asli
- **Sumber**: Chapter 3 — Functional Requirement F017

### 4. F020: Notifikasi Sistem Real-time
- **Di laporan**: Notifikasi otomatis untuk status kelulusan, pengisian data, aktivasi VA
- **Di sistem** (`notifications.html`): Halaman notifikasi ada tapi menggunakan **data hardcoded** (3 notifikasi sampel). Belum terhubung ke API backend
- **Status**: UI ada, backend belum terhubung
- **Sumber**: Chapter 3 — Functional Requirement F020

### 5. F032: Export Data (Format)
- **Di laporan**: Export data dalam format CSV atau XLSX
- **Di sistem**: Export mendukung **CSV dan JSON** (bukan XLSX). Plus fitur Print
- **Status**: Terimplementasi dengan format berbeda (JSON menggantikan XLSX)
- **Sumber**: Chapter 3 — Functional Requirement F032

### 6. F031: Klasifikasi Data per Fakultas dan Program Studi ✅ Sudah Diimplementasikan
- **Di laporan**: Data diklasifikasikan berdasarkan fakultas dan program studi
- **Di sistem**: ✅ Kolom `fakultas` ditambahkan ke tabel `program_studi` + API endpoint `/api/public/fakultas` dan `/api/public/program-studi/by-fakultas`
- **Status**: ✅ Terimplementasi (lihat Section D)
- **Sumber**: Chapter 3 — Functional Requirement F031

---

## C. NON-FUNCTIONAL REQUIREMENTS YANG BELUM TERPENUHI

### 1. NF10: Real-time Data Update
- **Di laporan**: Data di-refresh secara live saat terjadi perubahan
- **Di sistem**: Beberapa halaman menggunakan polling (setiap 5-30 detik), bukan real-time update (WebSocket). `notifications.html` belum terhubung API
- **Status**: Sebagian (polling, bukan real-time)
- **Sumber**: Chapter 3 — Non-Functional Requirement NF10

---

## D. ALUR YANG SUDAH DISESUAIKAN DI LAPORAN

> Alur-alur berikut sebelumnya berbeda antara laporan dan sistem. **Laporan telah diperbarui** agar sesuai dengan implementasi sistem.

### 1. Alur Pendaftaran (Flow 2) ✅ Disesuaikan
- **Sebelum**: Pilih Gelombang → Generate BRIVA VA → Bayar → Baru isi formulir
- **Sekarang (laporan = sistem)**: Pilih Gelombang → Pilih Formula → Isi Formulir → Bayar

### 2. Alur Akses Ujian (Flow 4) ✅ Disesuaikan
- **Sebelum**: Masukkan nomor ujian → validasi nomor → redirect ke Google Form dengan prefilled nomor ujian
- **Sekarang (laporan = sistem)**: Masukkan token (di-generate admin) → validasi token → Google Form iframe ATAU upload bukti offline

### 3. Alur Daftar Ulang (Flow 5) ✅ Disesuaikan
- **Sebelum**: Login terpisah → isi form daftar ulang → submit
- **Sekarang (laporan = sistem)**: Login reguler → akses dari dashboard → isi dokumen → submit

### 4. Penentuan Kelulusan ✅ Disesuaikan
- **Sebelum**: Admin input nilai dari GForm → sistem evaluasi otomatis → generate status → kirim email
- **Sekarang (laporan = sistem)**: Mahasiswa submit hasil → admin verifikasi dan tentukan kelulusan → assign nomor registrasi manual

### 5. F009: Penjadwalan Publikasi Hasil Kelulusan ✅ Diimplementasikan
- **Sebelum**: Tidak ada fitur scheduling di sistem
- **Sekarang**: `PublicationScheduleController` + `PublicationSchedule` entity + UI di dashboard admin pusat (sidebar "Jadwal Publikasi Hasil") + auto-publish scheduler (`PublicationScheduleTask`)
- **File**: `PublicationSchedule.java`, `PublicationScheduleRepository.java`, `PublicationScheduleController.java`, `PublicationScheduleTask.java`, `CREATE_PUBLICATION_SCHEDULE_TABLE.sql`

### 6. F013: Tampilan Hasil Kelulusan Terjadwal ✅ Diimplementasikan
- **Sebelum**: Tidak ada mekanisme time-gating
- **Sekarang**: `dashboard-camaba.html` → `unlockHasilAkhir()` cek `/api/public/publication-status/{periodId}`. Jika belum waktunya, tampilkan tanggal pengumuman & tombol disabled
- **File**: `dashboard-camaba.html`, `PublicApiController.java` (endpoint `/api/public/publication-status/{periodId}`)

### 7. F031: Klasifikasi Data per Fakultas ✅ Diimplementasikan
- **Sebelum**: Hanya filter per wave type, tidak ada per fakultas
- **Sekarang**: Kolom `fakultas` di tabel `program_studi` + API `/api/public/fakultas` dan `/api/public/program-studi/by-fakultas`
- **File**: `ADD_FAKULTAS_TO_PROGRAM_STUDI.sql`, `ProgramStudi.java`, `ProgramStudiRepository.java`, `PublicApiController.java`

### 8. F025 & F048: Dihapus dari Laporan ✅
- **F025** (Auto-Generate Nomor Pendaftaran & Konfirmasi Gmail) — Dihapus dari tabel functional requirements di chapter-3.tex
- **F048** (Halaman Cetak Hasil Ujian) — Dihapus dari tabel functional requirements di chapter-3.tex
- **Alasan**: Fitur-fitur ini tidak relevan dengan implementasi aktual sistem

---

## E. USE CASE LAPORAN YANG BELUM TERLIHAT DI SISTEM

| Use Case (Laporan) | Status Implementasi | Keterangan |
|---------------------|---------------------|------------|
| Registrasi | ✅ Terimplementasi | `register.html` |
| Login | ✅ Terimplementasi | `login.html` — multi-role |
| Informasi Pendaftaran & Ujian | ✅ Terimplementasi | `index.html` — landing page |
| Mengelola Informasi | ⚠️ Sebagian | Pengumuman ada, tapi konten landing page hardcoded |
| Memilih Periode Pendaftaran | ✅ Terimplementasi | `gelombang-selection.html` |
| Memilih Jenis Formulir | ✅ Terimplementasi | `formula-selection.html` |
| Mengelola Jenis Formulir | ✅ Terimplementasi | `dashboard-admin-pusat.html` — Jenis Seleksi CRUD |
| Membeli Formulir & VA | ⚠️ Sebagian | Ada, tapi VA belum terintegrasi BRIVA API asli |
| Membuat VA Otomatis | ⚠️ Simulasi | VA di-generate client-side, bukan API BRIVA |
| Membuat VA Manual | ⚠️ Sebagian | Admin bisa generate di `dashboard-admin-validasi.html` |
| Mengisi Formulir Ujian | ✅ Terimplementasi | `form-pendaftaran.html` |
| Mengisi Data Daftar Ulang | ✅ Terimplementasi | `daftar-ulang.html` |
| Melakukan Validasi | ✅ Terimplementasi | `dashboard-admin-validasi.html` |
| Mengirim Notifikasi ke Email | ⚠️ Sebagian | Ada send reminder, tapi auto-email belum terlihat |
| Melaksanakan Ujian | ✅ Terimplementasi | `ujian.html` — online + offline |
| Menentukan Kelulusan | ✅ Disesuaikan | Laporan diperbarui: admin verifikasi + assign manual |
| Penjadwalan Publikasi Hasil | ✅ Terimplementasi | `PublicationScheduleController` + UI admin + auto-publish |
| Tampilan Hasil Terjadwal | ✅ Terimplementasi | `unlockHasilAkhir()` cek publication schedule |
| Klasifikasi per Fakultas | ✅ Terimplementasi | Kolom `fakultas` + API endpoint |

---

## F. ENTITAS DATABASE DI LAPORAN YANG TIDAK TERLIHAT DI FRONTEND

> Catatan: Beberapa entitas mungkin ada di backend tapi tidak terekspos di frontend

| Entitas (Laporan) | Terlihat di Frontend? | Keterangan |
|--------------------|----------------------|------------|
| User | ✅ Ya | Login, register, profile, admin accounts |
| Formulir | ✅ Ya | form-pendaftaran, admin-validasi |
| Periode | ✅ Ya | gelombang-selection, admin periods |
| ProgramStudi | ✅ Ya | formula-selection, admin program studi |
| Pembayaran | ✅ Ya | payment-briva, payment-cicilan |
| Ujian | ✅ Ya | ujian.html |
| DaftarUlang | ✅ Ya | daftar-ulang.html |
| Pesan | ✅ Ya | CS chat modal, admin messages |
| KonfigurasiSistem | ✅ Ya | Admin settings, contact info |
| Kartu Ujian & QR | ⚠️ Sebagian | Kartu ada di HTML tapi QR placeholder, bukan generated |
| Notifikasi & Email Log | ⚠️ Sebagian | UI ada tapi hardcoded, tidak terhubung backend |
| Data Validasi Camaba | ✅ Ya | dashboard-admin-validasi |
| PublicationSchedule | ✅ Ya | Admin pusat — Jadwal Publikasi Hasil section |
| ProgramStudi.fakultas | ✅ Ya | Kolom baru, data di-populate via SQL migration |
