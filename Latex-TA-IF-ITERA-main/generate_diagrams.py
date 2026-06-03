#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Generate colored PlantUML diagrams and save PNGs for thesis.
Uses plantuml.com online API to render diagrams.
"""

import zlib, urllib.request, os, time

FIGURE_DIR = r"D:\all code\aa\Latex-TA-IF-ITERA-main\figure"

# ── PlantUML encoding ──────────────────────────────────────────────────────────
_ALPHA = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_'

def _enc3(b1, b2, b3):
    return (_ALPHA[b1 >> 2] +
            _ALPHA[((b1 & 3) << 4) | (b2 >> 4)] +
            _ALPHA[((b2 & 15) << 2) | (b3 >> 6)] +
            _ALPHA[b3 & 63])

def _enc64(data):
    r = ''
    for i in range(0, len(data), 3):
        r += _enc3(data[i],
                   data[i+1] if i+1 < len(data) else 0,
                   data[i+2] if i+2 < len(data) else 0)
    return r

def encode(text):
    return _enc64(zlib.compress(text.encode('utf-8'))[2:-4])

def save_png(text, filename):
    url = 'https://www.plantuml.com/plantuml/png/' + encode(text)
    path = os.path.join(FIGURE_DIR, filename)
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, timeout=45) as r:
            data = r.read()
        if len(data) < 500:
            print(f"  WARN {filename}: response suspiciously small ({len(data)} bytes)")
        with open(path, 'wb') as f:
            f.write(data)
        print(f"  OK   {filename} ({len(data):,} bytes)")
        return True
    except Exception as e:
        print(f"  ERR  {filename}: {e}")
        return False

# ── Shared skinparam blocks ────────────────────────────────────────────────────
ACT_SKIN = """skinparam DefaultFontName Arial
skinparam DefaultFontSize 12
skinparam ActivityBackgroundColor #FDFEFE
skinparam ActivityBorderColor #2E86C1
skinparam ActivityBorderThickness 1.5
skinparam ActivityDiamondBackgroundColor #FDFBE4
skinparam ActivityDiamondBorderColor #D4AC0D
skinparam ActivityDiamondFontColor #7D6608
skinparam ActivityStartColor #1E8449
skinparam ActivityEndColor #C0392B
skinparam ActivityArrowColor #2C3E50
skinparam ArrowFontColor #555555
skinparam ArrowFontSize 11"""

SEQ_SKIN = """skinparam DefaultFontName Arial
skinparam DefaultFontSize 12
skinparam responseMessageBelowArrow true
skinparam SequenceArrowThickness 1.5
skinparam SequenceArrowColor #2C3E50
skinparam SequenceMessageAlign center
skinparam SequenceGroupBackgroundColor #F8F9FA
skinparam SequenceGroupBorderColor #AED6F1
skinparam SequenceGroupFontColor #154360
skinparam SequenceGroupFontStyle bold
skinparam SequenceLifeLineBorderColor #2874A6
skinparam SequenceLifeLineBackgroundColor #D6EAF8
skinparam actor {
  BackgroundColor #EAFAF1
  BorderColor #1E8449
  FontColor #1A5276
  FontStyle bold
}
skinparam boundary {
  BackgroundColor #D6EAF8
  BorderColor #1A5276
  FontColor #1A5276
}
skinparam control {
  BackgroundColor #FEF9E7
  BorderColor #B7950B
  FontColor #7D6608
}
skinparam entity {
  BackgroundColor #FDEDEC
  BorderColor #922B21
  FontColor #922B21
}
skinparam database {
  BackgroundColor #F5EEF8
  BorderColor #6C3483
  FontColor #6C3483
}"""

# ── Diagram definitions ────────────────────────────────────────────────────────
diagrams = {}

# D1 – activity-login-camaba.png
diagrams['activity-login-camaba.png'] = f"""@startuml
{ACT_SKIN}

|#D6EAF8|Camaba|
start
:Akses Halaman Registrasi / Login;

if (Pilih Aksi?) then (Registrasi)
  :Mengisi Email, Password,
  dan Data Diri;

  |#D5F5E3|Sistem|
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
  |#D6EAF8|Camaba|
  :Masukkan Email;

  |#D5F5E3|Sistem|
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
  |#D6EAF8|Camaba|
  :Masukkan Email dan Password;

  |#D5F5E3|Sistem|
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
@enduml"""

# D2 – activity-pembayaran-formulir.png
diagrams['activity-pembayaran-formulir.png'] = f"""@startuml
{ACT_SKIN}

