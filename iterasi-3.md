# iterasi 3

## 3.1 Update pada penambahan sma dimana ada dipanggil dari api seperti revisi 2 namun bisa juga di input dari admin pusat. jadi ada tambahan fitur baru yakni fitur tambah sma . jadi buat database ya dan pelajari apa aja isi kolomnya dari form-pendaftaran.html

## 3.2. EXPORT-REENROLLMENTS.HTML — Download Sebagai File Bundle (Bukan Print)

### 📋 Pemahaman Kode Saat Ini

**File:** `tugasakhir/src/main/resources/static/export-reenrollments.html`

**Struktur:**
```html
<div class="btn-group-actions no-print">
  <button class="btn btn-primary" onclick="downloadCSV()">CSV</button>
  <button class="btn btn-secondary" onclick="downloadJSON()">JSON</button>
  <button class="btn btn-info" onclick="window.print()">Print (Ctrl+P)</button>
</div>

<table id="dataTable">
  <thead>
    <th>Nama</th>
    <th>NIK</th>
    <th>Status</th>
    <th>Dokumen</th>  <!-- ← link ke dokumen PDF/JPG -->
    ...
  </thead>
  <tbody>
    <td><a href="/uploads/reenroll/xxx.pdf" target="_blank">Lihat Dokumen</a></td>
  </tbody>
</table>
```

**Current Behavior:**
- ✓ Render tabel dengan data daftar ulang
- ✓ Ada kolom "Dokumen" → link ke file individual
- ✓ Print → tampil tabel (tapi dokumen actual ga include)
- ✗ **Masalah:** User harus download dokumen satu-satu (dari link), atau print tabel (tidak ada dokumen)
- ✗ Tidak ada cara bulk download semua dokumen sekaligus

---

### 🎯 Target Revisi

**Requirement:**
1. ✅ **Ubah** "Print" button → "Download Bundle" button
2. ✅ **Fungsi:** Bundle nama file = `{email}-{nama}-daftar-ulang.zip`
   - Contoh: `michael.daniel-michael-daniel-daftar-ulang.zip`
3. ✅ **Isi ZIP:** Semua dokumen daftar ulang (PDF, JPG, dll) untuk student yang dipilih
   - Struktur folder: `/nama-student/dokumen1.pdf, dokumen2.jpg, ...`
4. ✅ **Tetap ada** CSV/JSON download untuk metadata

---

### 🔧 Strategi Revisi Kode

**Step 1: Add Download Bundle Button**
```html
<!-- BEFORE -->
<button class="btn btn-info" onclick="window.print()">Print (Ctrl+P)</button>

<!-- AFTER -->
<button class="btn btn-info" onclick="downloadReenrollmentBundle()">
  <i class="fas fa-download"></i> Download Bundle (ZIP)
</button>
```

**Step 2: Implement ZIP Download Function**
```javascript
async function downloadReenrollmentBundle() {
  // Require JSZip library (add to <head>)
  // <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
  
  const zip = new JSZip();
  
  // Loop setiap row di tableData
  for (const row of tableData) {
    const studentFolder = zip.folder(`${row.email}-${row.studentName}`);
    
    // Loop setiap dokumen (PDF/JPG/etc)
    if (row.documents && row.documents.length > 0) {
      for (const doc of row.documents) {
        // Fetch dokumen dari path
        const response = await fetch(doc.path);
        const blob = await response.blob();
        
        // Add ke folder ZIP
        const fileName = doc.path.split('/').pop(); // ekstrak nama file
        studentFolder.file(fileName, blob);
      }
    }
  }
  
  // Generate ZIP file
  const zipBlob = await zip.generateAsync({ type: 'blob' });
  
  // Download
  const url = URL.createObjectURL(zipBlob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `reenrollments-${new Date().toISOString().slice(0,10)}.zip`;
  document.body.appendChild(a);
  a.click();
  URL.revokeObjectURL(url);
  a.remove();
}
```

**Step 3: Update CSS**
```css
/* Remove @media print styles atau simplify */
@media print {
  .no-print { display: none !important; }
  /* Tapi kali ini tidak perlu print table, fokus ke ZIP download */
}
```

**Step 4: Add Library to HTML Head**
```html
<head>
  ...
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
</head>
```

**Step 5: Optional — Add Progress Indicator**
```javascript
async function downloadReenrollmentBundle() {
  const progressBtn = document.querySelector('button[onclick="downloadReenrollmentBundle()"]');
  const originalText = progressBtn.innerHTML;
  
  progressBtn.disabled = true;
  progressBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Processing...';
  
  try {
    // ... ZIP logic ...
  } finally {
    progressBtn.disabled = false;
    progressBtn.innerHTML = originalText;
  }
}
```

---

### 📝 Checklist Revisi

- [ ] Add JSZip library ke `<head>`
- [ ] Ganti "Print" button text/function → "Download Bundle"
- [ ] Implement `downloadReenrollmentBundle()` function
- [ ] Verify ZIP structure: `/email-nama/dokumen1.pdf, dokumen2.jpg`
- [ ] Test dengan multiple students + multiple dokumen per student
- [ ] Add progress indicator/disabled state saat generating ZIP
- [ ] Test file size → jika terlalu besar, consider splitting by student
- [ ] Verify dokumen file integrity dalam ZIP
- [ ] Update button icon: print icon → download icon

---

---
# 3.3 nonaktifkan akun