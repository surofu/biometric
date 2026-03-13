package com.whitestork.biometric.user.infrastructure.security;

import com.whitestork.biometric.user.domain.User;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import org.jspecify.annotations.NonNull;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

public record SecurityUser(
    @NonNull String email,
    @NonNull Boolean emailVerified,
    @NonNull String passwordHash
) implements UserDetails, OAuth2User {

  public SecurityUser(User user) {
    this(user.email(), user.emailVerified(), user.passwordHash());
  }

  @Override
  public @NonNull String getUsername() {
    return email;
  }

  @Override
  public @NonNull String getPassword() {
    return passwordHash;
  }

  @Override
  public @NonNull Collection<? extends GrantedAuthority> getAuthorities() {
    return List.of();
  }

  @Override
  public boolean isAccountNonExpired() {
    return true;
  }

  @Override
  public boolean isAccountNonLocked() {
    return true;
  }

  @Override
  public boolean isCredentialsNonExpired() {
    return true;
  }

  @Override
  public boolean isEnabled() {
    return emailVerified;
  }

  @Override
  public Map<String, Object> getAttributes() {
    return Map.of(
        "email", email
    );
  }

  @Override
  public @NonNull String getName() {
    return email;
  }
}