|#D6EAF8|Camaba|
start
:Login dengan
Email dan Password;

|#D5F5E3|Sistem|
:Verifikasi Login;
:Menampilkan Dashboard;

|#D6EAF8|Camaba|
:Pilih Menu Pendaftaran;

|#D5F5E3|Sistem|
:Cek Status Gelombang;

if (Gelombang aktif?) then (Tidak)
  :Menampilkan Pesan
  Gelombang Tutup;
  stop
else (Ya)
  :Tampilkan Pilihan
  Jenis Seleksi;
endif

|#D6EAF8|Camaba|
:Pilih Jenis Seleksi;
:Isi Formulir Pendaftaran
dan Upload Dokumen;
:Submit Formulir;

|#D5F5E3|Sistem|
:Simpan Formulir Pendaftaran;
:Generate Nomor
Virtual Account (BRIVA);
:Kirim Email
Notifikasi VA ke Camaba;

|#D6EAF8|Camaba|
:Bayar via BRIVA;

|#D5F5E3|Sistem|
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
@enduml"""

# D3 – activity-formulir-kartu-ujian.png
diagrams['activity-formulir-kartu-ujian.png'] = f"""@startuml
{ACT_SKIN}

|#D6EAF8|Camaba|
start
:Akses Formulir
Pendaftaran Gelombang Aktif;

|#D5F5E3|Sistem|
:Menampilkan Formulir Data;

|#D6EAF8|Camaba|
:Upload Berkas dan
Isi Data Diri;

|#D5F5E3|Sistem|
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

|#FDEBD0|Admin Validasi|
:Review Formulir Pendaftaran;

if (Formulir sesuai?) then (Tidak)
  |#D5F5E3|Sistem|
  :Update Status Formulir
  Perlu Revisi;
  :Kirim Notifikasi Revisi
  ke Camaba;
  stop
else (Ya)
  |#D5F5E3|Sistem|
  :Update Status Formulir
  Terverifikasi (APPROVED);
  :Generate Token Ujian
  (ExamToken);
  :Kirim Email Token Ujian
  ke Camaba;
endif

|#D6EAF8|Camaba|
:Terima Token Ujian
via Email;
stop
@enduml"""

# D4 – activity-proses-ujian.png
diagrams['activity-proses-ujian.png'] = f"""@startuml
{ACT_SKIN}

|#D6EAF8|Camaba|
start
:Masukkan Token Ujian;

|#D5F5E3|Sistem|
:Validasi Token;

if (Token valid?) then (Tidak)
  :Peringatan Token Tidak Valid
  atau Sudah Kadaluarsa;
  stop
else (Ya)
  :Tampilkan Halaman Ujian
  (Google Form dari sistem);
endif

|#D6EAF8|Camaba|
:Submit Hasil Ujian;

|#D5F5E3|Sistem|
:Simpan Hasil Ujian;

|#FDEBD0|Admin|
:Verifikasi Hasil Ujian;
:Tentukan Status Kelulusan;

|#D5F5E3|Sistem|
:Update Status Kelulusan;
:Tampilkan Status
Kelulusan ke Camaba;
stop
@enduml"""

# D5 – activity-daftar-ulang.png
diagrams['activity-daftar-ulang.png'] = f"""@startuml
{ACT_SKIN}

|#D6EAF8|Camaba|
start
:Login dengan
Email dan Password;

|#D5F5E3|Sistem|
:Verifikasi Login;
:Menampilkan Dashboard;

|#D6EAF8|Camaba|
:Pilih Menu Daftar Ulang;

|#D5F5E3|Sistem|
:Tampilkan Formulir
Daftar Ulang;

|#D6EAF8|Camaba|
:Isi Formulir dan Submit;

|#D5F5E3|Sistem|
:Simpan Data;
:Kirim Notifikasi
ke Admin Validasi;

|#FDEBD0|Admin Validasi|
:Konfirmasi Data;

if (Data sesuai?) then (Tidak)
  |#D5F5E3|Sistem|
  :Update Status
  Ditolak (REJECTED);
  :Notifikasi Penolakan
  ke Camaba;
  stop
else (Ya)
  |#D5F5E3|Sistem|
  :Update Status
  Tervalidasi (VALIDATED);
  :Upload Dokumen
  NPM Sementara dan
  KTM Sementara (PDF);
  :Kirim Dokumen ke Camaba;
  :Notifikasi ke Camaba;
  stop
