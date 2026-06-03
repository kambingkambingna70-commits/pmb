**LEMBAR PENGUJIAN SYSTEM USABILITY SCALE (SUS)**

**Sistem Terintegrasi Penerimaan Mahasiswa Baru (PMB)**

Universitas HKBP Nommensen

Peneliti: Mychael Daniel N | NIM: 122140104 | Program Studi: Teknik Informatika | Institut Teknologi Sumatera

# **A. PENDAHULUAN DAN KONSEP SUS**

System Usability Scale (SUS) adalah instrumen pengukuran tingkat kemudahan penggunaan (usability) yang dikembangkan oleh John Brooke pada tahun 1986. SUS merupakan metode pengujian non-fungsional yang bertujuan untuk mengukur sejauh mana sebuah sistem mudah digunakan dan memuaskan dari perspektif pengguna akhir.

Dalam penelitian ini, SUS digunakan untuk mengukur tingkat usability sistem PMB yang dikembangkan untuk Universitas HKBP Nommensen, khususnya dari sisi kemudahan navigasi, integrasi fitur, dan kenyamanan penggunaan oleh calon mahasiswa baru (camaba) dan admin.

## **A.1 Mengapa SUS Dipilih?**

SUS dipilih sebagai metode pengujian non-fungsional karena beberapa alasan:

- Cepat dan efisien: Hanya terdiri dari 10 pernyataan yang dapat diselesaikan dalam waktu 5-10 menit.
- Terstandarisasi secara internasional: SUS telah divalidasi dalam lebih dari 2.500 studi dan dianggap sebagai standar industri untuk pengukuran usability.
- Technology-agnostic: Dapat diterapkan pada sistem web, aplikasi mobile, atau perangkat lunak apapun.
- Menghasilkan data kuantitatif: Skor akhir berbentuk angka 0-100 yang mudah diinterpretasikan dan dibandingkan.
- Mengidentifikasi masalah usability sejak awal pengembangan (sesuai dengan pendekatan Evolutionary Prototyping yang digunakan).

## **A.2 Komponen Pernyataan SUS**

SUS terdiri dari 10 pernyataan yang terbagi menjadi dua kelompok:

| **Kelompok**       | **Nomor**      | **Karakteristik**                                                                                            |
| ------------------ | -------------- | ------------------------------------------------------------------------------------------------------------ |
| Pernyataan Positif | 1, 3, 5, 7, 9  | Pernyataan yang mengindikasikan pengalaman positif. Semakin tinggi skor jawaban, semakin baik usability-nya. |
| Pernyataan Negatif | 2, 4, 6, 8, 10 | Pernyataan yang mengindikasikan pengalaman negatif. Skor jawaban perlu dibalik agar konsisten arahnya.       |

## **A.3 Skala Likert yang Digunakan**

| **Skor** | **Keterangan**            | **Deskripsi**                                             |
| -------- | ------------------------- | --------------------------------------------------------- |
| 1        | Sangat Tidak Setuju (STS) | Responden sangat tidak setuju dengan pernyataan tersebut. |
| 2        | Tidak Setuju (TS)         | Responden cenderung tidak setuju dengan pernyataan.       |
| 3        | Netral (N)                | Responden tidak memiliki pendapat yang kuat (ragu-ragu).  |
| 4        | Setuju (S)                | Responden cenderung setuju dengan pernyataan.             |
| 5        | Sangat Setuju (SS)        | Responden sangat setuju dengan pernyataan tersebut.       |

## **A.4 Rumus Perhitungan Skor SUS**

Setiap responden menghasilkan satu nilai skor SUS yang dihitung melalui langkah-langkah berikut:

- Untuk setiap pernyataan POSITIF (No. 1, 3, 5, 7, 9): Skor Item = Nilai Jawaban Responden - 1
- Untuk setiap pernyataan NEGATIF (No. 2, 4, 6, 8, 10): Skor Item = 5 - Nilai Jawaban Responden
- Jumlahkan seluruh 10 Skor Item (Total Skor berkisar antara 0-40).
- Kalikan Total Skor dengan 2.5 untuk mendapatkan Skor SUS (berkisar antara 0-100).

**Skor SUS = (Jumlah Skor Seluruh Item) × 2.5**

- Rata-rata Skor SUS semua responden = Jumlah Seluruh Skor SUS / Jumlah Responden

## **A.5 Interpretasi Skor SUS**

