# Iterasi 1 — Modul yang Perlu Ditambahkan ke Laporan

> Modul/fitur yang **sudah diimplementasikan** di sistem tapi **belum/kurang tercakup** di laporan.
> Referensi: sistemberbedalaporan.md

---

## Modul Iterasi 1

| No | Kode | Modul | File Sistem | Status Laporan | Yang Perlu Ditambahkan |
|----|------|-------|-------------|----------------|----------------------|
| 1 | A7 | Manajemen System Links | `dashboard-admin-pusat.html` | ❌ Belum ada | CRUD link sistem eksternal (YouTube, Google Drive, Google Form, External URL). Nama, tipe, URL, deskripsi |
| 2 | A8 | Manajemen Informasi Kontak | `dashboard-admin-pusat.html` | ❌ Belum ada | Edit info kontak (alamat, telepon, email, jam layanan). Footer publik ambil data dinamis dari API |
| 3 | A14 | 4 Halaman Export Terpisah | `export-*.html` (4 file) | ⚠️ Sebagian (F032 hanya sebut CSV/XLSX) | Export formulir, daftar ulang, hasil akhir, hasil akhir per gelombang. Format: CSV, JSON, Print |
| 4 | A17 | Customer Service Chat Widget | `dashboard-camaba.html`, `components/header.html` | ⚠️ Sebagian (F034/F035/F044 sebut pesan) | Floating button CS, modal chat, badge notifikasi pesan belum dibaca, polling 5 detik |

---

## Tambahan Iterasi 1 — Feedback Client

> Fitur tambahan yang diminta oleh **pihak client** untuk ditambahkan ke sistem dan laporan.

| No | Modul | Deskripsi Tambahan |
|----|-------|--------------------|
| 1 | **Login / Registrasi** | **Verifikasi email** — email yang didaftarkan harus diverifikasi terlebih dahulu (misal: klik link verifikasi di email) agar pendaftar tidak asal-asalan memasukkan email. Ditambahkan juga input **nama lengkap** pada form registrasi |
| 2 | **Pendaftaran (Formulir)** | **Autocomplete asal SMA** — nama SMA/SMK/MA bisa dicari dan dipanggil (autocomplete/dropdown search) sehingga pendaftar tidak perlu mengetik manual nama sekolah |
| 3 | **Validasi** | **Validasi kelulusan ujian** — ditambahkan proses validasi apakah calon mahasiswa **lulus ujian seleksi** atau tidak. Status lulus/tidak lulus menjadi bagian dari alur validasi admin |
| 4 | **Cicilan** | **Skema cicilan fleksibel** — cicilan bisa dipilih dengan variasi: Cicilan 1× / Cicilan 2× (1,2) / Cicilan 3× (1,2,3) / Cicilan 4× (1,2,3,4) / Cicilan 5× (1,2,3,4,5) / Cicilan 6× (1,2,3,4,5,6). Masing-masing tahap cicilan memiliki nominal dan status pembayaran sendiri |
| 5 | **Admin — Program Studi** | **Upgrade manajemen program studi** — admin bisa mengatur harga per-cicilan untuk setiap program studi (input harga Cicilan 1, Cicilan 2, Cicilan 3, dst sesuai jumlah cicilan yang tersedia) |
| 6 | **Hasil Akhir** | **Cetak dokumen sementara** — setelah proses validasi daftar ulang selesai, admin validasi  mengirim file yang bisa dicetak/diunduh dan dikirim ke calon mahasiswa baru untuk diproses ke website UHN. Dokumen meliputi: **NPM Sementara** dan **KTM Sementara** |
