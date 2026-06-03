# CATATAN PEMBARUAN LAPORAN (chapter-3.tex)

Dokumen ini mencatat semua perubahan yang dilakukan pada laporan tugas akhir (chapter-3.tex) agar sesuai dengan sistem yang sudah diimplementasikan.

---

## A. PEMBARUAN ROUND 1 — Penghapusan & Perubahan Fitur

| No | Kode | Perubahan | Keterangan |
|----|------|-----------|------------|
| 1 | F001 | **DIHAPUS** — Registrasi Akun Calon Mahasiswa | Sistem tidak punya registrasi terpisah, camaba langsung login |
| 2 | F006 | **DIHAPUS** — Pencarian Data Pendaftar | Tidak ada fitur search khusus di sistem |
| 3 | F014 | **DIHAPUS** — Grafik Statistik Pendaftaran | Tidak ada grafik/chart di sistem |
| 4 | F026 | **DIHAPUS** — Laporan Rekapitulasi Pendaftaran | Tidak ada fitur cetak laporan rekapitulasi |
| 5 | NF03 | **DIHAPUS** — Non-Fungsional Skalabilitas | Tidak relevan dengan sistem yang dibangun |
| 6 | — | **DIHAPUS** — Referensi Login Terpisah Daftar Ulang | Sistem hanya punya 1 login, tidak ada login terpisah untuk daftar ulang |
| 7 | F025 | **DIUBAH** — "Auto-Generate Nomor Registrasi" → "Konfirmasi Gmail" | Sistem menggunakan konfirmasi via Gmail, bukan auto-generate nomor |

---

## B. PEMBARUAN ROUND 2 — Penyesuaian 4 Alur Utama

### 1. Alur Pendaftaran & Pembelian Formulir

| No | Bagian yang Diubah | Sebelum (Laporan Lama) | Sesudah (Sesuai Sistem) |
|----|---------------------|------------------------|-------------------------|
| 1 | Activity Diagram teks | Pilih Gelombang → Bayar BRIVA → Isi Formulir | Pilih Gelombang → Pilih Formulir → Isi Formulir → Bayar |
| 2 | Sequence Diagram teks | Camaba bayar → sistem validasi → buka form | Camaba pilih formula → isi form → lakukan pembayaran |
| 3 | Flowchart teks | Proses pembayaran → isi data | Pilih jenis seleksi → isi formulir → pembayaran |
| 4 | PSPEC 1.5 | Terima pembayaran → buka akses form | Tampilkan pilihan formulir → simpan data → proses bayar |
| 5 | F043 (Fungsional) | Pembelian formulir via BRIVA VA | Pembelian formulir pendaftaran online |
| 6 | UI Pembelian Formulir deskripsi | Mockup pembayaran BRIVA VA | Mockup pemilihan formulir dan pengisian data |

### 2. Alur Akses Ujian

| No | Bagian yang Diubah | Sebelum (Laporan Lama) | Sesudah (Sesuai Sistem) |
|----|---------------------|------------------------|-------------------------|
| 1 | Activity Diagram teks | Terima nomor ujian → redirect Google Form prefilled | Login → dapat token ujian → akses ujian via iframe/offline |
| 2 | F007 (Fungsional) | Generate nomor ujian untuk GForm | Generate token ujian untuk akses ujian |
| 3 | F021 (Fungsional) | Redirect ke Google Form dengan data prefilled | Akses ujian online via Google Form iframe |
| 4 | F022 (Fungsional) | Input hasil ujian dari Google Form | Submit hasil ujian oleh mahasiswa |
| 5 | F045 (Fungsional) | Pengisian ujian via Google Form redirect | Pelaksanaan ujian online/offline via token |
| 6 | PSPEC 3.5 | Generate nomor ujian → redirect GForm | Generate token → tampilkan akses ujian |
| 7 | PSPEC 4.2 | Ambil data dari Google Form | Terima data ujian dari mahasiswa |
| 8 | PSPEC 4.3 | Validasi data Google Form | Validasi hasil ujian mahasiswa |
| 9 | PSPEC 4.4 | Sinkronisasi nilai dari GForm | Proses Penilaian Ujian |
| 10 | PSPEC 4.6 | Ambil nilai dari Google Spreadsheet | Proses Pengolahan Nilai Ujian |
| 11 | Diagram Konteks | Entitas Google Form dengan aliran data | Google Form sebagai media ujian (iframe) |
| 12 | Sequence Diagram teks | Admin input nilai dari GForm → sistem simpan | Mahasiswa submit → sistem simpan → admin review |
| 13 | Blackbox TC008 | Klik link Google Form → redirect | Klik akses ujian → tampil halaman ujian dengan token |

### 3. Alur Daftar Ulang