| **Rentang Skor** | **Grade** | **Adjective**   | **Interpretasi**                                                |
| ---------------- | --------- | --------------- | --------------------------------------------------------------- |
| 90.0 - 100.0     | A+        | Best Imaginable | Sistem sangat luar biasa mudah digunakan dan memuaskan.         |
| 85.0 - 89.9      | A         | Excellent       | Sistem sangat baik dan sangat mudah digunakan.                  |
| 80.0 - 84.9      | A-        | Excellent       | Sistem sangat baik, hampir tidak ada masalah usability.         |
| 70.0 - 79.9      | B+        | Good            | Sistem baik dan mudah digunakan oleh sebagian besar pengguna.   |
| 68.0 - 69.9      | B         | Good            | Di atas rata-rata, usability diterima dengan baik.              |
| 51.0 - 67.9      | C         | OK / Fair       | Cukup dapat diterima, namun ada perbaikan yang perlu dilakukan. |
| 25.0 - 50.9      | D         | Poor            | Di bawah rata-rata, perlu perbaikan signifikan pada antarmuka.  |
| < 25.0           | F         | Awful           | Sistem sangat sulit digunakan, perlu redesign menyeluruh.       |

Catatan: Skor SUS di atas 68 secara umum dianggap 'baik' (above average). Threshold minimal yang umumnya dapat diterima adalah 68.

## **A.6 Cakupan Aspek yang Diukur**

SUS untuk sistem PMB ini dirancang untuk mengukur beberapa dimensi usability:

- Learnability (Kemudahan Belajar): Seberapa mudah pengguna baru mempelajari cara menggunakan sistem (Q4, Q7, Q10).
- Efficiency (Efisiensi): Seberapa cepat pengguna dapat menyelesaikan tugasnya (Q1, Q5).
- Memorability (Kemudahan Diingat): Apakah sistem mudah diingat setelah beberapa saat tidak digunakan (Q3).
- Errors (Kesalahan): Seberapa sering terjadi kesalahan dan seberapa mudah pulih dari kesalahan (Q6).
- Satisfaction (Kepuasan): Seberapa puas pengguna terhadap pengalaman menggunakan sistem (Q2, Q8, Q9).

# **B. PANDUAN PENGISIAN KUESIONER**

## **B.1 Instruksi untuk Responden**

Bapak/Ibu/Saudara yang terhormat,

Anda diminta untuk mengisi kuesioner System Usability Scale (SUS) berikut ini setelah mencoba menggunakan sistem informasi Penerimaan Mahasiswa Baru (PMB) Universitas HKBP Nommensen. Kuesioner ini merupakan bagian dari penelitian Tugas Akhir untuk mengukur tingkat kemudahan penggunaan sistem.

Petunjuk Pengisian:

- Jawablah seluruh pernyataan berdasarkan pengalaman nyata Anda menggunakan sistem PMB. Tidak ada jawaban benar atau salah.
- Berikan tanda silang (X) atau centang (✓) pada kolom yang sesuai dengan tingkat kesetujuan Anda.
- Jika Anda merasa ragu, berikan jawaban berdasarkan kesan pertama yang paling kuat.
- Kuesioner ini bersifat rahasia dan hanya digunakan untuk kepentingan penelitian akademis.
- Pastikan semua 10 pernyataan telah dijawab sebelum menyerahkan kuesioner.

## **B.2 Target Responden**

Kuesioner SUS ini ditujukan kepada dua kelompok pengguna sistem PMB:

| **Kelompok**                  | **Jumlah Target** | **Keterangan**                                                                                     |
| ----------------------------- | ----------------- | -------------------------------------------------------------------------------------------------- |
| Calon Mahasiswa Baru (Camaba) | Minimal 15 orang  | Pengguna yang telah mencoba mendaftar melalui sistem PMB, minimal sampai tahap pengisian formulir. |
| Admin (Pusat / Validasi)      | Minimal 5 orang   | Pengguna admin yang telah mencoba menggunakan panel administrasi sistem PMB.                       |

## **B.3 Skenario Penggunaan Sebelum Pengisian**

Sebelum mengisi kuesioner, responden diminta untuk mencoba melakukan setidaknya beberapa aktivitas berikut di sistem PMB:

Untuk Camaba:

- Melakukan registrasi akun baru dan verifikasi email.
- Login ke sistem menggunakan akun yang telah dibuat.
- Mengakses halaman dashboard dan menjelajahi menu-menu yang tersedia.
- Memilih gelombang pendaftaran dan mencoba membeli formulir.
- Mengisi beberapa bagian formulir pendaftaran (data pribadi, data pendidikan).
- Mencoba mengakses atau melihat informasi kartu ujian.

Untuk Admin:

- Login ke panel administrasi sesuai role (Admin Pusat atau Admin Validasi).
- Menjelajahi menu-menu utama pada dashboard admin.
- Mencoba mengakses data formulir camaba yang masuk.
- Mencoba memvalidasi atau menolak data formulir camaba.

## **B.4 Waktu dan Tempat Pengujian**

