package com.uhn.pmb.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.AuthenticationException;

import java.io.IOException;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(MockitoExtension.class)
class JwtAuthenticationEntryPointTest {

    @InjectMocks
    private JwtAuthenticationEntryPoint entryPoint;

    @Test
    @DisplayName("commence - API request returns JSON 401 response")
    void commence_apiRequest_returns401Json() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/api/auth/me");
        MockHttpServletResponse response = new MockHttpServletResponse();
        AuthenticationException ex = new BadCredentialsException("Invalid credentials");

        entryPoint.commence(request, response, ex);

        assertThat(response.getStatus()).isEqualTo(401);
        assertThat(response.getContentType()).contains("application/json");
        assertThat(response.getContentAsString()).contains("UNAUTHORIZED");
    }

    @Test
    @DisplayName("commence - HTML page request redirects to login")
    void commence_htmlPageRequest_redirectsToLogin() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/admin/dashboard.html");
        request.addHeader("Accept", "text/html,application/xhtml+xml");
        MockHttpServletResponse response = new MockHttpServletResponse();
        AuthenticationException ex = new InsufficientAuthenticationException("Auth required");

        entryPoint.commence(request, response, ex);

        assertThat(response.getRedirectedUrl()).isEqualTo("/login.html");
    }

    @Test
    @DisplayName("commence - BadCredentialsException returns invalid credentials message")
    void commence_badCredentials_returnsInvalidMessage() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/api/test");
        MockHttpServletResponse response = new MockHttpServletResponse();
        AuthenticationException ex = new BadCredentialsException("Bad creds");

        entryPoint.commence(request, response, ex);

        assertThat(response.getStatus()).isEqualTo(401);
        assertThat(response.getContentAsString()).contains("Invalid credentials");
    }

    @Test
    @DisplayName("commence - InsufficientAuthenticationException returns auth required message")
    void commence_insufficientAuth_returnsAuthRequired() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/api/test");
        MockHttpServletResponse response = new MockHttpServletResponse();
        AuthenticationException ex = new InsufficientAuthenticationException("Need auth");

        entryPoint.commence(request, response, ex);

        assertThat(response.getStatus()).isEqualTo(401);
        assertThat(response.getContentAsString()).contains("Authentication required");
    }

    @Test
    @DisplayName("commence - public page request returns 401 JSON without redirect")
    void commence_publicPage_returns401WithoutRedirect() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/login.html");
        MockHttpServletResponse response = new MockHttpServletResponse();
        AuthenticationException ex = new InsufficientAuthenticationException("Need auth");

        entryPoint.commence(request, response, ex);

        assertThat(response.getStatus()).isEqualTo(401);
        assertThat(response.getRedirectedUrl()).isNull();
    }

    @Test
    @DisplayName("commence - generic AuthenticationException returns exception message")
    void commence_genericException_returnsExceptionMessage() throws Exception {
        MockHttpServletRequest request = new MockHttpServletRequest("GET", "/api/data");
        MockHttpServletResponse response = new MockHttpServletResponse();
        AuthenticationException ex = new AuthenticationException("Custom error") {};

        entryPoint.commence(request, response, ex);

        assertThat(response.getStatus()).isEqualTo(401);
        assertThat(response.getContentAsString()).contains("Custom error");
    }
}
