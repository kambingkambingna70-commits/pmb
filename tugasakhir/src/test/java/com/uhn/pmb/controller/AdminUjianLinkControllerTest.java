package com.uhn.pmb.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.uhn.pmb.dto.UjianLinkRequest;
import com.uhn.pmb.entity.GelombangLinkUjian;
import com.uhn.pmb.service.AdminUjianLinkService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.MediaType;
import org.springframework.security.core.Authentication;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
class AdminUjianLinkControllerTest {

    @Mock
    private AdminUjianLinkService adminUjianLinkService;

    @InjectMocks
    private AdminUjianLinkController adminUjianLinkController;

    private MockMvc mockMvc;
    private ObjectMapper objectMapper = new ObjectMapper();
    private Authentication auth;

    @BeforeEach
    void setUp() {
        mockMvc = MockMvcBuilders.standaloneSetup(adminUjianLinkController).build();
        auth = mock(Authentication.class);
        lenient().when(auth.isAuthenticated()).thenReturn(true);
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links - returns all links")
    void getAllLinks_returns200() throws Exception {
        GelombangLinkUjian link = new GelombangLinkUjian();
        when(adminUjianLinkService.getAllLinks()).thenReturn(List.of(link));

        mockMvc.perform(get("/admin/api/ujian-links").principal(auth))
                .andExpect(status().isOk());
        verify(adminUjianLinkService).getAllLinks();
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links/by-period/{periodId} - found returns 200")
    void getByPeriodId_found_returns200() throws Exception {
        GelombangLinkUjian link = new GelombangLinkUjian();
        when(adminUjianLinkService.getByPeriodId(1L)).thenReturn(Optional.of(link));

        mockMvc.perform(get("/admin/api/ujian-links/by-period/1").principal(auth))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links/by-period/{periodId} - not found returns 404")
    void getByPeriodId_notFound_returns404() throws Exception {
        when(adminUjianLinkService.getByPeriodId(999L)).thenReturn(Optional.empty());

        mockMvc.perform(get("/admin/api/ujian-links/by-period/999").principal(auth))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links - creates link successfully")
    void createLink_success_returns200() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setLinkUjian("https://forms.google.com/abc");
        GelombangLinkUjian link = new GelombangLinkUjian();
        when(adminUjianLinkService.createLink(any())).thenReturn(link);

        mockMvc.perform(post("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links - duplicate returns 400")
    void createLink_duplicate_returns400() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setLinkUjian("https://forms.google.com/abc");
        when(adminUjianLinkService.createLink(any())).thenThrow(
                new RuntimeException("Ujian link already exists for this period"));

        mockMvc.perform(post("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PUT /admin/api/ujian-links - updates link")
    void updateLink_returns200() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setLinkUjian("https://forms.google.com/new");
        GelombangLinkUjian link = new GelombangLinkUjian();
        when(adminUjianLinkService.updateLink(any())).thenReturn(link);

        mockMvc.perform(put("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("PUT /admin/api/ujian-links - RuntimeException returns 400")
    void updateLink_runtimeException_returns400() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setLinkUjian("https://forms.google.com/new");
        lenient().when(adminUjianLinkService.updateLink(any())).thenThrow(new RuntimeException("Link not found"));

        mockMvc.perform(put("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/{periodId} - success returns 200")
    void deleteLink_success_returns200() throws Exception {
        lenient().doNothing().when(adminUjianLinkService).deleteByPeriodId(1L);

        mockMvc.perform(delete("/admin/api/ujian-links/1").principal(auth))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/{periodId} - RuntimeException returns 400")
    void deleteLink_runtimeException_returns400() throws Exception {
        lenient().doThrow(new RuntimeException("Not found")).when(adminUjianLinkService).deleteByPeriodId(999L);

        mockMvc.perform(delete("/admin/api/ujian-links/999").principal(auth))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links - Exception (not RuntimeException) returns 500")
    void createLink_checkedException_returns500() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setLinkUjian("https://forms.google.com/abc");
        lenient().when(adminUjianLinkService.createLink(any())).thenAnswer(i -> {
            throw new Exception("Unexpected error");
        });

        mockMvc.perform(post("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isInternalServerError());
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links - empty list returns 200")
    void getAllLinks_empty_returns200() throws Exception {
        when(adminUjianLinkService.getAllLinks()).thenReturn(List.of());

        mockMvc.perform(get("/admin/api/ujian-links").principal(auth))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links/by-period/{periodId} - with empty optional")
    void getByPeriodId_nullResult_returns404() throws Exception {
        when(adminUjianLinkService.getByPeriodId(999L)).thenReturn(Optional.empty());

        mockMvc.perform(get("/admin/api/ujian-links/by-period/999").principal(auth))
                .andExpect(status().isNotFound());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links - duplicate error handling")
    void createLink_duplicate_errorHandling() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setLinkUjian("https://forms.google.com/dup");
        
        when(adminUjianLinkService.createLink(any())).thenThrow(new RuntimeException("Duplicate"));

        mockMvc.perform(post("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("PUT /admin/api/ujian-links - update with error")
    void updateLink_withError() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setLinkUjian("https://forms.google.com/updated");
        
        when(adminUjianLinkService.updateLink(any())).thenThrow(new RuntimeException("Not found"));

        mockMvc.perform(put("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/{periodId} - success")
    void deleteLink_success() throws Exception {
        doNothing().when(adminUjianLinkService).deleteByPeriodId(1L);

        mockMvc.perform(delete("/admin/api/ujian-links/1").principal(auth))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links/offline-exams - success")
    void createOfflineExam_success_returns200() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setExamDate("2024-12-25");
        req.setLinkUjian("https://exam.example.com");
        
        when(adminUjianLinkService.createOfflineExam(any())).thenReturn(new GelombangLinkUjian());

        mockMvc.perform(post("/admin/api/ujian-links/offline-exams").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/offline-exams/{periodId} - success")
    void deleteOfflineExam_success_returns200() throws Exception {
        doNothing().when(adminUjianLinkService).deleteOfflineExam(1L);

        mockMvc.perform(delete("/admin/api/ujian-links/offline-exams/1").principal(auth))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links/offline-exams - with runtime exception")
    void createOfflineExam_withRuntimeException() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        req.setExamDate("2024-12-25");
        
        when(adminUjianLinkService.createOfflineExam(any())).thenThrow(new RuntimeException("Already exists"));

        mockMvc.perform(post("/admin/api/ujian-links/offline-exams").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/offline-exams/{periodId} - with error")
    void deleteOfflineExam_withError() throws Exception {
        lenient().doThrow(new RuntimeException("Not found")).when(adminUjianLinkService).deleteOfflineExam(999L);

        mockMvc.perform(delete("/admin/api/ujian-links/offline-exams/999").principal(auth))
                .andExpect(status().isBadRequest());
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links - with authentication")
    void getAllLinks_withAuth_returns200() throws Exception {
        GelombangLinkUjian link1 = new GelombangLinkUjian();
        link1.setId(1L);
        GelombangLinkUjian link2 = new GelombangLinkUjian();
        link2.setId(2L);
        when(adminUjianLinkService.getAllLinks()).thenReturn(List.of(link1, link2));

        mockMvc.perform(get("/admin/api/ujian-links").principal(auth))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.success").value(true));
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links/by-period/{periodId} - with valid period")
    void getByPeriodId_found_returnsData() throws Exception {
        GelombangLinkUjian link = new GelombangLinkUjian();
        link.setId(1L);
        when(adminUjianLinkService.getByPeriodId(5L)).thenReturn(Optional.of(link));

        mockMvc.perform(get("/admin/api/ujian-links/by-period/5").principal(auth))
                .andExpect(status().isOk());
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links - null auth returns 401")
    void getAllLinks_nullAuth_returns401() throws Exception {
        mockMvc.perform(get("/admin/api/ujian-links"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links/by-period/{periodId} - null auth returns 401")
    void getByPeriodId_nullAuth_returns401() throws Exception {
        mockMvc.perform(get("/admin/api/ujian-links/by-period/1"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links - null auth returns 401")
    void createLink_nullAuth_returns401() throws Exception {
        mockMvc.perform(post("/admin/api/ujian-links")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{}"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("PUT /admin/api/ujian-links - null auth returns 401")
    void updateLink_nullAuth_returns401() throws Exception {
        mockMvc.perform(put("/admin/api/ujian-links")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{}"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/{periodId} - null auth returns 401")
    void deleteLink_nullAuth_returns401() throws Exception {
        mockMvc.perform(delete("/admin/api/ujian-links/1"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links/offline-exams - null auth returns 401")
    void createOfflineExam_nullAuth_returns401() throws Exception {
        mockMvc.perform(post("/admin/api/ujian-links/offline-exams")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content("{}"))
                .andExpect(status().isUnauthorized());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/offline-exams/{periodId} - null auth returns 401")
    void deleteOfflineExam_nullAuth_returns401() throws Exception {
        mockMvc.perform(delete("/admin/api/ujian-links/offline-exams/1"))
                .andExpect(status().isUnauthorized());
    }

    // ===== Checked Exception (non-RuntimeException) → 500 paths =====

    @Test
    @DisplayName("GET /admin/api/ujian-links - Exception returns 500")
    void getAllLinks_checkedException_returns500() throws Exception {
        when(adminUjianLinkService.getAllLinks()).thenAnswer(i -> { throw new Exception("DB failure"); });

        mockMvc.perform(get("/admin/api/ujian-links").principal(auth))
                .andExpect(status().isInternalServerError());
    }

    @Test
    @DisplayName("GET /admin/api/ujian-links/by-period/{periodId} - Exception returns 500")
    void getByPeriodId_checkedException_returns500() throws Exception {
        when(adminUjianLinkService.getByPeriodId(1L)).thenAnswer(i -> { throw new Exception("DB failure"); });

        mockMvc.perform(get("/admin/api/ujian-links/by-period/1").principal(auth))
                .andExpect(status().isInternalServerError());
    }

    @Test
    @DisplayName("PUT /admin/api/ujian-links - Exception returns 500")
    void updateLink_checkedException_returns500() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        when(adminUjianLinkService.updateLink(any())).thenAnswer(i -> { throw new Exception("Unexpected"); });

        mockMvc.perform(put("/admin/api/ujian-links").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isInternalServerError());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/{periodId} - Exception returns 500")
    void deleteLink_checkedException_returns500() throws Exception {
        doAnswer(i -> { throw new Exception("Unexpected"); }).when(adminUjianLinkService).deleteByPeriodId(any());

        mockMvc.perform(delete("/admin/api/ujian-links/1").principal(auth))
                .andExpect(status().isInternalServerError());
    }

    @Test
    @DisplayName("POST /admin/api/ujian-links/offline-exams - Exception returns 500")
    void createOfflineExam_checkedException_returns500() throws Exception {
        UjianLinkRequest req = new UjianLinkRequest();
        req.setPeriodId(1L);
        when(adminUjianLinkService.createOfflineExam(any())).thenAnswer(i -> { throw new Exception("Unexpected"); });

        mockMvc.perform(post("/admin/api/ujian-links/offline-exams").principal(auth)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isInternalServerError());
    }

    @Test
    @DisplayName("DELETE /admin/api/ujian-links/offline-exams/{periodId} - Exception returns 500")
    void deleteOfflineExam_checkedException_returns500() throws Exception {
        doAnswer(i -> { throw new Exception("Unexpected"); }).when(adminUjianLinkService).deleteOfflineExam(any());

        mockMvc.perform(delete("/admin/api/ujian-links/offline-exams/1").principal(auth))
                .andExpect(status().isInternalServerError());
    }
}
