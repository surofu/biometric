package com.whitestork.biometric.shared.infrastructure.config;

import java.time.Duration;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.TokenBasedRememberMeServices;
import org.springframework.security.web.context.DelegatingSecurityContextRepository;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.RequestAttributeSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.session.jdbc.config.annotation.web.http.EnableJdbcHttpSession;

@Configuration
@EnableMethodSecurity
@EnableJdbcHttpSession
@RequiredArgsConstructor
public class SecurityConfig {
  private final UserDetailsService userDetailsService;

  @Value("${spring.session.timeout}")
  private Duration sessionTimeout;

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) {
    return http
        .authorizeHttpRequests(auth -> auth
            .requestMatchers(
                "/",
                "/login", "/register",
                "/css/**", "/js/**",
                "/favicon.svg", "/favicon.ico",
                "/favicon-96x96.png", "/apple-touch-icon.png",
                "/site.webmanifest", "/manifest.json",
                "/web-app-manifest-192x192.png",
                "/web-app-manifest-512x512.png",
                "/service-worker.js"
            ).permitAll()
            .anyRequest().authenticated()
        )
        .formLogin(form -> form
            .loginPage("/login")
            .loginProcessingUrl("/login")
            .usernameParameter("email")
            .passwordParameter("password")
            .successHandler(successHandler())
            .failureUrl("/login?error=true")
            .permitAll()
        )
        .rememberMe(remember -> remember
            .key("uniqueAndSecret")
            .rememberMeParameter("rememberMe")
            .tokenValiditySeconds((int) sessionTimeout.toSeconds()) // Исправлено
            .userDetailsService(userDetailsService)
            .rememberMeServices(rememberMeServices()) // Явно указываем бин
        )
        .logout(logout -> logout
            .logoutUrl("/logout")
            .logoutSuccessUrl("/login?logout=true")
            .deleteCookies("JSESSIONID", "remember-me")
            .invalidateHttpSession(true)
            .clearAuthentication(true)
            .permitAll()
        )
        .sessionManagement(session -> session
            .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            .maximumSessions(10)
            .maxSessionsPreventsLogin(false)
            .expiredUrl("/login?expired=true")
        )
        .csrf(csrf -> csrf
            .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
        )
        .build();
  }

  @Bean
  public RememberMeServices rememberMeServices() {
    TokenBasedRememberMeServices services = new TokenBasedRememberMeServices(
        "uniqueAndSecret",
        userDetailsService
    );
    services.setParameter("rememberMe");
    services.setTokenValiditySeconds((int) sessionTimeout.toSeconds());
    services.setAlwaysRemember(true);
    return services;
  }

  @Bean
  public SavedRequestAwareAuthenticationSuccessHandler successHandler() {
    SavedRequestAwareAuthenticationSuccessHandler successHandler =
        new SavedRequestAwareAuthenticationSuccessHandler();
    successHandler.setDefaultTargetUrl("/");
    return successHandler;
  }

  @Bean
  public PasswordEncoder passwordEncoder() {
    return Argon2PasswordEncoder.defaultsForSpringSecurity_v5_8();
  }

  @Bean
  public AuthenticationManager authenticationManager(AuthenticationConfiguration configuration) {
    return configuration.getAuthenticationManager();
  }

  @Bean
  public SecurityContextRepository securityContextRepository() {
    return new DelegatingSecurityContextRepository(
        new RequestAttributeSecurityContextRepository(),
        new HttpSessionSecurityContextRepository()
    );
  }
}