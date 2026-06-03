# Iterasi 2 — Revisi dan Optimisasi Modul

> Revisi fitur yang sudah diimplementasikan di Iterasi 1 berdasarkan feedback dan optimisasi UX.
> Fokus: cicilan berurutan, autocomplete asal sekolah, ekspor data yang lebih efisien.

---

# BAGIAN 1 — REVISI ITERASI 1

---

## 1.1. PAYMENT-CICILAN.HTML — Cicilan Berurutan (No Skip)

### 📋 Pemahaman Kode Saat Ini

**File:** `tugasakhir/src/main/resources/static/payment-cicilan.html`

**Struktur HTML:**
- **Container:** `#cicilanCheckboxContainer` — tempat dinamis render checkbox cicilan
- **Render:** Fungsi `renderCicilanCheckboxes(prodi)` (line ~1533)
  - Loop dari cicilan 1-6 sesuai data `prodi.cicilanN` (cicilan1, cicilan2, ..., cicilan6)
  - Buat checkbox untuk setiap cicilan yang punya nilai (hasValue = true)
  - Style: muted/disabled visual kalau belum ada harga (hasValue = false)

**JavaScript Logic:**
```javascript
renderCicilanCheckboxes(prodi) {
  // Loop 1-6, cek prodi.cicilan{N} ada nilai atau tidak
  for (let num = 1; num <= 6; num++) {
    const hasValue = prodi['cicilan' + num] > 0;
    // Render checkbox dengan onclick="toggleCicilanCheckbox(N)"
    // Disabled styling jika hasValue = false
  }
}

toggleCicilanCheckbox(num) {
  // Toggle checkbox state (checked/unchecked)
  // Update total harga yang harus dibayar
}
```

**Masalah Saat Ini:**
- ❌ Pengguna bisa pilih Cicilan 2, 3, 5 tanpa pilih 1 → jadwal cicilan berantakan
- ❌ Tidak ada validasi urutan
- ❌ Total harga otomatis jika checkbox diubah, tapi logika jadwal cicilan belum jelas
- ❌ Preview jadwal cicilan tidak menampilkan struktur yang benar

---

### 🎯 Target Revisi

**Requirement:**
1. ✅ Cicilan **HARUS berurutan** — cicilan N hanya bisa dipilih jika N-1 sudah dipilih
2. ✅ Pilihan mode: predefined groups
   - Cicilan 1
   - Cicilan 1 + 2
   - Cicilan 1 + 2 + 3
   - Cicilan 1 + 2 + 3 + 4
   - Cicilan 1 + 2 + 3 + 4 + 5
   - Cicilan 1 + 2 + 3 + 4 + 5 + 6
3. ✅ Otomatis enable/disable checkbox sesuai urutan
4. ✅ Update total harga + jadwal cicilan secara real-time

---

### 🔧 Strategi Revisi Kode

**Pendekatan: Radio Button Groups (lebih user-friendly daripada checkbox)**

**Step 1: Ubah HTML Structure**
```html
<!-- BEFORE: Individual checkboxes -->
<div id="cicilanCheckboxContainer">
  <!-- Loop cicilan 1-6 dengan checkbox -->
</div>

<!-- AFTER: Radio group (predefined) -->
<div id="cicilanGroupContainer">
  <div class="cicilan-option">
    <input type="radio" name="cicilanGroup" value="1" 
           onchange="handleCicilanGroupChange(1)">
    <label>Cicilan 1</label>
  </div>
  <div class="cicilan-option">
    <input type="radio" name="cicilanGroup" value="2" 
           onchange="handleCicilanGroupChange(2)">
    <label>Cicilan 1 + 2</label>
  </div>
  <!-- ... dst cicilan 3-6 ... -->
</div>
```

