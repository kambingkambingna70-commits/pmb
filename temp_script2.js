// ===== CICILAN REQUEST MANAGEMENT FUNCTIONS =====
        let cicilanPage = 1;
        let cicilanPageSize = 10;
        let allCicilanRequests = [];

        // ===== HASIL VALIDASI CICILAN VARIABLES =====
        let cicilanHasilPage = 1;
        let cicilanHasilPageSize = 10;
        let allCicilanHasilRequests = [];

        async function loadPendingCicilanRequests() {
            try {
                console.log('ðŸ”„ [CICILAN-LOAD] Loading pending cicilan requests... page:', cicilanPage, 'size:', cicilanPageSize);
                const response = await fetch(`/admin/cicilan/pending?page=${cicilanPage - 1}&size=${cicilanPageSize}`, {
                    headers: { 'Authorization': 'Bearer ' + authToken }
                });

                console.log('ðŸ“¡ [CICILAN-LOAD] Response status:', response.status, 'ok:', response.ok);

                if (!response.ok) {
                    console.error('âŒ [CICILAN-LOAD] Failed to load cicilan requests:', response.statusText);
                    document.getElementById('emptyStateCicilan').style.display = 'block';
                    return;
                }

                const data = await response.json();
                console.log('ðŸ“¦ [CICILAN-LOAD] Response data:', data);
                allCicilanRequests = data.content || [];
                console.log('âœ… [CICILAN-LOAD] Loaded', allCicilanRequests.length, 'cicilan requests');
                
                displayCicilanTable();
                updateCicilanPagination(data.totalElements || 0);
            } catch (error) {
                console.error('âŒ [CICILAN-LOAD] Error:', error);
                document.getElementById('emptyStateCicilan').style.display = 'block';
            }
        }

        function displayCicilanTable() {
            const tbody = document.getElementById('cicilanTable-body');
            tbody.innerHTML = '';

            if (allCicilanRequests.length === 0) {
                document.getElementById('emptyStateCicilan').style.display = 'block';
                return;
            }

            document.getElementById('emptyStateCicilan').style.display = 'none';

            allCicilanRequests.forEach(item => {
                const row = document.createElement('tr');
                const brivaDisplay = item.briva ? `<strong style="color: #27ae60;">${item.briva}</strong>` : '<span style="color: #e74c3c;"><i class="fas fa-times-circle text-danger"></i> Kosong</span>';
                
                // Derive which cicilans were selected from non-zero hargaCicilan values
                const selectedNums = [];
                if (item.hargaCicilan1 > 0) selectedNums.push(1);
                if (item.hargaCicilan2 > 0) selectedNums.push(2);
                if (item.hargaCicilan3 > 0) selectedNums.push(3);
                if (item.hargaCicilan4 > 0) selectedNums.push(4);
                if (item.hargaCicilan5 > 0) selectedNums.push(5);
                if (item.hargaCicilan6 > 0) selectedNums.push(6);
                const jumlahDisplay = selectedNums.length > 0 ? selectedNums.join(', ') : `${item.jumlahCicilan}x`;
                
                // Total of selected cicilans
                const selectedTotal = (item.hargaCicilan1 || 0) + (item.hargaCicilan2 || 0) + (item.hargaCicilan3 || 0) + (item.hargaCicilan4 || 0) + (item.hargaCicilan5 || 0) + (item.hargaCicilan6 || 0);
                const totalCicilanDisplay = selectedTotal > 0 ? selectedTotal : item.hargaPerCicilan;
                
                row.innerHTML = `
                    <td><strong>${item.studentName || '-'}</strong></td>
                    <td>${item.studentEmail || '-'}</td>
                    <td>${item.programStudiName || '-'}</td>
                    <td style="text-align: center;"><strong>${jumlahDisplay}</strong></td>
                    <td style="text-align: right;">Rp ${formatCurrencyInline(totalCicilanDisplay)}</td>
                    <td style="text-align: right;">Rp ${formatCurrencyInline(item.hargaTotal)}</td>
                    <td style="text-align: center; background: #fff9e6;">${brivaDisplay}</td>
                    <td style="text-align: center;"><span class="badge bg-warning text-dark">${item.statusLabel || item.status}</span></td>
                    <td style="text-align: center;">${formatDate(item.createdAt)}</td>
                    <td style="text-align: center;">
                        <button class="btn btn-sm btn-primary" onclick="openAllDetailsModal(${item.admissionFormId || item.id}, ${item.studentId || 0}, '${item.studentName || ''}', '${item.waveType || 'REGULAR_TEST'}', '${item.paymentMethod || ''}')" 
                                title="Lihat semua detail">
                            <i class="bi bi-folder2-open"></i> Semua Detail
                        </button>
                    </td>
                    <td style="text-align: center; min-width: 450px;">
                        <div style="display: flex; gap: 5px; justify-content: center; align-items: center; flex-wrap: nowrap; white-space: nowrap;">
                            <button class="btn btn-sm btn-primary" title="Edit cicilan" onclick="showEditCicilanModal(${item.id}, ${item.jumlahCicilan}, ${item.hargaCicilan1}, ${item.hargaTotal}, '${item.briva || ''}', '${item.paymentMethod || ''}')" style="flex-shrink: 0;">
                                <i class="bi bi-pencil"></i> Edit
                            </button>
                            <button class="btn btn-sm btn-success" onclick="showApproveCicilanModal(${item.id}, ${item.jumlahCicilan}, ${item.hargaCicilan1}, ${item.hargaTotal}, '${item.briva || ''}')" style="flex-shrink: 0;">
                                <i class="bi bi-check-circle"></i> Terima
                            </button>
                            <button class="btn btn-sm btn-danger" onclick="showRejectCicilanModal(${item.id})" style="flex-shrink: 0;">
                                <i class="bi bi-x-circle"></i> Tolak
                            </button>
                            <button class="btn btn-sm btn-outline-danger" title="Hapus cicilan" onclick="deleteCicilanRequest(${item.id})" style="flex-shrink: 0;">
                                <i class="bi bi-trash"></i> Hapus
                            </button>
                        </div>
                    </td>
                `;
                tbody.appendChild(row);
            });
        }

        function updateCicilanPagination(total) {
            const totalPages = Math.ceil(total / cicilanPageSize);
            document.getElementById('cicilanFromEntry').textContent = (cicilanPage - 1) * cicilanPageSize + 1;
            document.getElementById('cicilanToEntry').textContent = Math.min(cicilanPage * cicilanPageSize, total);
            document.getElementById('cicilanTotalEntries').textContent = total;
            document.getElementById('cicilanCurrentPage').textContent = cicilanPage;

            document.getElementById('cicilanPrevBtn').querySelector('a').style.pointerEvents = cicilanPage === 1 ? 'none' : 'auto';
            document.getElementById('cicilanPrevBtn').querySelector('a').style.opacity = cicilanPage === 1 ? '0.5' : '1';
            document.getElementById('cicilanNextBtn').querySelector('a').style.pointerEvents = cicilanPage >= totalPages ? 'none' : 'auto';
            document.getElementById('cicilanNextBtn').querySelector('a').style.opacity = cicilanPage >= totalPages ? '0.5' : '1';
        }

        function prevCicilanPage(e) {
            e.preventDefault();
            if (cicilanPage > 1) {
                cicilanPage--;
                loadPendingCicilanRequests();
            }
        }

        function nextCicilanPage(e) {
            e.preventDefault();
            cicilanPage++;
            loadPendingCicilanRequests();
        }

        function changeCicilanPageSize() {
            cicilanPageSize = parseInt(document.getElementById('entriesCicilan').value);
            cicilanPage = 1;
            loadPendingCicilanRequests();
        }

        function filterCicilanTable() {
            const search = document.getElementById('searchCicilan').value.toLowerCase();
            const rows = document.getElementById('cicilanTable-body').querySelectorAll('tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(search) ? '' : 'none';
            });
        }

        function showApproveCicilanModal(id, jumlah, harga1, hargaTotal, currentBriva) {
            // Show prompt for BRIVA if not set
            let briva = currentBriva;
            if (!briva || briva.trim() === '') {
 briva = prompt(' BRIVA Kosong!\n\nTolong masukkan nomor BRIVA untuk calon mahasiswa ini:\n\n(Format: nomor virtual account BRI)');
                if (briva === null) return; // User cancelled
                if (!briva.trim()) {
 alert(' BRIVA tidak boleh kosong!');
                    return;
                }
            } else {
                // If BRIVA already exists, ask if want to change or proceed
                const changeOption = prompt(`BRIVA saat ini: ${briva}\n\nKetik BRIVA baru untuk mengubah, atau tekan OK untuk tetap menggunakan yang sama`);
                if (changeOption !== null) {
                    if (changeOption.trim()) {
                        briva = changeOption;
                    }
                } else {
                    return; // User cancelled
                }
            }
            approveCicilan(id, jumlah, harga1, briva);
        }

        async function approveCicilan(id, jumlahCicilan, hargaCicilan1, briva) {
            try {
                // Validate BRIVA
                if (!briva || briva.trim() === '') {
 alert(' Tolong tambahkan BRIVA calon mahasiswa! (Nomor Virtual Account)\n\nBRIVA tidak boleh kosong sebelum cicilan disetujui.');
                    return;
                }

                console.log('ðŸ“¡ [CICILAN-APPROVE] Approving cicilan:', id);
                console.log('ðŸ”‘ [CICILAN-APPROVE] Using auth token:', authToken ? authToken.substring(0, 20) + '...' : 'NONE');

                const payload = {
                    jumlahCicilan: jumlahCicilan,
                    hargaCicilan1: hargaCicilan1,
                    briva: briva.trim(),
                    approvedBy: 'Admin'  // Set admin user
                };

                const response = await fetch(`/admin/cicilan/${id}/approve`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + authToken
                    },
                    body: JSON.stringify(payload)
                });

                console.log('ðŸ“¡ [CICILAN-APPROVE] Response status:', response.status, response.statusText);

                if (response.ok) {
                    console.log('âœ… [CICILAN-APPROVE] Successfully approved');
 alert(' Cicilan request disetujui!\nBRIVA: ' + briva);
                    // Reset pagination dan refresh kedua tabel
                    cicilanPage = 1;
                    cicilanHasilPage = 1;
                    // Data otomatis berpindah dari PENDING ke APPROVED (karena BRIVA filled + STATUS = APPROVED)
                    loadPendingCicilanRequests();   // Cicilan hilang dari tabel ini
                    loadApprovedCicilanRequests();  // Cicilan muncul di tabel ini
                } else {
                    console.error('âŒ [CICILAN-APPROVE] Failed to approve:', response.status);
                    const error = await response.json();
 alert(' Gagal menyetujui: ' + (error.message || response.statusText));
                }
            } catch (error) {
                console.error('âŒ [CICILAN-APPROVE] Error approving cicilan:', error);
                alert('Error: ' + error.message);
            }
        }

        function showRejectCicilanModal(id) {
            window.currentRejectCicilanId = id;
            const reasonTextarea = document.getElementById('cicilanRejectReason');
            reasonTextarea.value = '';
            reasonTextarea.focus();
            const modal = new bootstrap.Modal(document.getElementById('cicilanRejectModal'));
            modal.show();
        }

        function submitCicilanRejection() {
            const reasonTextarea = document.getElementById('cicilanRejectReason');
            
            // Force read from DOM element directly
            let reason = '';
            if (reasonTextarea) {
                reason = reasonTextarea.value || '';
                reason = reason.trim();
            }
            
            console.log('ðŸ” [CICILAN-REJECT-DEBUG] Textarea element exists:', !!reasonTextarea);
            console.log('ðŸ” [CICILAN-REJECT-DEBUG] Raw value:', reasonTextarea?.value);
            console.log('ðŸ” [CICILAN-REJECT-DEBUG] After trim:', reason);
            console.log('ðŸ” [CICILAN-REJECT-DEBUG] Length:', reason.length);
            
            if (!reason || reason.length === 0) {
 alert(' Alasan penolakan harus diisi! Mohon ketik pesan penolakan di textbox.');
                reasonTextarea?.focus();
                return;
            }
            
            const id = window.currentRejectCicilanId;
            if (!id) {
 alert(' ID cicilan tidak ditemukan!');
                return;
            }
            
            console.log('ðŸ” [CICILAN-REJECT-DEBUG] Will reject ID:', id);
            console.log('ðŸ” [CICILAN-REJECT-DEBUG] Will send reason:', reason);
            
            const modal = bootstrap.Modal.getInstance(document.getElementById('cicilanRejectModal'));
            if (modal) {
                modal.hide();
            }
            
            // Small delay to ensure modal closes before API call
            setTimeout(() => {
                rejectCicilan(id, reason);
            }, 300);
        }

        async function rejectCicilan(id, reason) {
            try {
                console.log('ðŸ“¡ [CICILAN-REJECT] Rejecting cicilan ID:', id);
                console.log('ðŸ“¡ [CICILAN-REJECT] Reason text:', reason);
                console.log('ðŸ“¡ [CICILAN-REJECT] Reason length:', reason.length);
                console.log('ðŸ”‘ [CICILAN-REJECT] Using auth token:', authToken ? authToken.substring(0, 20) + '...' : 'NONE');
                
                // Ensure reason is not empty
                if (!reason || reason.trim().length === 0) {
 alert(' Alasan kosong sebelum dikirim ke API!');
                    return;
                }
                
                const payload = { 
                    reason: reason.trim()
                };
                
                console.log('ðŸ“¡ [CICILAN-REJECT] Payload to send:', JSON.stringify(payload));

                const response = await fetch(`/admin/cicilan/${id}/reject`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + authToken
                    },
                    body: JSON.stringify(payload)
                });

                console.log('ðŸ“¡ [CICILAN-REJECT] Response status:', response.status, response.statusText);

                if (response.ok) {
                    console.log('âœ… [CICILAN-REJECT] Successfully rejected');
 alert(' Cicilan request ditolak dan email telah dikirim!');
                    cicilanPage = 1;
                    cicilanHasilPage = 1;
                    loadPendingCicilanRequests();
                    loadApprovedCicilanRequests();
                } else {
                    const error = await response.json();
                    console.error('âŒ [CICILAN-REJECT] Failed with status:', response.status);
                    console.error('âŒ [CICILAN-REJECT] Error response:', JSON.stringify(error));
 alert(' Gagal menolak: ' + (error.message || response.statusText));
                }
            } catch (error) {
                console.error('âŒ [CICILAN-REJECT] Exception:', error);
                alert('Error: ' + error.message);
            }
        }

        // ===== EDIT CICILAN MODAL =====
        function showEditCicilanModal(id, jumlah, harga1, hargaTotal, currentBriva, paymentMethod) {
            const newJumlah = prompt('Masukkan jumlah cicilan (1-6):', jumlah);
            if (newJumlah === null) return;
            
            const jmlh = parseInt(newJumlah);
            if (isNaN(jmlh) || jmlh < 1 || jmlh > 6) {
 alert(' Jumlah cicilan harus 1-6');
                return;
            }

            const newHarga1 = prompt('Masukkan harga cicilan pertama:', harga1);
            if (newHarga1 === null) return;
            
            const hg1 = parseFloat(newHarga1);
            if (isNaN(hg1) || hg1 <= 0) {
 alert(' Harga cicilan harus lebih dari 0');
                return;
            }

            // <i class="fas fa-check-circle text-success"></i> NEW: BRIVA sekarang OPTIONAL
            // Admin bisa edit jumlah/harga tanpa perlu isi BRIVA
            // BRIVA bisa tetap yang lama atau diganti nanti
            let briva = currentBriva || '';
            
            if (briva && briva.trim() !== '') {
                // If BRIVA already exists, ask if want to change
 const changeOption = prompt(` BRIVA saat ini: ${briva}\n\nKetik BRIVA baru untuk mengubah, atau tekan OK untuk tetap menggunakan yang sama`);
                if (changeOption !== null && changeOption.trim()) {
                    briva = changeOption.trim();
                }
                // If empty (user pressed OK without input) â†’ keep existing briva
            } else {
                // BRIVA kosong - ask jika mau diisi, tapi gak wajib
 const newBriva = prompt(' BRIVA (Opsional):\n\nTinggalkan kosong jika ingin diisi nanti');
                if (newBriva !== null && newBriva.trim()) {
                    briva = newBriva.trim();
                }
                // If cancel atau kosong â†’ briva tetap ''
            }

            editCicilan(id, jmlh, hg1, briva);
        }

        async function editCicilan(id, jumlahCicilan, hargaCicilan1, briva) {
            try {
                const payload = {
                    jumlahCicilan: jumlahCicilan,
                    hargaCicilan1: hargaCicilan1,
                    briva: briva,  // <i class="fas fa-check-circle text-success"></i> Optional - bisa empty string
                    approvedBy: 'Admin'
                };

                console.log('ðŸ“¤ [EDIT-CICILAN] Payload:', payload);

                const response = await fetch(`/admin/cicilan/${id}/approve`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer ' + authToken
                    },
                    body: JSON.stringify(payload)
                });

                if (response.ok) {
 alert(' Cicilan berhasil diupdate!');
                    cicilanPage = 1;
                    cicilanHasilPage = 1;
                    loadPendingCicilanRequests();
                    loadApprovedCicilanRequests();
                } else {
                    const error = await response.json();
 alert(' Gagal update cicilan: ' + (error.message || response.statusText));
                }
            } catch (error) {
                console.error('Error editing cicilan:', error);
                alert('Error: ' + error.message);
            }
        }

        // ===== DELETE CICILAN =====
        async function deleteCicilanRequest(id) {
            if (!confirm('<i class="fas fa-exclamation-triangle text-warning"></i> Yakin ingin menghapus cicilan ini? Tindakan ini tidak dapat dibatalkan!')) {
                return;
            }

            try {
                const response = await fetch(`/admin/cicilan/${id}`, {
                    method: 'DELETE',
                    headers: {
                        'Authorization': 'Bearer ' + authToken
                    }
                });

                if (response.ok) {
 alert(' Cicilan berhasil dihapus!');
                    cicilanPage = 1;
                    loadPendingCicilanRequests();
                } else {
                    const error = await response.json();
 alert(' Gagal menghapus cicilan: ' + (error.message || response.statusText));
                }
            } catch (error) {
                console.error('Error deleting cicilan:', error);
                alert('Error: ' + error.message);
            }
        }

        function formatCurrencyInline(value) {
            return new Intl.NumberFormat('id-ID').format(value || 0);
        }

        function formatDate(dateString) {
            if (!dateString) return '-';
            const date = new Date(dateString);
            return date.toLocaleDateString('id-ID');
        }

        console.log('âœ… [CICILAN] Functions loaded: loadPendingCicilanRequests, approveCicilan, rejectCicilan');

        // ===== HASIL VALIDASI CICILAN FUNCTIONS =====
        async function loadApprovedCicilanRequests() {
            try {
                console.log('ðŸ”„ [CICILAN-HASIL] Loading hasil validasi cicilan... page:', cicilanHasilPage, 'size:', cicilanHasilPageSize);
                const response = await fetch(`/admin/cicilan/by-status/APPROVED?page=${cicilanHasilPage - 1}&size=${cicilanHasilPageSize}`, {
                    headers: { 'Authorization': 'Bearer ' + authToken }
                });

                console.log('ðŸ“¡ [CICILAN-HASIL] Response status:', response.status, 'ok:', response.ok);

                if (!response.ok) {
                    console.error('âŒ [CICILAN-HASIL] Failed to load hasil validasi cicilan:', response.statusText);
                    document.getElementById('emptyStateCicilanHasil').style.display = 'block';
                    return;
                }

                const data = await response.json();
                console.log('ðŸ“¦ [CICILAN-HASIL] Response data:', data);
                allCicilanHasilRequests = data.content || [];
                console.log('âœ… [CICILAN-HASIL] Loaded', allCicilanHasilRequests.length, 'hasil validasi cicilan');
                
                displayCicilanHasilTable();
                updateCicilanHasilPagination(data.totalElements || 0);
            } catch (error) {
                console.error('âŒ [CICILAN-HASIL] Error:', error);
                document.getElementById('emptyStateCicilanHasil').style.display = 'block';
            }
        }

        function displayCicilanHasilTable() {
            const tbody = document.getElementById('cicilanHasilTable-body');
            tbody.innerHTML = '';

            if (allCicilanHasilRequests.length === 0) {
                document.getElementById('emptyStateCicilanHasil').style.display = 'block';
                return;
            }

            document.getElementById('emptyStateCicilanHasil').style.display = 'none';

            allCicilanHasilRequests.forEach(item => {
                const row = document.createElement('tr');
                
                // Status badge color
                let statusBadgeClass = 'bg-success';
                let statusText = 'APPROVED <i class="fas fa-check-circle text-success"></i>';
                if (item.status === 'REJECTED') {
                    statusBadgeClass = 'bg-danger';
                    statusText = 'REJECTED <i class="fas fa-times-circle text-danger"></i>';
                }

                // BRIVA display
                const brivaDisplay = item.briva ? `<strong style="color: #27ae60;">${item.briva}</strong>` : '<span style="color: #999;">-</span>';

                // Keterangan display
                const keterangan = item.catatan ? `<small>${item.catatan.substring(0, 30)}${item.catatan.length > 30 ? '...' : ''}</small>` : '<span style="color: #999;">-</span>';

                // Derive which cicilans were selected from non-zero hargaCicilan values
                const selectedNums = [];
                if (item.hargaCicilan1 > 0) selectedNums.push(1);
                if (item.hargaCicilan2 > 0) selectedNums.push(2);
                if (item.hargaCicilan3 > 0) selectedNums.push(3);
                if (item.hargaCicilan4 > 0) selectedNums.push(4);
                if (item.hargaCicilan5 > 0) selectedNums.push(5);
                if (item.hargaCicilan6 > 0) selectedNums.push(6);
                const jumlahDisplay = selectedNums.length > 0 ? selectedNums.join(', ') : `${item.jumlahCicilan}x`;
                
                // Total of selected cicilans
                const selectedTotal = (item.hargaCicilan1 || 0) + (item.hargaCicilan2 || 0) + (item.hargaCicilan3 || 0) + (item.hargaCicilan4 || 0) + (item.hargaCicilan5 || 0) + (item.hargaCicilan6 || 0);
                const totalCicilanDisplay = selectedTotal > 0 ? selectedTotal : item.hargaPerCicilan;

                row.innerHTML = `
                    <td><strong>${item.studentName || '-'}</strong></td>
                    <td>${item.studentEmail || '-'}</td>
                    <td>${item.programStudiName || '-'}</td>
                    <td style="text-align: center;"><strong>${jumlahDisplay}</strong></td>
                    <td style="text-align: right;">Rp ${formatCurrencyInline(totalCicilanDisplay)}</td>
                    <td style="text-align: right;">Rp ${formatCurrencyInline(item.hargaTotal)}</td>
                    <td style="text-align: center;">${brivaDisplay}</td>
                    <td style="text-align: center;"><span class="badge ${statusBadgeClass}">${statusText}</span></td>
                    <td style="text-align: center;"><small>${item.approvedBy || '-'}</small></td>
                    <td style="text-align: center;"><small>${formatDate(item.approvedAt)}</small></td>
                    <td style="text-align: center;">${keterangan}</td>
                `;
                tbody.appendChild(row);
            });
        }

        function updateCicilanHasilPagination(total) {
            const totalPages = Math.ceil(total / cicilanHasilPageSize);
            document.getElementById('cicilanHasilFromEntry').textContent = (cicilanHasilPage - 1) * cicilanHasilPageSize + 1;
            document.getElementById('cicilanHasilToEntry').textContent = Math.min(cicilanHasilPage * cicilanHasilPageSize, total);
            document.getElementById('cicilanHasilTotalEntries').textContent = total;
            document.getElementById('cicilanHasilCurrentPage').textContent = cicilanHasilPage;

            document.getElementById('cicilanHasilPrevBtn').querySelector('a').style.pointerEvents = cicilanHasilPage === 1 ? 'none' : 'auto';
            document.getElementById('cicilanHasilPrevBtn').querySelector('a').style.opacity = cicilanHasilPage === 1 ? '0.5' : '1';
            document.getElementById('cicilanHasilNextBtn').querySelector('a').style.pointerEvents = cicilanHasilPage >= totalPages ? 'none' : 'auto';
            document.getElementById('cicilanHasilNextBtn').querySelector('a').style.opacity = cicilanHasilPage >= totalPages ? '0.5' : '1';
        }

        function prevCicilanHasilPage(e) {
            e.preventDefault();
            if (cicilanHasilPage > 1) {
                cicilanHasilPage--;
                loadApprovedCicilanRequests();
            }
        }

        function nextCicilanHasilPage(e) {
            e.preventDefault();
            cicilanHasilPage++;
            loadApprovedCicilanRequests();
        }

        function changeCicilanHasilPageSize() {
            cicilanHasilPageSize = parseInt(document.getElementById('entriesCicilanHasil').value);
            cicilanHasilPage = 1;
            loadApprovedCicilanRequests();
        }

        function filterCicilanHasilTable() {
            const search = document.getElementById('searchCicilanHasil').value.toLowerCase();
            const rows = document.getElementById('cicilanHasilTable-body').querySelectorAll('tr');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(search) ? '' : 'none';
            });
        }

        console.log('âœ… [HASIL VALIDASI CICILAN] Functions loaded: loadApprovedCicilanRequests');

        // ===== VALIDASI UJIAN TAB FUNCTIONS =====
        
        function getExamAuthToken() {
            if (authToken && authToken !== 'undefined' && authToken !== 'null') return authToken;
            authToken = sessionStorage.getItem('authToken') || localStorage.getItem('authToken');
            return authToken;
        }

        function loadAllExamSubmissions() {
            console.log('ðŸ“‹ [EXAM-VAL] Loading ALL exam submission tables...');
            loadPendingExamSubmissions();
            loadRejectedExamSubmissions();
            loadApprovedExamSubmissions();
        }

        async function loadPendingExamSubmissions() {
            const tbody = document.getElementById('examPendingBody');
            try {
                const token = getExamAuthToken();
                console.log('ðŸ“‹ [EXAM-VAL] Loading PENDING... authToken:', token ? 'OK' : 'MISSING');
                if (!token) {
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center text-danger py-4"><i class="bi bi-exclamation-triangle"></i> Token autentikasi tidak ditemukan. Silakan login ulang.</td></tr>';
                    return;
                }
                const res = await fetch('/admin/exam-submissions?status=PENDING', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });
                console.log('ðŸ“‹ [EXAM-VAL] PENDING response:', res.status, res.ok);
                if (!res.ok) {
                    const errText = await res.text();
                    console.error('âŒ [EXAM-VAL] PENDING error body:', errText);
                    throw new Error('HTTP ' + res.status);
                }
                const data = await res.json();
                console.log('ðŸ“‹ [EXAM-VAL] PENDING data:', data.length, 'items');
                
                document.getElementById('examPendingCount').textContent = data.length;
                
                if (!data.length) {
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted py-4"><i class="bi bi-inbox"></i> Tidak ada ujian yang menunggu validasi</td></tr>';
                    return;
                }
                
                tbody.innerHTML = data.map((item, i) => {
                    const photoUrl = item.proofPhotoPath ? '/api/files/show?path=' + encodeURIComponent(item.proofPhotoPath.replace(/^\//, '')) : '';
                    return `
                    <tr>
                        <td class="text-center">${i + 1}</td>
                        <td><strong>${item.studentName || '-'}</strong></td>
                        <td><small>${item.studentEmail || '-'}</small></td>
                        <td class="text-center"><span class="badge bg-primary">${item.gformScore != null ? item.gformScore : '-'}</span></td>
                        <td class="text-center">
                            <code style="font-size:11px;">${item.generatedToken || '-'}</code>
                        </td>
                        <td class="text-center">
                            ${photoUrl 
                                ? '<img src="' + photoUrl + '" style="width:50px;height:50px;object-fit:cover;border-radius:6px;cursor:pointer;border:2px solid #27ae60;" onclick="viewExamDetail(' + item.id + ', ' + item.studentId + ')" />' 
                                : '<span class="badge bg-secondary">-</span>'}
                        </td>
                        <td><small>${item.submissionDate ? new Date(item.submissionDate).toLocaleDateString('id-ID', {day:'2-digit',month:'short',year:'numeric',hour:'2-digit',minute:'2-digit'}) : '-'}</small></td>
                        <td>
                            <div class="d-flex gap-1">
                                <button class="btn btn-sm btn-success" onclick="approveExamSubmission(${item.id}, '${(item.studentName||'').replace(/'/g,"\\'")}')">
                                    <i class="bi bi-check-lg"></i> Terima
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="rejectExamSubmission(${item.id}, '${(item.studentName||'').replace(/'/g,"\\'")}')">
                                    <i class="bi bi-x-lg"></i> Tolak
                                </button>
                                <button class="btn btn-sm btn-outline-secondary" onclick="viewExamDetail(${item.id}, ${item.studentId})">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                `}).join('');
                
                console.log('âœ… [EXAM-VAL] Loaded', data.length, 'pending exam submissions');
            } catch (error) {
                console.error('âŒ [EXAM-VAL] Error loading pending:', error);
                tbody.innerHTML = '<tr><td colspan="8" class="text-center text-danger py-4"><i class="bi bi-exclamation-triangle"></i> Gagal memuat data: ' + error.message + '</td></tr>';
            }
        }

        async function loadRejectedExamSubmissions() {
            const tbody = document.getElementById('examRejectedBody');
            try {
                const token = getExamAuthToken();
                console.log('ðŸ“‹ [EXAM-VAL] Loading REJECTED... authToken:', token ? 'OK' : 'MISSING');
                if (!token) {
                    tbody.innerHTML = '<tr><td colspan="7" class="text-center text-danger py-4"><i class="bi bi-exclamation-triangle"></i> Token autentikasi tidak ditemukan.</td></tr>';
                    return;
                }
                const res = await fetch('/admin/exam-submissions?status=REJECTED', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });
                if (!res.ok) throw new Error('HTTP ' + res.status);
                const data = await res.json();
                
                document.getElementById('examRejectedCount').textContent = data.length;
                
                if (!data.length) {
                    tbody.innerHTML = '<tr><td colspan="7" class="text-center text-muted py-4"><i class="bi bi-inbox"></i> Tidak ada ujian yang ditolak</td></tr>';
                    return;
                }
                
                tbody.innerHTML = data.map((item, i) => `
                    <tr>
                        <td class="text-center">${i + 1}</td>
                        <td><strong>${item.studentName || '-'}</strong></td>
                        <td><small>${item.studentEmail || '-'}</small></td>
                        <td class="text-center"><span class="badge bg-primary">${item.gformScore != null ? item.gformScore : '-'}</span></td>
                        <td class="text-center">
                            <code style="font-size:11px;">${item.generatedToken || '-'}</code>
                        </td>
                        <td><small>${item.submissionDate ? new Date(item.submissionDate).toLocaleDateString('id-ID', {day:'2-digit',month:'short',year:'numeric'}) : '-'}</small></td>
                        <td><small class="text-danger">${item.adminNotes || '-'}</small></td>
                    </tr>
                `).join('');
                
                console.log('âœ… [EXAM-VAL] Loaded', data.length, 'rejected exam submissions');
            } catch (error) {
                console.error('âŒ [EXAM-VAL] Error loading rejected:', error);
                tbody.innerHTML = '<tr><td colspan="7" class="text-center text-danger py-4"><i class="bi bi-exclamation-triangle"></i> Gagal memuat data: ' + error.message + '</td></tr>';
            }
        }

        async function loadApprovedExamSubmissions() {
            const tbody = document.getElementById('examApprovedBody');
            try {
                const token = getExamAuthToken();
                console.log('ðŸ“‹ [EXAM-VAL] Loading APPROVED... authToken:', token ? 'OK' : 'MISSING');
                if (!token) {
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center text-danger py-4"><i class="bi bi-exclamation-triangle"></i> Token autentikasi tidak ditemukan.</td></tr>';
                    return;
                }
                const res = await fetch('/admin/exam-submissions?status=APPROVED', {
                    headers: { 'Authorization': 'Bearer ' + token }
                });
                if (!res.ok) throw new Error('HTTP ' + res.status);
                const data = await res.json();
                
                document.getElementById('examApprovedCount').textContent = data.length;
                
                if (!data.length) {
                    tbody.innerHTML = '<tr><td colspan="8" class="text-center text-muted py-4"><i class="bi bi-inbox"></i> Belum ada ujian yang divalidasi</td></tr>';
                    return;
                }
                
                tbody.innerHTML = data.map((item, i) => {
                    const photoUrl = item.proofPhotoPath ? '/api/files/show?path=' + encodeURIComponent(item.proofPhotoPath.replace(/^\//, '')) : '';
                    return `
                    <tr>
                        <td class="text-center">${i + 1}</td>
                        <td><strong>${item.studentName || '-'}</strong></td>
                        <td><small>${item.studentEmail || '-'}</small></td>
                        <td class="text-center"><span class="badge bg-success">${item.gformScore != null ? item.gformScore : '-'}</span></td>
                        <td class="text-center">
                            <code style="font-size:11px;">${item.generatedToken || '-'}</code>
                        </td>
                        <td class="text-center">
                            ${photoUrl 
                                ? '<img src="' + photoUrl + '" style="width:50px;height:50px;object-fit:cover;border-radius:6px;cursor:pointer;border:2px solid #27ae60;" onclick="viewExamDetail(' + item.id + ', ' + item.studentId + ')" />' 
                                : '<span class="badge bg-secondary">-</span>'}
                        </td>
                        <td><small>${item.submissionDate ? new Date(item.submissionDate).toLocaleDateString('id-ID', {day:'2-digit',month:'short',year:'numeric'}) : '-'}</small></td>
                        <td>
                            <button class="btn btn-sm btn-outline-primary" onclick="viewExamDetail(${item.id}, ${item.studentId})">
                                <i class="bi bi-eye"></i> Detail
                            </button>
                        </td>
                    </tr>
                `}).join('');
                
                console.log('âœ… [EXAM-VAL] Loaded', data.length, 'approved exam submissions');
            } catch (error) {
                console.error('âŒ [EXAM-VAL] Error loading approved:', error);
                tbody.innerHTML = '<tr><td colspan="8" class="text-center text-danger py-4"><i class="bi bi-exclamation-triangle"></i> Gagal memuat data: ' + error.message + '</td></tr>';
            }
        }

        async function approveExamSubmission(examId, studentName) {
            const notes = prompt(`Terima ujian dari "${studentName}"?\n\nCatatan admin (opsional):`);
            if (notes === null) return; // cancelled
            
            try {
                const res = await fetch(`/admin/exam-submissions/${examId}/validate`, {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + getExamAuthToken(),
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ action: 'APPROVE', adminNotes: notes || '' })
                });
                
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || 'Gagal menerima ujian');
                
                alert('âœ… Ujian dari "' + studentName + '" berhasil diterima!');
                loadPendingExamSubmissions();
                loadApprovedExamSubmissions();
            } catch (error) {
                alert('âŒ Gagal: ' + error.message);
            }
        }

        async function rejectExamSubmission(examId, studentName) {
            const notes = prompt(`Tolak ujian dari "${studentName}"?\n\nAlasan penolakan (wajib):`);
            if (notes === null) return; // cancelled
            if (!notes.trim()) {
                alert('âš ï¸ Alasan penolakan wajib diisi!');
                return;
            }
            
            try {
                const res = await fetch(`/admin/exam-submissions/${examId}/validate`, {
                    method: 'POST',
                    headers: { 
                        'Authorization': 'Bearer ' + getExamAuthToken(),
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ action: 'REJECT', adminNotes: notes })
                });
                
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || 'Gagal menolak ujian');
                
                alert('âœ… Ujian dari "' + studentName + '" ditolak.');
                loadPendingExamSubmissions();
                loadRejectedExamSubmissions();
            } catch (error) {
                alert('âŒ Gagal: ' + error.message);
            }
        }

        async function viewExamDetail(examId, studentId) {
            try {
                const res = await fetch(`/admin/exam-submissions/${examId}`, {
                    headers: { 'Authorization': 'Bearer ' + getExamAuthToken() }
                });
                if (!res.ok) throw new Error('HTTP ' + res.status);
                const d = await res.json();
                
                let photoHtml = '';
                if (d.proofPhotoPath) {
                    const cleanPath = encodeURIComponent(d.proofPhotoPath.replace(/^\//, ''));
                    photoHtml = `
                        <div style="margin-top:15px;">
                            <strong>Bukti Foto Ujian:</strong><br>
                            <img src="/api/files/show?path=${cleanPath}" 
                                 style="width:100%; max-height:500px; border-radius:8px; cursor:pointer; border:2px solid #27ae60; object-fit:contain; margin-top:8px;"
                                 onclick="window.open(this.src, '_blank')" alt="Bukti Ujian" />
                        </div>`;
                } else {
                    photoHtml = '<div style="margin-top:15px;"><strong>Bukti Foto:</strong> <span class="text-muted">(tidak ada)</span></div>';
                }
                
                const detailHtml = `
                    <div style="padding:20px;">
                        <h5 style="border-bottom:2px solid #27ae60; padding-bottom:10px; color:#1a472a;">
                            <i class="bi bi-file-earmark-check"></i> Detail Ujian - ${d.studentName || '-'}
                        </h5>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <p><strong>Email:</strong> ${d.studentEmail || '-'}</p>
                                <p><strong>Nilai GForm:</strong> <span class="badge bg-primary">${d.gformScore != null ? d.gformScore : '-'}</span></p>
                                <p><strong>Token Input:</strong> <code>${d.studentInputToken || '-'}</code></p>
                                <p><strong>Token Generated:</strong> <code>${d.generatedToken || '-'}</code></p>
                            </div>
                            <div class="col-md-6">
                                <p><strong>Token Valid:</strong> ${d.tokenValidated ? '<span class="badge bg-success">Valid</span>' : '<span class="badge bg-danger">Invalid</span>'}</p>
                                <p><strong>Status:</strong> <span class="badge ${d.validationStatus === 'APPROVED' ? 'bg-success' : d.validationStatus === 'REJECTED' ? 'bg-danger' : 'bg-warning text-dark'}">${d.validationStatus || 'PENDING'}</span></p>
                                <p><strong>Tanggal Submit:</strong> ${d.submissionDate ? new Date(d.submissionDate).toLocaleDateString('id-ID', {day:'2-digit',month:'long',year:'numeric',hour:'2-digit',minute:'2-digit'}) : '-'}</p>
                                <p><strong>Catatan Admin:</strong> ${d.adminNotes || '-'}</p>
                            </div>
                        </div>
                        ${photoHtml}
                    </div>`;
                
                // Ensure modal exists (created dynamically by other code)
                if (typeof createDetailsModal === 'function') createDetailsModal();
                document.getElementById('detailsModalBody').innerHTML = detailHtml;
                const modal = new bootstrap.Modal(document.getElementById('detailsModal'));
                modal.show();
            } catch (error) {
                console.error('âŒ [EXAM-DETAIL] Error:', error);
                alert('Gagal membuka detail ujian: ' + error.message);
            }
        }

        console.log('âœ… [VALIDASI UJIAN] Functions loaded');

        console.log('âœ… [FINAL] All scripts loaded. Functions should be available on window.');
        console.log('ðŸ“Š [SUMMARY] Functions registered:');
        console.log('   - openDetailModal:', typeof window.openDetailModal === 'function' ? 'âœ… READY' : 'âŒ NOT FOUND');
        console.log('   - safeSetText:', typeof window.safeSetText === 'function' ? 'âœ… READY' : 'âŒ NOT FOUND');
        console.log('   - safeSetHtml:', typeof window.safeSetHtml === 'function' ? 'âœ… READY' : 'âŒ NOT FOUND');
        console.log('   - approveForm:', typeof window.approveForm === 'function' ? 'âœ… READY' : 'âŒ NOT FOUND');
    
