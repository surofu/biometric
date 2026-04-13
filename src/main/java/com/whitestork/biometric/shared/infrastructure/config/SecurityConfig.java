package com.whitestork.biometric.shared.infrastructure.config;

import com.whitestork.biometric.user.infrastructure.security.CustomOAuth2UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.Duration;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.argon2.Argon2PasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.TokenBasedRememberMeServices;
import org.springframework.security.web.context.DelegatingSecurityContextRepository;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.context.RequestAttributeSecurityContextRepository;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.security.web.csrf.CsrfToken;
import org.springframework.security.web.csrf.XorCsrfTokenRequestAttributeHandler;
import org.springframework.session.jdbc.config.annotation.web.http.EnableJdbcHttpSession;
import org.springframework.session.web.http.DefaultCookieSerializer;
import org.springframework.web.filter.OncePerRequestFilter;

@Slf4j
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@EnableJdbcHttpSession
@RequiredArgsConstructor
public class SecurityConfig {
  private static final String SESSION_COOKIE = "BIOMETRIC_SESSION_ID";
  private static final String REMEMBER_ME_COOKIE = "BIOMETRIC_REMEMBER_ME";
  private static final String CSRF_COOKIE = "BIOMETRIC-XSRF-TOKEN";
  private final UserDetailsService userDetailsService;
  private final CustomOAuth2UserService customOAuth2UserService;

  @Value("${spring.session.timeout}")
  private Duration sessionTimeout;
  @Value("${spring.session.cookie.remember-me-key}")
  private String rememberMeKey;

  @Bean
  public SecurityFilterChain securityFilterChain(HttpSecurity http) {
    return http
        .authorizeHttpRequests(auth -> auth
            .requestMatchers(
                "/", "/about",
                "/login", "/register", "/verify-email", "/email-sent",
                "/css/**", "/js/**",
                "/favicon.svg", "/favicon.ico",
                "/favicon-96x96.png", "/apple-touch-icon.png",
                "/site.webmanifest", "/manifest.json",
                "/web-app-manifest-192x192.png",
                "/web-app-manifest-512x512.png",
                "/service-worker.js",
                "/.well-known/appspecific/com.chrome.devtools.json"
            ).permitAll()
            .anyRequest().authenticated()
        )
        .oauth2Login(oauth2 -> oauth2
            .loginPage("/login")
            .defaultSuccessUrl("/", true)
            .failureUrl("/login?error=true")
            .userInfoEndpoint(userInfo -> userInfo
                .userService(customOAuth2UserService)
            )
        )
        .formLogin(form -> form
            .loginPage("/login")
            .loginProcessingUrl("/login")
            .usernameParameter("email")
            .passwordParameter("password")
            .successHandler(successHandler())
            .failureUrl("/login?error=true")
            .failureHandler(authenticationFailureHandler())
            .permitAll()
        )
        .rememberMe(remember -> remember
            .key(rememberMeKey)
            .rememberMeParameter("rememberMe")
            .tokenValiditySeconds((int) sessionTimeout.toSeconds())
            .userDetailsService(userDetailsService)
            .rememberMeServices(rememberMeServices())
        )
        .logout(logout -> logout
            .logoutUrl("/logout")
            .logoutSuccessUrl("/login?logout=true")
            .deleteCookies(SESSION_COOKIE, REMEMBER_ME_COOKIE)
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
            .csrfTokenRepository(cookieCsrfTokenRepository())
            .csrfTokenRequestHandler(xorHandler())
        )
        .addFilterAfter(csrfCookieFilter(), CsrfFilter.class)
        .build();
  }

  @Bean
  public RememberMeServices rememberMeServices() {
    TokenBasedRememberMeServices services = new TokenBasedRememberMeServices(
        rememberMeKey,
        userDetailsService
    );
    services.setParameter("rememberMe");
    services.setCookieName(REMEMBER_ME_COOKIE);
    services.setTokenValiditySeconds((int) sessionTimeout.toSeconds());
    services.setAlwaysRemember(true);
    return services;
  }

  @Bean
  public SavedRequestAwareAuthenticationSuccessHandler successHandler() {
    SavedRequestAwareAuthenticationSuccessHandler handler =
        new SavedRequestAwareAuthenticationSuccessHandler();
    handler.setDefaultTargetUrl("/");
    return handler;
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

  @Bean
  public AuthenticationFailureHandler authenticationFailureHandler() {
    return (request, response, exception) -> {
      String message = exception.getCause() instanceof DisabledException
          ? "Этот аккаунт зарегистрирован через Google. Используйте кнопку «Войти через Google»"
          : "Неверный email или пароль";
      request.getSession().setAttribute("errorMessage", message);
      response.sendRedirect("/login?error=true");
    };
  }

  @Bean
  public XorCsrfTokenRequestAttributeHandler xorHandler() {
    XorCsrfTokenRequestAttributeHandler xorHandler = new XorCsrfTokenRequestAttributeHandler();
    xorHandler.setCsrfRequestAttributeName("_csrf");
    return xorHandler;
  }

  @Bean
  public CookieCsrfTokenRepository cookieCsrfTokenRepository() {
    CookieCsrfTokenRepository repository = CookieCsrfTokenRepository.withHttpOnlyFalse();
    repository.setCookieName(CSRF_COOKIE);
    repository.setCookieCustomizer(cookie -> cookie
        .maxAge(Duration.ofDays(1))
        .path("/")
        .sameSite("Lax")
    );
    return repository;
  }

  @Bean
  public OncePerRequestFilter csrfCookieFilter() {
    return new OncePerRequestFilter() {
      @Override
      protected void doFilterInternal(
          @NonNull HttpServletRequest request,
          @NonNull HttpServletResponse response,
          @NonNull FilterChain filterChain
      ) throws ServletException, IOException {
        CsrfToken csrfToken = (CsrfToken) request.getAttribute(CsrfToken.class.getName());
        if (csrfToken != null) {
          csrfToken.getToken();
        }
        filterChain.doFilter(request, response);
      }
    };
  }

  @Bean
  public DefaultCookieSerializer cookieSerializer() {
    DefaultCookieSerializer serializer = new DefaultCookieSerializer();
    serializer.setCookieName(SESSION_COOKIE);
    serializer.setCookiePath("/");
    serializer.setSameSite("Lax");
    serializer.setUseHttpOnlyCookie(true);
    return serializer;
  }
}