**Step 2: JavaScript Logic**
```javascript
function handleCicilanGroupChange(maxCicilan) {
  // 1. Update checkbox states (enable cicilan 1 sampai maxCicilan, disable sisanya)
  // 2. Calculate total: sum dari cicilan1 hingga cicilanMax
  // 3. Build schedule: ["Cicilan 1: Rp X (PENDING)", "Cicilan 2: Rp Y (PENDING)", ...]
  // 4. Display preview tabel cicilan dengan tanggal jatuh tempo (opsional)
  // 5. Update `selectedCicilanCount` untuk submit form
}

function renderCicilanSchedule(maxCicilan, prodi) {
  // Render tabel preview cicilan:
  // | No | Jatuh Tempo | Nominal | Status |
  // | 1  | ASAP        | Rp X    | PENDING|
  // | 2  | +30 hari    | Rp Y    | -      |
  // | ... sampai maxCicilan ...
}
```

**Step 3: Backend Integration**
- Endpoint `/api/camaba/create-cicilan-request` sudah menerima:
  - `studentId`
  - `programStudiId`
  - `jumlahCicilan` ← ini yang penting, value 1-6
- **Tidak perlu ubah backend** → hanya ubah UI

**Step 4: Handle Submit**
- Saat submit, kirim `jumlahCicilan = selectedValue` (1-6)
- Backend akan auto-generate cicilan 1 hingga N sesuai harga masing-masing

---

### 📝 Checklist Revisi

- [ ] Ganti checkbox individual menjadi radio group 6 pilihan
- [ ] Hapus fungsi `renderCicilanCheckboxes()` (kalau bisa dipaksa radio)
- [ ] Buat fungsi `handleCicilanGroupChange(maxCicilan)` baru
- [ ] Buat fungsi `renderCicilanSchedule(maxCicilan, prodi)` untuk preview tabel
- [ ] Update CSS `.cicilan-option` dan styling tabel preview
- [ ] Update form submit: ambil value radio button → kirim ke backend
- [ ] Test dengan berbagai kombinasi program studi + jumlah cicilan
- [ ] Verify jadwal cicilan di database: setiap cicilan generate CicilanRequest entry terpisah

---

---

## 1.2. FORM-PENDAFTARAN.HTML — Autocomplete Asal Sekolah (3+ Karakter)

### 📋 Pemahaman Kode Saat Ini

**File:** `tugasakhir/src/main/resources/static/form-pendaftaran.html`

**Struktur HTML:**
- **Input field:** Kolom "Asal Sekolah" → standard text input atau datalist
- **API Call:** Autocomplete dipanggil dari GitHub atau database lokal
- **Debouncing:** Mentioned tapi perlu verify implementasi

**Current Implementation (diestimasi):**
```javascript
// Assumed: input event listener pada field asal sekolah
document.getElementById('schoolOrigin').addEventListener('input', function(e) {
  const query = e.target.value;
  
  // Trigger API call jika panjang >= 2 karakter
  if (query.length >= 2) {
    debounce(() => searchSchools(query), 300);
  }
});

async function searchSchools(query) {
  // Call API GitHub atau database
  const response = await fetch(`/api/schools?q=${query}`);
  const data = await response.json();
  // Show dropdown suggestions
}
```

**Masalah Saat Ini:**
- ⚠️ **Trigger terlalu awal:** 2 karakter → terlalu banyak API calls (misal "SM" → ribuan hasil)
- ❌ Hasil dropdown mungkin membludak → UX jelek
- ❌ Tidak ada fallback kalau user input tidak ada di database → input manual di mana?
- ❌ Tidak clear apakah hasil cache atau real-time dari GitHub

---

### 🎯 Target Revisi

**Requirement:**
1. ✅ Autocomplete trigger **minimal 3 karakter** (bukan 2)
   - "SMA" → kirim API call (lebih specific)
   - "SM" → tunggu, jangan call API
2. ✅ Debouncing tetap **300ms** (OK)
3. ✅ If **tidak ditemukan** → user tetap bisa input manual
   - Input disimpan di kolom cadangan (custom school field)
   - Atau: warning "Sekolah tidak ditemukan, pastikan input dengan benar"

---

