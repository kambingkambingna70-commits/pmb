#!/usr/bin/env python3
import zlib, urllib.request, time, os

_ALPHA = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_'

def _enc3(b1, b2, b3):
    return (_ALPHA[b1 >> 2] + _ALPHA[((b1 & 3) << 4) | (b2 >> 4)] +
            _ALPHA[((b2 & 15) << 2) | (b3 >> 6)] + _ALPHA[b3 & 63])

def _enc64(data):
    r = ''
    for i in range(0, len(data), 3):
        r += _enc3(data[i],
                   data[i+1] if i+1 < len(data) else 0,
                   data[i+2] if i+2 < len(data) else 0)
    return r

def encode(text):
    return _enc64(zlib.compress(text.encode('utf-8'))[2:-4])

code = """@startuml
skinparam DefaultFontName Arial
skinparam DefaultFontSize 12
skinparam responseMessageBelowArrow true
skinparam SequenceArrowThickness 1.5
skinparam SequenceArrowColor #2C3E50
skinparam SequenceGroupBackgroundColor #F8F9FA
skinparam SequenceGroupBorderColor #AED6F1
skinparam SequenceGroupFontColor #154360
skinparam SequenceGroupFontStyle bold
skinparam SequenceLifeLineBorderColor #2874A6
skinparam SequenceLifeLineBackgroundColor #D6EAF8
skinparam participantPadding 40
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
skinparam database {
  BackgroundColor #F5EEF8
  BorderColor #6C3483
  FontColor #6C3483
}

actor User
boundary "LoginRegisterPage" as Page
control "AuthController" as Auth
control "UserService" as Service
database "Database" as DB

== Registrasi ==
User -> Page : Buka Website
Page --> User : Tampilkan Form
User -> Page : Isi Email dan Password, Klik Register
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
User -> Page : Isi Email dan Password, Klik Login
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
  Page --> User : Redirect ke Dashboard sesuai Role
end
@enduml"""

time.sleep(3)
url = 'https://www.plantuml.com/plantuml/png/' + encode(code)
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
with urllib.request.urlopen(req, timeout=45) as r:
    data = r.read()
path = r'D:\all code\aa\Latex-TA-IF-ITERA-main\figure\sequence-user-login.png'
with open(path, 'wb') as f:
    f.write(data)
print(f'OK sequence-user-login.png ({len(data):,} bytes)')