| No | Bagian yang Diubah | Sebelum (Laporan Lama) | Sesudah (Sesuai Sistem) |
|----|---------------------|------------------------|-------------------------|
| 1 | Activity Diagram teks | Login halaman terpisah → isi 1 form → submit | Login reguler → dashboard → pilih menu daftar ulang → isi dokumen → submit |
| 2 | Sequence Diagram teks | Camaba login terpisah → form daftar ulang | Camaba login → akses dashboard → isi dokumen daftar ulang |
| 3 | Flowchart teks | Login khusus daftar ulang → pengisian form | Login reguler → dashboard → isi dokumen → submit |
| 4 | PSPEC 5.1 | Login terpisah daftar ulang | Akses Halaman Daftar Ulang (via dashboard) |
| 5 | PSPEC 5.2 | Isi form daftar ulang (1 form) | Pengisian Dokumen Daftar Ulang |
| 6 | UI Login Daftar Ulang deskripsi | Halaman login terpisah untuk daftar ulang | Menggunakan login reguler yang sama |

### 4. Alur Penentuan Kelulusan

| No | Bagian yang Diubah | Sebelum (Laporan Lama) | Sesudah (Sesuai Sistem) |
|----|---------------------|------------------------|-------------------------|
| 1 | Activity Diagram teks | Admin input nilai → sistem evaluasi otomatis → kirim email | Mahasiswa submit → admin verifikasi → assign nomor registrasi manual |
| 2 | Sequence Diagram teks | Sistem evaluate otomatis → generate hasil | Admin verifikasi → tentukan kelulusan manual → assign nomor |
| 3 | Flowchart teks | Proses otomatis penentuan kelulusan | Admin review → verifikasi manual → assign status |
| 4 | Use Case "Menentukan Kelulusan" | Sistem otomatis mengevaluasi | Admin verifikasi dan menentukan manual |
| 5 | IPO Table | Input nilai → proses otomatis → output kelulusan | Input submission → verifikasi admin → output status + nomor registrasi |
| 6 | PSPEC 4.7 | Evaluasi otomatis kelulusan | Verifikasi Kelulusan Mahasiswa |
| 7 | PSPEC 4.9 | Generate laporan kelulusan otomatis | Penetapan Nomor Registrasi |

---

## C. FOTO/GAMBAR YANG PERLU DIPERBARUI (Dibuat Ulang)

Gambar-gambar berikut masih menampilkan alur LAMA dan harus dibuat ulang agar sesuai dengan teks laporan yang sudah diperbarui.

### Terdampak Alur Pendaftaran

| No | Nama File | Alasan Perlu Diperbarui |
|----|-----------|------------------------|
| 1 | `activity-pembayaran-formulir.png` | Activity diagram masih menunjukkan alur "bayar dulu → isi form", harus diubah ke "pilih formula → isi form → bayar" |
| 2 | `sequence-pendaftaran-ujian.png` | Sequence diagram masih menunjukkan alur pembayaran BRIVA dulu |
| 3 | `flowchart-registrasi-ujian.png` | Flowchart masih menunjukkan alur pembayaran sebelum isi data |
| 4 | `ui-pembelian-formulir.png` | UI mockup masih menunjukkan tampilan pembayaran BRIVA VA |

### Terdampak Alur Akses Ujian

| No | Nama File | Alasan Perlu Diperbarui |
|----|-----------|------------------------|
| 5 | `activity-proses-ujian.png` | Activity diagram masih menunjukkan alur nomor ujian + redirect GForm + evaluasi otomatis kelulusan |
| 6 | `activity-formulir-kartu-ujian.png` | Activity diagram masih menunjukkan alur kartu ujian dengan nomor ujian (bukan token) |
| 7 | `diagram-konteks.png` | Masih menunjukkan Google Form sebagai entitas external dengan aliran data lama |
| 8 | `dfd-level2-proses4-6.png` | DFD Level 2 masih menunjukkan "Ambil Nilai dari Google Spreadsheet" |

### Terdampak Alur Daftar Ulang

| No | Nama File | Alasan Perlu Diperbarui |
|----|-----------|------------------------|
| 9 | `activity-daftar-ulang.png` | Activity diagram masih menunjukkan login terpisah |
| 10 | `sequence-daftar-ulang.png` | Sequence diagram masih menunjukkan login terpisah + isi 1 form |
| 11 | `flowchart-daftar-ulang.png` | Flowchart masih menunjukkan login khusus daftar ulang |

### Terdampak Alur Penentuan Kelulusan

| No | Nama File | Alasan Perlu Diperbarui |
|----|-----------|------------------------|
| 12 | `sequence-validasi.png` | Sequence diagram masih menunjukkan evaluasi otomatis kelulusan |
| 13 | `flowchart-admin-validasi.png` | Flowchart masih menunjukkan proses otomatis penentuan kelulusan |