### 🔧 Strategi Revisi Kode

**Step 1: Update Input Event Listener**
```javascript
// BEFORE:
if (query.length >= 2) { 
  debounce(searchSchools(query), 300);
}

// AFTER:
if (query.length >= 3) {  // ← Ubah dari 2 menjadi 3
  debounce(searchSchools(query), 300);
} else {
  // Clear dropdown jika < 3 karakter
  clearSchoolSuggestions();
}
```

**Step 2: Improve Dropdown Logic**
```javascript
async function searchSchools(query) {
  try {
    const response = await fetch(`/api/schools/search?q=${query}&limit=10`);
    // Limit results ke 10 (jangan 100+)
    
    if (!response.ok) throw new Error('API Error');
    
    const data = await response.json();
    
    if (data.schools && data.schools.length > 0) {
      renderSuggestions(data.schools);
    } else {
      // No results found
      showNoResultsMessage(`"${query}" tidak ditemukan`);
      allowManualInput();
    }
  } catch (error) {
    console.error('Search error:', error);
    allowManualInput();
  }
}

function renderSuggestions(schools) {
  const list = document.getElementById('schoolSuggestions');
  list.innerHTML = '';
  
  schools.forEach(school => {
    const li = document.createElement('li');
    li.textContent = school.name;
    li.onclick = () => selectSchool(school.id, school.name);
    list.appendChild(li);
  });
}

function allowManualInput() {
  // Show message: "Tidak menemukan? Silakan input manual di bawah"
  document.getElementById('schoolManualNote').style.display = 'block';
  // Enable fallback textarea untuk custom input
  document.getElementById('schoolOriginCustom').disabled = false;
}
```

**Step 3: Add Fallback Field**
```html
<!-- IF autocomplete tidak menemukan hasil, enable field ini -->
<div id="schoolManualInputSection" style="display: none; margin-top: 15px;">
  <label for="schoolOriginCustom">Atau input sekolah secara manual:</label>
  <textarea id="schoolOriginCustom" 
            class="form-control" 
            placeholder="Contoh: SMA Budi Mulia, Jakarta Timur"
            maxlength="255"></textarea>
  <small class="form-text text-muted">Data Anda akan disimpan sebagai referensi baru</small>
</div>
```

**Step 4: Update Form Submit**
```javascript
function validateSchoolOrigin() {
  const selectedId = document.getElementById('schoolOrigin').value; // dari dropdown
  const customInput = document.getElementById('schoolOriginCustom').value; // fallback
  
  if (selectedId) {
    // User pilih dari suggestions
    return { success: true, value: selectedId, type: 'selected' };
  } else if (customInput) {
    // User input manual
    return { success: true, value: customInput, type: 'custom' };
  } else {
    return { success: false, error: 'Asal sekolah harus diisi' };
  }
}

// Saat submit:
const validation = validateSchoolOrigin();
if (validation.success) {
  // Submit form dengan schoolOriginCustom atau schoolOrigin sesuai type
  formData.schoolOrigin = validation.value;
}
```

---

### 📝 Checklist Revisi

- [ ] Update input event listener: trigger dari 2 karakter → 3 karakter
- [ ] Update clearSchoolSuggestions() saat panjang < 3
- [ ] Improve error handling di `searchSchools()` → allow manual input
- [ ] Add HTML field `schoolOriginCustom` (textarea) untuk fallback
- [ ] Update CSS untuk manual input section (margin, padding, hidden by default)
- [ ] Update form validation: check baik dropdown value maupun custom input
- [ ] Update backend endpoint (jika perlu) untuk track custom school input
- [ ] Test scenarios:
  - [x] Ketik "SM" → no suggestions, no API call
  - [x] Ketik "SMA" → show suggestions (jika ada)
  - [x] Ketik "SMA BudI" (typo) → no results → enable manual input
  - [x] Pilih dari dropdown → selected value ditampilkan
  - [x] Submit dengan custom input → data tersimpan

---

---