| **Tanggal Pengujian**        |     |
| ---------------------------- | --- |
| **Lokasi Pengujian**         |     |
| **Durasi Penggunaan Sistem** |     |
| **Peneliti / Fasilitator**   |     |

# **C. LEMBAR KUESIONER SUS (PER RESPONDEN)**

Lembar kuesioner berikut diisi oleh satu orang responden. Salin dan gunakan lembar ini untuk setiap responden secara terpisah.

## **C.1 Identitas Responden**

| **Nama Responden**                      |                                                             |
| --------------------------------------- | ----------------------------------------------------------- |
| **Usia**                                |                                                             |
| **Jenis Kelamin**                       | L / P (lingkari salah satu)                                 |
| **Peran / Posisi**                      | Camaba / Admin Pusat / Admin Validasi (lingkari salah satu) |
| **Pengalaman Menggunakan Sistem**       | Pertama kali / Sudah pernah (lingkari salah satu)           |
| **Durasi Penggunaan Sistem (hari ini)** |                                                             |

## **C.2 Pernyataan Kuesioner SUS**

Berikan penilaian Anda untuk setiap pernyataan berikut dengan memberi tanda silang (X) pada kolom yang sesuai.

| **No**                                       | **Jenis** | **Pernyataan**                                                                                                        | **1 (STS)** | **2 (TS)** | **3 (N)** | **4 (S)** | **5 (SS)** | **Skor Item** |
| -------------------------------------------- | --------- | --------------------------------------------------------------------------------------------------------------------- | ----------- | ---------- | --------- | --------- | ---------- | ------------- |
| **1**                                        | Positif   | Saya merasa akan sering menggunakan sistem PMB ini.                                                                   |             |            |           |           |            |               |
| **2**                                        | Negatif   | Saya merasa sistem PMB ini rumit untuk digunakan.                                                                     |             |            |           |           |            |               |
| **3**                                        | Positif   | Saya merasa sistem PMB ini mudah digunakan.                                                                           |             |            |           |           |            |               |
| **4**                                        | Negatif   | Saya memerlukan bantuan dari orang lain atau teknisi untuk dapat menggunakan sistem PMB ini.                          |             |            |           |           |            |               |
| **5**                                        | Positif   | Saya merasa fitur-fitur dalam sistem PMB ini terintegrasi dengan baik (pendaftaran, pembayaran, ujian, daftar ulang). |             |            |           |           |            |               |
| **6**                                        | Negatif   | Saya merasa terdapat inkonsistensi (ketidakselarasan) antara fitur-fitur dalam sistem PMB ini.                        |             |            |           |           |            |               |
| **7**                                        | Positif   | Saya merasa sebagian besar orang akan mudah mempelajari cara menggunakan sistem PMB ini dengan cepat.                 |             |            |           |           |            |               |
| **8**                                        | Negatif   | Saya merasa sistem PMB ini sangat sulit dan tidak nyaman untuk digunakan.                                             |             |            |           |           |            |               |
| **9**                                        | Positif   | Saya merasa percaya diri dan nyaman dalam menggunakan sistem PMB ini.                                                 |             |            |           |           |            |               |
| **10**                                       | Negatif   | Saya perlu mempelajari banyak hal terlebih dahulu sebelum dapat menggunakan sistem PMB ini.                           |             |            |           |           |            |               |
| **Total Skor (Jumlah Skor Item 1 s.d. 10):** |           |                                                                                                                       |             |            |           |           |            |               |
| **Skor SUS = Total Skor × 2.5:**             |           |                                                                                                                       |             |            |           |           |            |               |

## **C.3 Pertanyaan Terbuka (Opsional)**

| **Apa fitur yang paling Anda sukai dari sistem PMB ini?**             |
| --------------------------------------------------------------------- |
|                                                                       |
| **Apa yang menurut Anda perlu diperbaiki atau disederhanakan?**       |
|                                                                       |
| **Apakah ada fitur yang menurut Anda masih membingungkan? Jelaskan.** |
|                                                                       |

## **C.4 Tanda Tangan Responden**

| Nama: \_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_    | Tanda Tangan: \_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_ |
| --------------------------------------------------- | -------------------------------------------------------- |
| Tanggal: \_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_ |                                                          |

# **D. TABEL REKAP HASIL SUS SEMUA RESPONDEN**

Tabel berikut digunakan untuk merekap jawaban dan menghitung skor SUS dari seluruh responden. Isi kolom Q1-Q10 dengan nilai jawaban responden (1-5), bukan skor item.

