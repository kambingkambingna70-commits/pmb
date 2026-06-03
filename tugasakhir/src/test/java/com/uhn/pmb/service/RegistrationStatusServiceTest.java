package com.uhn.pmb.service;

import com.uhn.pmb.entity.RegistrationStatus;
import com.uhn.pmb.entity.RegistrationStatus.RegistrationStage;
import com.uhn.pmb.entity.User;
import com.uhn.pmb.repository.RegistrationStatusRepository;
import com.uhn.pmb.repository.UserRepository;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class RegistrationStatusServiceTest {

    @Mock private RegistrationStatusRepository registrationStatusRepository;
    @Mock private UserRepository userRepository;

    @InjectMocks
    private RegistrationStatusService registrationStatusService;

    private User buildUser(Long id, String email) {
        return User.builder().id(id).email(email).build();
    }

    @Test
    @DisplayName("getUserByEmail - not found throws RuntimeException")
    void getUserByEmail_notFound_throws() {
        when(userRepository.findByEmail("none@test.com")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> registrationStatusService.getUserByEmail("none@test.com"))
                .isInstanceOf(RuntimeException.class);
    }

    @Test
    @DisplayName("getUserByEmail - found returns user")
    void getUserByEmail_found_returnsUser() {
        User u = buildUser(1L, "u@test.com");
        when(userRepository.findByEmail("u@test.com")).thenReturn(Optional.of(u));

        User result = registrationStatusService.getUserByEmail("u@test.com");

        assertThat(result.getEmail()).isEqualTo("u@test.com");
    }

    @Test
    @DisplayName("getUserStatuses - returns list of statuses")
    void getUserStatuses_returnsStatuses() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder().user(u).stage(RegistrationStage.FORM_SUBMISSION).build();
        when(registrationStatusRepository.findByUserOrderByCreatedAtDesc(u)).thenReturn(List.of(rs));

        List<RegistrationStatus> result = registrationStatusService.getUserStatuses(u);

        assertThat(result).hasSize(1);
    }

    @Test
    @DisplayName("getOrCreateStatus - existing returns existing")
    void getOrCreateStatus_existing_returnsExisting() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder().user(u).stage(RegistrationStage.PAYMENT_BRIVA).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.PAYMENT_BRIVA))
                .thenReturn(Optional.of(rs));

        RegistrationStatus result = registrationStatusService.getOrCreateStatus(u, RegistrationStage.PAYMENT_BRIVA);

        assertThat(result).isNotNull();
        verify(registrationStatusRepository, never()).save(any());
    }

    @Test
    @DisplayName("getOrCreateStatus - not existing creates new")
    void getOrCreateStatus_notExisting_createsNew() {
        User u = buildUser(1L, "u@test.com");
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.PAYMENT_BRIVA))
                .thenReturn(Optional.empty());
        RegistrationStatus saved = RegistrationStatus.builder().user(u).stage(RegistrationStage.PAYMENT_BRIVA).build();
        when(registrationStatusRepository.save(any())).thenReturn(saved);

        RegistrationStatus result = registrationStatusService.getOrCreateStatus(u, RegistrationStage.PAYMENT_BRIVA);

        assertThat(result).isNotNull();
        verify(registrationStatusRepository).save(any());
    }

    @Test
    @DisplayName("markAsCompleted - creates and saves completed status")
    void markAsCompleted_savesCompletedStatus() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION)
                .status(RegistrationStatus.RegistrationStatus_Enum.MENUNGGU_VERIFIKASI)
                .editCount(0).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));
        when(registrationStatusRepository.save(any())).thenReturn(rs);

        RegistrationStatus result = registrationStatusService.markAsCompleted(u, RegistrationStage.FORM_SUBMISSION, "{\"data\":1}");

        assertThat(result.getStatus()).isEqualTo(RegistrationStatus.RegistrationStatus_Enum.SELESAI);
        verify(registrationStatusRepository).save(rs);
    }

    @Test
    @DisplayName("canUserEdit - no status returns false")
    void canUserEdit_noStatus_returnsFalse() {
        User u = buildUser(1L, "u@test.com");
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.empty());

        boolean result = registrationStatusService.canUserEdit(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isFalse();
    }

    @Test
    @DisplayName("canUserEdit - adminVerified=true returns false")
    void canUserEdit_adminVerified_returnsFalse() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION)
                .adminVerified(true).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));

        boolean result = registrationStatusService.canUserEdit(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isFalse();
    }

    @Test
    @DisplayName("canUserEdit - MENUNGGU_VERIFIKASI returns true")
    void canUserEdit_menungguVerifikasi_returnsTrue() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION)
                .adminVerified(false)
                .status(RegistrationStatus.RegistrationStatus_Enum.MENUNGGU_VERIFIKASI).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));

        boolean result = registrationStatusService.canUserEdit(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("canUserEdit - SELESAI with deadline in future returns true")
    void canUserEdit_selesaiBeforeDeadline_returnsTrue() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION)
                .adminVerified(false)
                .status(RegistrationStatus.RegistrationStatus_Enum.SELESAI)
                .editDeadline(java.time.LocalDateTime.now().plusHours(10)).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));

        boolean result = registrationStatusService.canUserEdit(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isTrue();
    }

    @Test
    @DisplayName("getEditTimeRemaining - no status returns 0")
    void getEditTimeRemaining_noStatus_returnsZero() {
        User u = buildUser(1L, "u@test.com");
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.empty());

        Long result = registrationStatusService.getEditTimeRemaining(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isEqualTo(0L);
    }

    @Test
    @DisplayName("getEditTimeRemaining - deadline in future returns positive hours")
    void getEditTimeRemaining_deadlineInFuture_returnsPositive() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .editDeadline(java.time.LocalDateTime.now().plusHours(5)).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));

        Long result = registrationStatusService.getEditTimeRemaining(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isGreaterThan(0L);
    }

    @Test
    @DisplayName("getEditTimeRemaining - deadline passed returns 0")
    void getEditTimeRemaining_deadlinePassed_returnsZero() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .editDeadline(java.time.LocalDateTime.now().minusHours(5)).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));

        Long result = registrationStatusService.getEditTimeRemaining(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isEqualTo(0L);
    }

    @Test
    @DisplayName("updateStatusData - canEdit=false throws exception")
    void updateStatusData_cannotEdit_throwsException() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION)
                .adminVerified(true).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));

        assertThatThrownBy(() -> registrationStatusService.updateStatusData(u, RegistrationStage.FORM_SUBMISSION, "{}"))
                .isInstanceOf(IllegalStateException.class)
                .hasMessageContaining("tidak bisa edit");
    }

    @Test
    @DisplayName("rejectByAdmin - status not found throws exception")
    void rejectByAdmin_notFound_throwsException() {
        User u = buildUser(1L, "u@test.com");
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> registrationStatusService.rejectByAdmin(u, RegistrationStage.FORM_SUBMISSION, "admin@test.com", "notes"))
                .isInstanceOf(IllegalStateException.class);
    }

    @Test
    @DisplayName("rejectByAdmin - sets REJECTED status and saves")
    void rejectByAdmin_setsRejectedStatus() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));
        when(registrationStatusRepository.save(any())).thenReturn(rs);

        RegistrationStatus result = registrationStatusService.rejectByAdmin(u, RegistrationStage.FORM_SUBMISSION, "admin@test.com", "tolak");

        assertThat(result.getStatus()).isEqualTo(RegistrationStatus.RegistrationStatus_Enum.REJECTED);
        assertThat(result.getCanEdit()).isFalse();
    }

    @Test
    @DisplayName("approveByAdmin - status not found throws exception")
    void approveByAdmin_notFound_throwsException() {
        User u = buildUser(1L, "u@test.com");
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> registrationStatusService.approveByAdmin(u, RegistrationStage.FORM_SUBMISSION, "admin@test.com", "ok"))
                .isInstanceOf(IllegalStateException.class);
    }

    @Test
    @DisplayName("approveByAdmin - sets adminVerified=true and saves")
    void approveByAdmin_setsAdminVerified() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION).build();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));
        when(registrationStatusRepository.save(any())).thenReturn(rs);

        RegistrationStatus result = registrationStatusService.approveByAdmin(u, RegistrationStage.FORM_SUBMISSION, "admin@test.com", "ok");

        assertThat(result.getAdminVerified()).isTrue();
        assertThat(result.getCanEdit()).isFalse();
    }

    @Test
    @DisplayName("getUserStatusesByEmail - delegates via getUserByEmail")
    void getUserStatusesByEmail_found_returnsList() {
        User u = buildUser(1L, "u@test.com");
        when(userRepository.findByEmail("u@test.com")).thenReturn(Optional.of(u));
        when(registrationStatusRepository.findByUserOrderByCreatedAtDesc(u)).thenReturn(List.of());

        List<RegistrationStatus> result = registrationStatusService.getUserStatusesByEmail("u@test.com");

        assertThat(result).isNotNull();
    }

    @Test
    @DisplayName("getStatusByEmail - found returns optional")
    void getStatusByEmail_found_returnsOptional() {
        User u = buildUser(1L, "u@test.com");
        when(userRepository.findByEmail("u@test.com")).thenReturn(Optional.of(u));
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.empty());

        Optional<RegistrationStatus> result = registrationStatusService.getStatusByEmail("u@test.com", RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("canUserEditByEmail - delegates and returns result")
    void canUserEditByEmail_delegates() {
        User u = buildUser(1L, "u@test.com");
        when(userRepository.findByEmail("u@test.com")).thenReturn(Optional.of(u));
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.empty());

        boolean result = registrationStatusService.canUserEditByEmail("u@test.com", RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isFalse();
    }

    @Test
    @DisplayName("getStatus - delegates to repository")
    void getStatus_delegatesToRepository() {
        User u = buildUser(1L, "u@test.com");
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.empty());

        Optional<RegistrationStatus> result = registrationStatusService.getStatus(u, RegistrationStage.FORM_SUBMISSION);

        assertThat(result).isEmpty();
    }

    @Test
    @DisplayName("markAsCompletedByEmail - delegates and marks as completed")
    void markAsCompletedByEmail_delegates() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = RegistrationStatus.builder()
                .user(u).stage(RegistrationStage.FORM_SUBMISSION)
                .status(RegistrationStatus.RegistrationStatus_Enum.MENUNGGU_VERIFIKASI)
                .editCount(0).build();
        when(userRepository.findByEmail("u@test.com")).thenReturn(Optional.of(u));
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.FORM_SUBMISSION))
                .thenReturn(Optional.of(rs));
        when(registrationStatusRepository.save(any())).thenReturn(rs);

        RegistrationStatus result = registrationStatusService.markAsCompletedByEmail("u@test.com", RegistrationStage.FORM_SUBMISSION, "{}");

        assertThat(result).isNotNull();
    }

    @Test
    @DisplayName("getStatus - returns optional status")
    void getStatus_found_returnsPresent() {
        User u = buildUser(1L, "u@test.com");
        RegistrationStatus rs = new RegistrationStatus();
        when(registrationStatusRepository.findByUserAndStage(u, RegistrationStage.GELOMBANG_SELECTION))
                .thenReturn(Optional.of(rs));

        Optional<RegistrationStatus> result = registrationStatusService.getStatus(u, RegistrationStage.GELOMBANG_SELECTION);

        assertThat(result).isPresent();
    }
}