# BAGIAN 2 — REVISI EKSPOR DATA

---

## 2.1. EXPORT-ADMISSION-FORMS.HTML — Hapus View Foto

### 📋 Pemahaman Kode Saat Ini

**File:** `tugasakhir/src/main/resources/static/export-admission-forms.html`

**Struktur:**
```html
<table id="dataTable">
  <thead>
    <tr>
      <th>No</th>
      <th>Nama</th>
      <th>NIK</th>
      <th>Email</th>
      <!-- ... 15+ kolom data formulir ... -->
      <th>Foto</th>  <!-- ← KOLOM INI PERLU DIHAPUS -->
      <th>Dibuat</th>
    </tr>
  </thead>
  <tbody id="tableBody">
    <!-- Row data dengan foto link -->
    <td><a href="/uploads/foto/xxx.jpg" target="_blank" class="photo-link">Lihat Foto</a></td>
  </tbody>
</table>
```

**Current Behavior:**
- ✓ Render tabel dengan 17+ kolom
- ✓ Ada kolom "Foto" dengan link ke gambar
- ✓ Print/PDF → include kolom foto (tapi nggak ada preview, hanya link)
- ✗ **Masalah:** Print output jelek karena link foto tidak berguna di media cetak

---

### 🎯 Target Revisi

**Requirement:**
1. ✅ Hapus kolom "Foto" dari tabel
2. ✅ Tetap tampilkan **semua data formulir lainnya** (NIK, email, tempat lahir, dll)
3. ✅ Print/PDF fokus pada data text → lebih clean

---

### 🔧 Strategi Revisi Kode

**Step 1: Remove "Foto" Column Header**
```html
<!-- BEFORE -->
<th>Foto</th>
<th>Dibuat</th>

<!-- AFTER -->
<th>Dibuat</th>
```

**Step 2: Remove Photo Cell Rendering**
```javascript
// BEFORE:
const tr = document.createElement('tr');
tr.innerHTML = `
  <td>${index + 1}</td>
  <td>${row.fullName}</td>
  ...
  <td><a href="${row.photoPath}" target="_blank">Lihat Foto</a></td>
  <td>${createdDate}</td>
`;

// AFTER:
const tr = document.createElement('tr');
tr.innerHTML = `
  <td>${index + 1}</td>
  <td>${row.fullName}</td>
  ...
  <td>${createdDate}</td>
`;
```

**Step 3: Update CSV/JSON Export**
```javascript
// CSV download
const headers = ['No', 'Nama', 'NIK', 'Email', ...otherFields, 'Dibuat'];
// Hapus 'Foto' dari array

// JSON download
const jsonData = tableData.map(row => ({
  no: ...,
  nama: row.fullName,
  ...
  dibuat: row.createdAt
  // Jangan include fotoPath
}));
```

**Step 4: Update Table Width (Optional)**
```css
/* Kolom berkurang 1 → otomatis lebih lebar */
.table { width: 100%; table-layout: auto; }
/* No perlu ubah, browser auto-adjust */
```

---

### 📝 Checklist Revisi

- [ ] Hapus `<th>Foto</th>` dari thead
- [ ] Hapus cell rendering photo link di tbody loop
- [ ] Update CSV headers array (remove 'Foto')
- [ ] Update JSON export (remove fotoPath dari object)
- [ ] Verify table render tanpa photo column
- [ ] Test print/PDF output → lebih clean
- [ ] Test CSV/JSON download → no foto URLs

---

---

## 2.3. EXPORT-HASIL-AKHIR.HTML — Hapus Kolom Dokumen, NIK, Nomor Registrasi

### 📋 Pemahaman Kode Saat Ini

**File:** `tugasakhir/src/main/resources/static/export-hasil-akhir.html`