| **No**                  | **Nama Responden** | **Peran / Posisi** | **Q1** | **Q2** | **Q3** | **Q4** | **Q5** | **Q6** | **Q7** | **Q8** | **Q9** | **Q10** | **Total** | **Skor SUS** |
| ----------------------- | ------------------ | ------------------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------- | --------- | ------------ |
| 1                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 2                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 3                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 4                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 5                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 6                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 7                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 8                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 9                       |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 10                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 11                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 12                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 13                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 14                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 15                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 16                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 17                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 18                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 19                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| 20                      |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |
| **RATA-RATA SKOR SUS:** |                    |                    |        |        |        |        |        |        |        |        |        |         |           |              |

# **E. PERHITUNGAN DAN ANALISIS SKOR SUS**

## **E.1 Tabel Perhitungan Manual Skor SUS per Responden**

Gunakan tabel berikut untuk menghitung skor SUS secara manual. Perhatikan perbedaan rumus untuk pernyataan positif dan negatif.

| **No**                                                      | **Nama** | **Q1 (V-1)** | **Q2 (5-V)** | **Q3 (V-1)** | **Q4 (5-V)** | **Q5 (V-1)** | **Q6 (5-V)** | **Q7 (V-1)** | **Q8 (5-V)** | **Q9 (V-1)** | **Q10 (5-V)** | **Total (0-40)** | **Skor SUS** |
| ----------------------------------------------------------- | -------- | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------ | ------------- | ---------------- | ------------ |
| 1                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 2                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 3                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 4                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 5                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 6                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 7                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 8                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 9                                                           |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 10                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 11                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 12                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 13                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 14                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 15                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 16                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 17                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 18                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 19                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| 20                                                          |          |              |              |              |              |              |              |              |              |              |               |                  |              |
| **RATA-RATA SKOR SUS (Total Skor SUS / Jumlah Responden):** |          |              |              |              |              |              |              |              |              |              |               |                  |              |

## **E.2 Tabel Interpretasi Hasil**

| **Parameter**                    | **Nilai** | **Grade** | **Keterangan** |
| -------------------------------- | --------- | --------- | -------------- |
| Rata-rata Skor SUS               |           |           |                |
| Jumlah Responden                 |           |           |                |
| Skor Tertinggi                   |           |           |                |
| Skor Terendah                    |           |           |                |
| Standar Deviasi                  |           |           |                |
| **Kesimpulan Tingkat Usability** |           |           |                |

## **E.3 Skor Rata-Rata Per Item Pernyataan**

| **No** | **Jenis** | **Pernyataan**                                                                                                        | **Jumlah Skor** | **Rata-rata** | **Bobot** | **Interpretasi** |
| ------ | --------- | --------------------------------------------------------------------------------------------------------------------- | --------------- | ------------- | --------- | ---------------- |
| **1**  | Positif   | Saya merasa akan sering menggunakan sistem PMB ini.                                                                   |                 |               |           |                  |
| **2**  | Negatif   | Saya merasa sistem PMB ini rumit untuk digunakan.                                                                     |                 |               |           |                  |
| **3**  | Positif   | Saya merasa sistem PMB ini mudah digunakan.                                                                           |                 |               |           |                  |
| **4**  | Negatif   | Saya memerlukan bantuan dari orang lain atau teknisi untuk dapat menggunakan sistem PMB ini.                          |                 |               |           |                  |
| **5**  | Positif   | Saya merasa fitur-fitur dalam sistem PMB ini terintegrasi dengan baik (pendaftaran, pembayaran, ujian, daftar ulang). |                 |               |           |                  |
| **6**  | Negatif   | Saya merasa terdapat inkonsistensi (ketidakselarasan) antara fitur-fitur dalam sistem PMB ini.                        |                 |               |           |                  |
| **7**  | Positif   | Saya merasa sebagian besar orang akan mudah mempelajari cara menggunakan sistem PMB ini dengan cepat.                 |                 |               |           |                  |
| **8**  | Negatif   | Saya merasa sistem PMB ini sangat sulit dan tidak nyaman untuk digunakan.                                             |                 |               |           |                  |
| **9**  | Positif   | Saya merasa percaya diri dan nyaman dalam menggunakan sistem PMB ini.                                                 |                 |               |           |                  |
| **10** | Negatif   | Saya perlu mempelajari banyak hal terlebih dahulu sebelum dapat menggunakan sistem PMB ini.                           |                 |               |           |                  |

## **E.4 Kesimpulan dan Rekomendasi Pengujian SUS**

| **Kesimpulan Hasil Pengujian System Usability Scale (SUS)**                                                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Rata-rata Skor SUS: \_**\_**\_\_<br><br>Grade: \_**\_**\_\_<br><br>Adjective Rating: \_**\_**\_\_<br><br>Analisis:<br><br>Rekomendasi Perbaikan:                                                            |
| **Tanda Tangan Peneliti**                                                                                                                                                                                   |
| Nama: \_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**<br><br>Tanggal: \_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**<br><br>Tanda Tangan: \_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_**\_\_\_ |