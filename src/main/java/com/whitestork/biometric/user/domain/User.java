package com.whitestork.biometric.user.domain;

import java.time.OffsetDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import lombok.With;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.relational.core.mapping.Table;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

@With
@Table("users")
public record User(
    @Id
    @Nullable Long id,
    @NonNull String email,
    @NonNull Boolean emailVerified,
    @NonNull String passwordHash,
    @NonNull UserRole role,
    @CreatedDate
    @Nullable OffsetDateTime registeredAt,
    @LastModifiedDate
    @Nullable OffsetDateTime updatedAt

) implements UserDetails, OAuth2User {
  public static User defaultUser(@NonNull String email, @NonNull String passwordHash) {
    return User.build(email, false, passwordHash);
  }

  public static User verifiedByGoogle(@NonNull String email) {
    return User.build(email, true, "");
  }

  private static User build(
      @NonNull String email,
      @NonNull Boolean emailVerified,
      @NonNull String passwordHash
  ) {
    return new User(
        null,
        email,
        emailVerified,
        passwordHash,
        UserRole.USER,
        null,
        null
    );
  }

  // Security

  public boolean isAdmin() {
    return role == UserRole.ADMIN;
  }

  public boolean isModerator() {
    return role == UserRole.MODERATOR;
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
    return List.of(new SimpleGrantedAuthority(role.fullName()));
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
        "email", email,
        "role", role.name()
    );
  }

  @Override
  public @NonNull String getName() {
    return email;
  }
}