**Struktur Table:**
```html
<thead>
  <tr>
    <th>No</th>
    <th>Nama</th>
    <th>NIK</th>                    <!-- ← HAPUS -->
    <th>Email</th>
    <th>Nomor Registrasi</th>       <!-- ← HAPUS -->
    <th>BRIVA Number</th>
    <th>BRIVA Amount</th>
    <th>Jumlah Cicilan</th>
    <th>Gelombang</th>
    <th>Tipe Seleksi</th>
    <th>Program Studi</th>
    <th>Status</th>
    <th>Dibuat</th>
    <th>Diupdate</th>
    <th>Dokumen</th>                <!-- ← HAPUS (modal view) -->
  </tr>
</thead>
```

**Current Behavior:**
- ✓ Tampil 14 kolom termasuk NIK, Nomor Registrasi, Dokumen
- ✓ Ada modal popup untuk view dokumen daftar ulang
- ✗ **Masalah:** Redundan karena:
  - NIK sudah tersimpan di server → tidak perlu export lagi
  - Nomor Registrasi adalah **key unique hasil akhir** → seharusnya hanya untuk upload folder di server
  - Dokumen daftar ulang → sudah ada di `export-reenrollments.html`, tidak perlu repeat di sini

---

### 🎯 Target Revisi

**Requirement:**
1. ✅ Hapus kolom `NIK`
2. ✅ Hapus kolom `Nomor Registrasi`
3. ✅ Hapus kolom `Dokumen` (dan modal view)
4. ✅ Tetap tampilkan: Nama, Email, BRIVA Number, Amount, Jumlah Cicilan, Gelombang, Tipe Seleksi, Program Studi, Status, Dibuat, Diupdate

---

### 🔧 Strategi Revisi Kode

**Step 1: Remove Column Headers**
```html
<!-- BEFORE -->
<th>No</th>
<th>Nama</th>
<th>NIK</th>           <!-- ← HAPUS -->
<th>Email</th>
<th>Nomor Registrasi</th> <!-- ← HAPUS -->
<th>BRIVA Number</th>
...
<th>Dokumen</th>       <!-- ← HAPUS -->

<!-- AFTER -->
<th>No</th>
<th>Nama</th>
<th>Email</th>
<th>BRIVA Number</th>
<th>BRIVA Amount</th>
<th>Jumlah Cicilan</th>
<th>Gelombang</th>
<th>Tipe Seleksi</th>
<th>Program Studi</th>
<th>Status</th>
<th>Dibuat</th>
<th>Diupdate</th>
```

**Step 2: Remove Cells in Table Rendering**
```javascript
// BEFORE:
const tr = document.createElement('tr');
tr.innerHTML = `
  <td>${index + 1}</td>
  <td>${row.studentName}</td>
  <td>${row.nik}</td>                    <!-- ← HAPUS -->
  <td>${row.email}</td>
  <td>${row.nomorRegistrasi}</td>        <!-- ← HAPUS -->
  <td>${row.brivaNumber}</td>
  ...
  <td><button onclick="viewDocuments('${row.id}')">Lihat</button></td>  <!-- ← HAPUS -->
`;

// AFTER:
const tr = document.createElement('tr');
tr.innerHTML = `
  <td>${index + 1}</td>
  <td>${row.studentName}</td>
  <td>${row.email}</td>
  <td>${row.brivaNumber}</td>
  <td class="currency">${formatCurrency(row.brivaAmount)}</td>
  <td>${row.jumlahCicilan}</td>
  <td>${row.gelombang}</td>
  <td>${row.tipeSeleksi}</td>
  <td>${row.programStudi}</td>
  <td>${statusBadge}</td>
  <td>${row.createdAt}</td>
  <td>${row.updatedAt}</td>
`;
```

**Step 3: Remove Modal Dialog**
```html
<!-- HAPUS seluruh section modal view dokumen -->
<!-- <div class="modal fade" id="documentsModal" ... > -->
```

**Step 4: Remove Modal Related Functions**
```javascript
// Hapus fungsi:
// - viewDocuments()
// - loadDocuments()
// - showDocumentsModal()
```

