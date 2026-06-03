# Daftar Foto Missing — figure/bab4/

Total: **36 foto** yang harus diambil.
Semua foto harus diletakkan di folder: `Latex-TA-IF-ITERA-main/figure/bab4/`

---

## 📁 Database (5 foto)

Screenshot dari **phpMyAdmin** atau **DBeaver** dengan database `pmb_uhn`.

| No | Nama File | Screenshot Apa |
|----|-----------|----------------|
| 1 | `db-tables.png` | Daftar semua tabel di database `pmb_uhn` — tampilkan panel kiri phpMyAdmin atau tab "Tables" DBeaver |
| 2 | `db-users.png` | Struktur tabel `users` — jalankan `DESC users;` di phpMyAdmin atau lihat kolom tabel di DBeaver |
| 3 | `db-students.png` | Struktur tabel `students` — jalankan `DESC students;` atau tampilkan kolom tabel |
| 4 | `db-program-studi.png` | Struktur + isi tabel `program_studi` — tampilkan semua 26 baris prodi beserta kolom harga |
| 5 | `db-registration-periods.png` | Struktur tabel `registration_periods` — jalankan `DESC registration_periods;` atau tampilkan kolom |

---

## 👤 Halaman Camaba (14 foto)

Login sebagai **camaba** di `http://localhost:9500` untuk mengambil screenshot ini.

| No | Nama File | Screenshot Apa |
|----|-----------|----------------|
| 6 | `m-login.png` | Halaman login sistem PMB — form email + password, belum diisi |
| 7 | `m-register.png` | Halaman registrasi akun camaba — form nama, email, password |
| 8 | `m-forgot-password.png` | Halaman lupa kata sandi — form input email untuk kirim link reset |
| 9 | `m-gelombang.png` | Halaman pemilihan gelombang dan jenis seleksi — dropdown/list gelombang aktif |
| 10 | `m-payment-method.png` | Halaman pemilihan metode pembayaran — pilihan BRIVA vs transfer manual |
| 11 | `m-briva.png` | Halaman pembayaran BRIVA dan/atau unggah bukti transfer manual — nomor VA atau form upload |
| 12 | `m-formulir.png` | Halaman pengisian formulir pendaftaran — form multi-step (data pribadi, ortu, sekolah, prodi) |
| 13 | `m-revisi.png` | Halaman revisi formulir setelah penolakan — form yang sudah terisi + notifikasi alasan penolakan |
| 14 | `m-profil.png` | Halaman profil mahasiswa — data diri camaba yang bisa diedit |
| 15 | `m-tracker.png` | Pelacak status pendaftaran di dasbor camaba — progress bar/stepper: Bayar → Formulir → Ujian → Daftar Ulang → Hasil |
| 16 | `m-ujian.png` | Halaman ujian seleksi — link ujian online (Google Form) atau form upload bukti offline |
| 17 | `m-cicilan.png` | Halaman pengajuan cicilan — form pilih jumlah tahap cicilan (1–6×) |
| 18 | `m-daftar-ulang.png` | Halaman daftar ulang dan upload dokumen — form upload foto, KTP, ijazah, dll. |
| 19 | `m-hasil-akhir.png` | Modal hasil akhir di dasbor camaba — nomor registrasi, BRIVA, tombol unduh NPM/KTM sementara |

---

## 🛡️ Halaman Admin (8 foto)

Login sebagai **Admin Pusat** atau **Admin Validasi** di `http://localhost:9500` untuk screenshot ini.

| No | Nama File | Screenshot Apa |
|----|-----------|----------------|
| 20 | `m-admin-gelombang.png` | Halaman manajemen gelombang pendaftaran di dasbor Admin Pusat — tabel list gelombang + tombol tambah/edit |
| 21 | `m-admin-jenis-seleksi.png` | Halaman manajemen jenis seleksi dan program studi — tabel prodi + form edit |
| 22 | `m-admin-validasi.png` | Panel validasi formulir di dasbor Admin Validasi — tabel formulir masuk + tombol approve/reject/revisi |
| 23 | `m-admin-ujian.png` | Panel manajemen ujian dan konfigurasi link ujian — tabel peserta ujian + form input URL ujian |
| 24 | `m-admin-daftar-ulang.png` | Panel validasi daftar ulang di dasbor Admin Validasi — tabel dokumen yang diunggah camaba + tombol validasi |
| 25 | `m-admin-cicilan.png` | Panel manajemen cicilan di dasbor Admin — tabel pengajuan cicilan pending + tombol approve/reject |
| 26 | `m-admin-pengumuman.png` | Halaman manajemen pengumuman di dasbor Admin Pusat — tabel pengumuman + form tambah pengumuman |
| 27 | `m-admin-users.png` | Halaman manajemen pengguna di dasbor Admin Pusat — tabel semua user + tombol ubah role/nonaktifkan |

---

## 🔄 Iterasi 1 — After (9 foto)

Foto tampilan **setelah** perbaikan tiap fitur di Iterasi 1.

| No | Nama File | Screenshot Apa |
|----|-----------|----------------|
| 28 | `iter1-verif-after.png` | Notifikasi/tampilan setelah registrasi **setelah Iterasi 1** — muncul pesan "cek email untuk verifikasi sebelum login" |
| 29 | `iter1-autocomplete-after.png` | Formulir pendaftaran **setelah Iterasi 1** — kolom "Asal Sekolah" dengan dropdown autocomplete saat mengetik nama sekolah |
| 30 | `iter1-lulusujian-after.png` | Halaman manajemen ujian **setelah Iterasi 1** — tabel peserta ujian dengan tombol validasi kelulusan aktif |
| 31 | `iter1-cicilan-after.png` | Halaman pengajuan cicilan **setelah Iterasi 1** — form dengan pilihan jumlah tahap (1×/2×/3×/.../6×) |
| 32 | `iter1-hargacicilan-after.png` | Halaman edit program studi **setelah Iterasi 1** — form ada kolom Cicilan 1 s.d. Cicilan 6 yang bisa diisi sendiri |
| 33 | `iter1-dokumen-after.png` | Modal hasil akhir **setelah Iterasi 1** — ada tombol "Unduh NPM Sementara" dan "Unduh KTM Sementara" |
| 34 | `iter1-system-links.png` | Halaman pengaturan admin **setelah Iterasi 1** yang menampilkan **System Links DAN Informasi Kontak** dalam satu halaman — tampilkan kedua bagian sekaligus (tabel link + form kontak) |
| 36 | `iter1-export.png` | Halaman ekspor data formulir pendaftaran **setelah Iterasi 1** — panel filter + preview tabel + tombol Export CSV/JSON/Cetak |
| 37 | `iter1-chat.png` | Tampilan chat widget di dasbor camaba **setelah Iterasi 1** — floating button chat + panel percakapan terbuka |

---

## Cara Pakai

1. Jalankan app di `http://localhost:9500`
2. Screenshot sesuai deskripsi di atas
3. Simpan file dengan nama **persis** seperti kolom "Nama File"
4. Taruh semua file di folder: `Latex-TA-IF-ITERA-main/figure/bab4/`
5. Compile LaTeX — semua gambar akan langsung muncul
