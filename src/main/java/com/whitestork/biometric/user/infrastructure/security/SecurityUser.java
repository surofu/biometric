package com.whitestork.biometric.user.infrastructure.security;

import java.util.Collection;
import java.util.List;
import org.jspecify.annotations.NonNull;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public record SecurityUser(
    String email,
    String passwordHash
) implements UserDetails {

  @NonNull
  @Override
  public String getUsername() {
    return email;
  }

  @NonNull
  @Override
  public String getPassword() {
    return passwordHash;
  }

  @NonNull
  @Override
  public Collection<? extends GrantedAuthority> getAuthorities() {
    return List.of();
  }
}