### Mungkin Terdampak (Perlu Dicek Manual)

| No | Nama File | Alasan Perlu Dicek |
|----|-----------|-------------------|
| 14 | `use-case-diagram.png` | Use case "Menentukan Kelulusan" diubah dari otomatis ke manual |
| 15 | `dfd-level-0.png` | Mungkin masih referensi Google Form / alur lama |
| 16 | `dfd-level1-proses4.png` | DFD Level 1 Proses Ujian mungkin masih referensi alur lama |
| 17 | `dfd-level1-proses5.png` | DFD Level 1 Proses Daftar Ulang mungkin masih referensi login terpisah |

---

## D. FOTO YANG BISA DIHAPUS

| No | Nama File | Alasan Bisa Dihapus |
|----|-----------|---------------------|
| 1 | `ui-login-daftar-ulang.png` | Halaman login terpisah daftar ulang sudah tidak ada — sistem menggunakan login reguler. **Namun**, file ini masih di-reference di chapter-3.tex (line ~1767). Jika ingin dihapus, hapus juga referensi `\includegraphics` dan `\caption` di LaTeX-nya terlebih dahulu. |

> **Catatan**: Selain `ui-login-daftar-ulang.png`, tidak ada gambar lain yang perlu dihapus total. Gambar lainnya perlu **dibuat ulang/diperbarui** agar sesuai alur baru, bukan dihapus.

---

## E. RINGKASAN JUMLAH PERUBAHAN

| Kategori | Jumlah |
|----------|--------|
| Fitur dihapus dari laporan | 5 (F001, F006, F014, F026, NF03) |
| Fitur diubah deskripsi | 2 (F025, Login Terpisah) |
| Alur utama disesuaikan | 4 alur |
| Total edit teks di chapter-3.tex | ~40+ penggantian teks |
| Gambar perlu diperbarui | 13 gambar (pasti) + 4 gambar (perlu dicek) |
| Gambar bisa dihapus | 1 gambar (ui-login-daftar-ulang.png) |

---

## F. PEMBARUAN ROUND 3 — Penghapusan F025/F048 & Implementasi F009/F013/F031

### 1. Penghapusan dari Laporan (chapter-3.tex)

| No | Kode | Perubahan |
|----|------|-----------|
| 1 | F025 | **DIHAPUS** dari tabel functional requirements — tidak relevan dengan sistem |
| 2 | F048 | **DIHAPUS** dari tabel functional requirements — tidak relevan dengan sistem |
| 3 | — | Karakteristik Camaba diperbarui: hapus referensi "ekspor hasil ujian" |

### 2. Implementasi Fitur Baru di Sistem

#### F009: Penjadwalan Publikasi Hasil Kelulusan
- **File baru**:
  - `CREATE_PUBLICATION_SCHEDULE_TABLE.sql` — Tabel `publication_schedule`
  - `PublicationSchedule.java` — Entity (OneToOne ke RegistrationPeriod)
  - `PublicationScheduleRepository.java` — Repository
  - `PublicationScheduleController.java` — CRUD + publish-now endpoint
  - `PublicationScheduleTask.java` — Auto-publish scheduler (cek tiap 60 detik)
- **File dimodifikasi**:
  - `dashboard-admin-pusat.html` — Sidebar "Jadwal Publikasi Hasil" + UI section + JS functions

#### F013: Tampilan Hasil Kelulusan Terjadwal
- **File dimodifikasi**:
  - `PublicApiController.java` — Endpoint `/api/public/publication-status/{periodId}`
  - `dashboard-camaba.html` — `unlockHasilAkhir()` cek jadwal publikasi, tampilkan countdown jika belum waktunya

#### F031: Klasifikasi Data per Fakultas
- **File baru**:
  - `ADD_FAKULTAS_TO_PROGRAM_STUDI.sql` — Kolom `fakultas` + data 9 fakultas UHN
- **File dimodifikasi**:
  - `ProgramStudi.java` — Tambah field `fakultas`
  - `ProgramStudiRepository.java` — Query `findByFakultasAndIsActiveTrueOrderBySortOrder`, `findDistinctFakultasActive`
  - `PublicApiController.java` — Endpoint `/api/public/fakultas` dan `/api/public/program-studi/by-fakultas`

### 3. Ringkasan Round 3

| Kategori | Jumlah |
|----------|--------|
| Fitur dihapus dari laporan | 2 (F025, F048) |
| Fitur baru diimplementasikan di sistem | 3 (F009, F013, F031) |
| File baru dibuat | 6 file |
| File dimodifikasi | 6 file |
