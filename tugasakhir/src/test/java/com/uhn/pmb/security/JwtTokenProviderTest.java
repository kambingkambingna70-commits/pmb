package com.uhn.pmb.security;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.test.util.ReflectionTestUtils;

import java.util.Collection;
import java.util.Collections;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class JwtTokenProviderTest {

    @InjectMocks
    private JwtTokenProvider jwtTokenProvider;

    private static final String SECRET = "supersecretjwtkeyforhkbpnommensenpmbsystem1234567890abcdefghijklmnopqrstuvwxyz";
    private static final long EXPIRATION = 86400000L;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(jwtTokenProvider, "jwtSecret", SECRET);
        ReflectionTestUtils.setField(jwtTokenProvider, "jwtExpirationMs", EXPIRATION);
    }

    @Test
    @DisplayName("generateToken - should generate valid token from authentication")
    void generateToken_validAuthentication_returnsToken() {
        Authentication auth = mock(Authentication.class);
        when(auth.getName()).thenReturn("test@example.com");
        Collection<GrantedAuthority> authorities = Collections.emptyList();
        doReturn(authorities).when(auth).getAuthorities();

        String token = jwtTokenProvider.generateToken(auth);

        assertThat(token).isNotNull().isNotEmpty();
    }

    @Test
    @DisplayName("generateTokenFromEmail - should generate valid token for email")
    void generateTokenFromEmail_validEmail_returnsToken() {
        String token = jwtTokenProvider.generateTokenFromEmail("user@test.com");
        assertThat(token).isNotNull().isNotEmpty();
    }

    @Test
    @DisplayName("generateTokenFromEmailWithAuthorities - with authority returns token")
    void generateTokenFromEmailWithAuthorities_withRole_returnsToken() {
        String token = jwtTokenProvider.generateTokenFromEmailWithAuthorities("admin@test.com", "ROLE_ADMIN");
        assertThat(token).isNotNull().isNotEmpty();
    }

    @Test
    @DisplayName("getEmailFromToken - should extract email from valid token")
    void getEmailFromToken_validToken_returnsEmail() {
        String token = jwtTokenProvider.generateTokenFromEmail("user@test.com");
        String email = jwtTokenProvider.getEmailFromToken(token);
        assertThat(email).isEqualTo("user@test.com");
    }

    @Test
    @DisplayName("getEmailFromToken - invalid token returns null")
    void getEmailFromToken_invalidToken_returnsNull() {
        String email = jwtTokenProvider.getEmailFromToken("invalid.token.here");
        assertThat(email).isNull();
    }

    @Test
    @DisplayName("validateToken - valid token returns true")
    void validateToken_validToken_returnsTrue() {
        String token = jwtTokenProvider.generateTokenFromEmail("user@test.com");
        Boolean valid = jwtTokenProvider.validateToken(token);
        assertThat(valid).isTrue();
    }

    @Test
    @DisplayName("validateToken - invalid token returns false")
    void validateToken_invalidToken_returnsFalse() {
        Boolean valid = jwtTokenProvider.validateToken("not.a.valid.token");
        assertThat(valid).isFalse();
    }

    @Test
    @DisplayName("generateToken - null secret throws exception")
    void generateTokenFromEmail_nullSecret_throwsException() {
        ReflectionTestUtils.setField(jwtTokenProvider, "jwtSecret", null);
        assertThatThrownBy(() -> jwtTokenProvider.generateTokenFromEmail("user@test.com"))
                .isInstanceOf(RuntimeException.class);
    }

    @Test
    @DisplayName("getAuthoritiesFromToken - returns authorities from token")
    void getAuthoritiesFromToken_tokenWithAuthority_returnsAuthority() {
        String token = jwtTokenProvider.generateTokenFromEmailWithAuthorities("user@test.com", "ROLE_CAMABA");
        String authorities = jwtTokenProvider.getAuthoritiesFromToken(token);
        assertThat(authorities).isEqualTo("ROLE_CAMABA");
    }

    @Test
    @DisplayName("getAuthoritiesFromToken - token without authority returns empty string")
    void getAuthoritiesFromToken_tokenWithoutAuthority_returnsEmpty() {
        String token = jwtTokenProvider.generateTokenFromEmail("user@test.com");
        String authorities = jwtTokenProvider.getAuthoritiesFromToken(token);
        assertThat(authorities).isEmpty();
    }
}