endif
@enduml"""

# D6 – activity-konfigurasi-admin.png
diagrams['activity-konfigurasi-admin.png'] = f"""@startuml
{ACT_SKIN}

|#FDEBD0|Admin Pusat|
start
:Login dengan
Email dan Password;

|#D5F5E3|Sistem|
:Cek Login;

if (Data valid?) then (Tidak)
  :Peringatan Kesalahan
  Data Login;
  stop
else (Ya)
  :Menampilkan Dashboard;
endif

|#FDEBD0|Admin Pusat|
if (Pilih Menu?) then (Kelola Akun)
  |#D5F5E3|Sistem|
  :Tampilkan Daftar Akun;
  |#FDEBD0|Admin Pusat|
  if (Aksi?) then (Ubah Role)
    :Pilih Akun User;
    :Pilih Role Baru
    (mis. ADMIN_VALIDASI);
    |#D5F5E3|Sistem|
    :Update Role User;
    :Konfirmasi Tersimpan;
    stop
  else (Hapus)
    :Pilih Akun User;
    |#D5F5E3|Sistem|
    :Hapus Akun User;
    stop
  endif
else if (Pilih Menu?) then (Konfigurasi Sistem)
  |#D5F5E3|Sistem|
  :Tampilkan Form Konfigurasi;
  |#FDEBD0|Admin Pusat|
  :Atur Jadwal Gelombang
  dan Harga Formulir;
  |#D5F5E3|Sistem|
  :Simpan Konfigurasi;
  stop
else (Kelola Program Studi)
  |#D5F5E3|Sistem|
  :Tampilkan Daftar
  Program Studi;
  |#FDEBD0|Admin Pusat|
  :Edit Harga Total Per Tahun
  dan Harga Per Cicilan (1-6);
  |#D5F5E3|Sistem|
  :Simpan Data Program Studi;
  stop
endif
@enduml"""

# D7 – activity-ekspor-data.png
diagrams['activity-ekspor-data.png'] = f"""@startuml
{ACT_SKIN}

|#FDEBD0|Admin Validasi|
start
:Login dengan
Email dan Password;

|#D5F5E3|Sistem|
:Cek Login;

if (Data valid?) then (Tidak)
  :Peringatan Kesalahan
  Data Login;
  stop
else (Ya)
  :Menampilkan Dashboard;
endif

|#FDEBD0|Admin Validasi|
:Pilih Menu Ekspor Data;
:Set Filter
(Fakultas/Prodi/Gelombang);
:Pilih Format
(CSV / JSON / Cetak);
:Tekan Tombol Ekspor;

|#D5F5E3|Sistem|
:Query Database
Sesuai Filter;
:Generate File
Sesuai Format;

|#FDEBD0|Admin Validasi|
:Download File;
stop
@enduml"""

# D8 – sequence-user-login.png
diagrams['sequence-user-login.png'] = f"""@startuml
{SEQ_SKIN}
skinparam participantPadding 40

actor User
boundary "LoginRegisterPage" as Page
control "AuthController" as Auth
control "UserService" as Service
database "Database" as DB

== Registrasi ==
User -> Page : Buka Website
Page --> User : Tampilkan Form
User -> Page : Isi Email & Password,\\nKlik Register
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
User -> Page : Isi Email & Password,\\nKlik Login
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
  Page --> User : Redirect ke Dashboard\\nsesuai Role
end
@enduml"""

# D9a – sequence-pendaftaran-formulir.png
diagrams['sequence-pendaftaran-formulir.png'] = f"""@startuml
{SEQ_SKIN}
skinparam participantPadding 50

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
@enduml"""

# D9b – sequence-pendaftaran-ujian.png
diagrams['sequence-pendaftaran-ujian.png'] = f"""@startuml
{SEQ_SKIN}
skinparam participantPadding 50

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
  Controller --> UI : Tampilkan Halaman Ujian\\n(iframe Google Form)
  Camaba -> GF : Ikuti Ujian
  GF -> Controller : Submit Jawaban
  Controller -> DB : Simpan ExamResult
  DB --> Controller : Konfirmasi
  Controller --> UI : Nilai tersimpan
  UI --> Camaba : Notifikasi Hasil / Lulus