**Step 5: Update CSV/JSON Export**
```javascript
// CSV headers
const headers = ['No', 'Nama', 'Email', 'BRIVA Number', 'BRIVA Amount', 
                 'Jumlah Cicilan', 'Gelombang', 'Tipe Seleksi', 'Program Studi', 
                 'Status', 'Dibuat', 'Diupdate'];
// Hapus 'NIK', 'Nomor Registrasi', 'Dokumen'

// JSON export
const jsonData = tableData.map(row => ({
  no: ...,
  nama: row.studentName,
  email: row.email,
  brivaNumber: row.brivaNumber,
  brivaAmount: row.brivaAmount,
  jumlahCicilan: row.jumlahCicilan,
  gelombang: row.gelombang,
  tipeSeleksi: row.tipeSeleksi,
  programStudi: row.programStudi,
  status: row.status,
  dibuat: row.createdAt,
  diupdate: row.updatedAt
  // Jangan include nik, nomorRegistrasi, documents
}));
```

---

### 📝 Checklist Revisi

- [ ] Remove `<th>NIK</th>` dari thead
- [ ] Remove `<th>Nomor Registrasi</th>` dari thead
- [ ] Remove `<th>Dokumen</th>` dari thead
- [ ] Update tbody rendering: remove 3 kolom tersebut
- [ ] Hapus fungsi `viewDocuments()`, `loadDocuments()`, dll
- [ ] Hapus modal HTML dialog `#documentsModal`
- [ ] Update CSS untuk table layout (auto-adjust width)
- [ ] Update CSV export function: remove 3 kolom dari headers
- [ ] Update JSON export function: remove 3 field dari object
- [ ] Test table render → 11 kolom saja
- [ ] Test CSV download → header dan data sesuai 11 kolom
- [ ] Test JSON download → no NIK/registration/documents fields
- [ ] Verify print output → clean, tidak ada kolom dokumen

---

---

## 2.4. EXPORT-HASIL-AKHIR-BY-WAVE.HTML — Hapus Kolom Dokumen

### 📋 Pemahaman Kode Saat Ini

**File:** `tugasakhir/src/main/resources/static/export-hasil-akhir-by-wave.html`

**Struktur Table:**
```html
<thead>
  <tr>
    <th>No</th>
    <th>Nama</th>
    <th>NIK</th>
    <th>Email</th>
    <th>Nomor Registrasi</th>
    <th>BRIVA Number</th>
    <th>BRIVA Amount</th>
    <th>Jumlah Cicilan</th>
    <th>Gelombang</th>
    <th>Tipe Seleksi</th>
    <th>Program Studi</th>
    <th>Status</th>
    <th>Dibuat</th>
    <th>Dokumen</th>        <!-- ← HAPUS HANYA INI (keep NIK dan No. Registrasi) -->
  </tr>
</thead>

<!-- Filter by Wave -->
<select id="waveSelector" onchange="filterByWave()">
  <option value="">-- Semua Gelombang --</option>
  <option value="REGULAR_TEST">Gelombang Reguler (Test)</option>
  <option value="EARLY_NO_TEST">Gelombang Awal (Tanpa Test)</option>
</select>
```

**Current Behavior:**
- ✓ Tampil tabel dengan filter dropdown gelombang
- ✓ Render sesuai wave type yang dipilih
- ✗ **Ada kolom "Dokumen"** dengan button/link untuk view dokumen daftar ulang
- ✗ **Masalah:** Modal dokumen tidak perlu di page ini (sudah ada di export-hasil-akhir.html)

**Catatan Perbedaan dari export-hasil-akhir.html:**
- ✓ Halaman ini punya **filter gelombang** (tidak ada di halaman lain)
- ✓ Tetap keep `NIK` dan `Nomor Registrasi` (berbeda dari 2.3)
- ✓ Hanya hapus kolom `Dokumen` (tidak hapus yang lain)

---

### 🎯 Target Revisi

**Requirement:**
1. ✅ Hapus kolom `Dokumen` (tapi tetap tampilkan NIK dan Nomor Registrasi)
2. ✅ Hapus modal view dokumen
3. ✅ Tetap ada filter gelombang

