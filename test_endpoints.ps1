param($Token)
$h = @{"Authorization"="Bearer $Token"}
$b = "http://localhost:9500"

$eps = @(
  "/admin/periods",
  "/admin/jenis-seleksi",
  "/admin/jenis-seleksi/active",
  "/admin/program-studi",
  "/admin/program-studi/active",
  "/admin/reenrollments",
  "/admin/exam-submissions",
  "/admin/api/users",
  "/admin/api/settings",
  "/admin/api/messages",
  "/admin/api/messages/unread-count",
  "/admin/api/announcements",
  "/admin/api/hasil-akhir/all",
  "/admin/api/jenis-seleksi/available",
  "/admin/api/program-studi/available",
  "/admin/api/table/admission-forms",
  "/admin/api/table/hasil-akhir",
  "/admin/api/table/reenrollments",
  "/admin/api/validasi/formulir",
  "/admin/api/validasi/daftar-ulang",
  "/admin/api/gform-link",
  "/admin/api/reenrollments/pending",
  "/admin/api/reenrollments/in-progress",
  "/admin/api/exam/student-list",
  "/admin/api/export/hasil-akhir",
  "/admin/api/export/formulir-pembayaran",
  "/admin/api/export/daftar-ulang"
)

foreach ($ep in $eps) {
  try {
    $r = Invoke-WebRequest "$b$ep" -Headers $h -UseBasicParsing -TimeoutSec 8
    $c = $r.StatusCode
  } catch {
    $c = $_.Exception.Response.StatusCode.value__
  }
  $icon = if ($c -eq 200 -or $c -eq 201) { "[OK $c]" } elseif ($c -eq 400) { "[BAD_REQ]" } elseif ($c -eq 404) { "[NOT_FOUND]" } else { "[FAIL $c]" }
  Write-Host "$icon $ep"
}