end
@enduml"""

# D10 – sequence-daftar-ulang.png
diagrams['sequence-daftar-ulang.png'] = f"""@startuml
{SEQ_SKIN}
skinparam participantPadding 40

actor User
boundary "UI_PMB" as UI
control "PMBController" as Controller
control "ReEnrollmentService" as ReEnroll
actor "Admin Validasi" as Admin
database "Database" as DB

User -> UI : Login Berhasil
UI -> Controller : Ambil Data Formulir
Controller -> DB : Query data +\\ncek status kelulusan

alt Belum Lulus Ujian
  DB --> Controller : Status belum lulus
  Controller --> UI : Tampilkan Dashboard +\\nPeringatan Belum Lulus
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
@enduml"""

# D11 – class-diagram.png
diagrams['class-diagram.png'] = """@startuml
skinparam DefaultFontName Arial
skinparam DefaultFontSize 11
skinparam classAttributeIconSize 0
skinparam shadowing false
skinparam class {
  BackgroundColor #EBF5FB
  BorderColor #2874A6
  BorderThickness 1.5
  HeaderBackgroundColor #2874A6
  HeaderFontColor white
  FontColor #1A5276
  AttributeFontColor #1A5276
}
skinparam enum {
  BackgroundColor #FEF9E7
  BorderColor #D4AC0D
  HeaderBackgroundColor #D4AC0D
  HeaderFontColor white
  FontColor #7D6608
}
skinparam arrow {
  Color #2C3E50
  FontColor #555555
  FontSize 10
}

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
@enduml"""

# D12 – erd.png
diagrams['erd.png'] = """@startuml
!define TABLE(name,desc) class name as "desc" << (T,#2874A6) >>
!define PK(x) <u>x</u>
!define FK(x) <i>x</i>
skinparam DefaultFontName Arial
skinparam DefaultFontSize 10
skinparam classFontSize 10
skinparam shadowing false
skinparam class {
  BackgroundColor #EBF5FB
  BorderColor #2874A6
  BorderThickness 1.5
  HeaderBackgroundColor #1A5276
  HeaderFontColor white
  FontColor #1A5276
  AttributeFontColor #1A5276
  StereotypeFontColor #C0392B
}
skinparam arrow {
  Color #2C3E50
  FontColor #555555
  FontSize 9
}
hide methods
hide stereotypes

TABLE(users, "users") {
  PK(id) : BIGINT
  email : VARCHAR(255)
  password : VARCHAR(255)
  role : ENUM(CAMABA,ADMIN_PUSAT,ADMIN_VALIDASI)
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
  gender : ENUM(MALE,FEMALE)
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
  payment_type : ENUM(REGISTRATION_FORM,INSTALLMENT_1,...)
  status : ENUM(ACTIVE,PAID,EXPIRED,CANCELLED)
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
  wave_type : ENUM(EARLY_NO_TEST,RANKING_NO_TEST,...)
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
  status : ENUM(PENDING,STARTED,COMPLETED,GRADED)
  created_at : DATETIME
}
TABLE(exam_tokens, "exam_tokens") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  token_value : VARCHAR(50)
  status : ENUM(ACTIVE,USED,EXPIRED,REVOKED)
  expires_at : DATETIME
  used_at : DATETIME
  approved_form_id : BIGINT
  created_at : DATETIME
}
TABLE(exam_results, "exam_results") {
  PK(id) : BIGINT
  FK(exam_id) : BIGINT
  FK(student_id) : BIGINT
  score : DOUBLE
  status : ENUM(PASSED,FAILED,PENDING)
  token_validated : TINYINT(1)
  verified_at : DATETIME
}
TABLE(reenrollments, "reenrollments") {
  PK(id) : BIGINT
  FK(student_id) : BIGINT
  FK(exam_result_id) : BIGINT
  status : ENUM(SUBMITTED,VALIDATED,REJECTED)
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
@enduml"""

# ── Main ───────────────────────────────────────────────────────────────────────
if __name__ == '__main__':
    print(f"Generating {len(diagrams)} colored diagrams via plantuml.com...\n")
    ok, fail = 0, 0
    for filename, code in diagrams.items():
        print(f"[{filename}]")
        if save_png(code, filename):
            ok += 1
        else:
            fail += 1
        time.sleep(0.8)   # be polite to plantuml.com

    print(f"\n{'='*55}")
    print(f"Done: {ok} OK, {fail} FAILED")
    if fail:
        print("Re-run the script to retry failed downloads.")