---

### 🔧 Strategi Revisi Kode

**Step 1: Remove Dokumen Column Header**
```html
<!-- BEFORE -->
<th>Status</th>
<th>Dibuat</th>
<th>Dokumen</th>       <!-- ← HAPUS -->

<!-- AFTER -->
<th>Status</th>
<th>Dibuat</th>
```

**Step 2: Update Table Rendering**
```javascript
// BEFORE:
const tr = document.createElement('tr');
tr.innerHTML = `
  ...
  <td>${row.status}</td>
  <td>${row.createdAt}</td>
  <td><button onclick="viewDocuments('${row.id}')">Lihat</button></td>  <!-- ← HAPUS -->
`;

// AFTER:
const tr = document.createElement('tr');
tr.innerHTML = `
  ...
  <td>${row.status}</td>
  <td>${row.createdAt}</td>
`;
```

**Step 3: Remove Modal Dialog & Functions**
```javascript
// Hapus:
// - Modal HTML #documentsModal
// - Function viewDocuments()
// - Function loadDocuments()
// - Any related event listeners
```

**Step 4: Update CSV/JSON (Remove Dokumen)**
```javascript
const headers = ['No', 'Nama', 'NIK', 'Email', 'Nomor Registrasi', 'BRIVA Number',
                 'BRIVA Amount', 'Jumlah Cicilan', 'Gelombang', 'Tipe Seleksi',
                 'Program Studi', 'Status', 'Dibuat'];
// Hapus 'Dokumen' dari array
```

---

### 📝 Checklist Revisi

- [ ] Remove `<th>Dokumen</th>` dari thead
- [ ] Update tbody: remove dokumen cell/button
- [ ] Hapus modal HTML `#documentsModal` (jika ada)
- [ ] Hapus fungsi `viewDocuments()`, `loadDocuments()`
- [ ] Update CSV export: remove 'Dokumen' dari headers
- [ ] Update JSON export: no documents field
- [ ] Test filter gelombang tetap jalan → render sesuai wave
- [ ] Test CSV/JSON download → tanpa kolom dokumen
- [ ] Verify table layout setelah hapus kolom

---

---

# SUMMARY REVISI ITERASI-2

| No | File HTML | Perubahan | Kompleksitas | Prioritas |
|----|-----------|-----------|--------------|-----------|
| 1  | payment-cicilan.html | Cicilan berurutan (radio group) | Medium | High |
| 2  | form-pendaftaran.html | Autocomplete 3+ karakter + fallback manual | Medium | High |
| 3  | export-admission-forms.html | Hapus kolom Foto | Low | Low |
| 4  | export-reenrollments.html | Download ZIP bundle bukan print | Medium | Medium |
| 5  | export-hasil-akhir.html | Hapus 3 kolom (NIK, Nomor Reg, Dokumen) | Low | Medium |
| 6  | export-hasil-akhir-by-wave.html | Hapus 1 kolom (Dokumen) | Low | Low |

---

# URUTAN EKSEKUSI YANG DISARANKAN

1. **Priority 1 (Urgent):** 
   - [ ] 3. export-admission-forms.html (paling simple)
   - [ ] 5. export-hasil-akhir.html (cukup simple)
   - [ ] 6. export-hasil-akhir-by-wave.html (simple)

2. **Priority 2 (Important):**
   - [ ] 1. payment-cicilan.html (radio group logic)
   - [ ] 2. form-pendaftaran.html (autocomplete + fallback)
   - [ ] 4. export-reenrollments.html (ZIP logic, perlu JSZip library)

**Testing & Deployment:**
- [ ] Test semua fitur di localhost sebelum deploy
- [ ] Update laporan chapter-4.tex jika ada perubahan UI/UX
- [ ] Verify dengan client sebelum final release

---

**Last Updated:** 26 April 2026  
**Status:** Ready for Development Sprint
