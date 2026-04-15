package com.whitestork.biometric.user.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.time.OffsetDateTime;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import lombok.With;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

@Slf4j
@With
@Table("users")
public record User(
    @Id
    @Nullable Long id,
    @NonNull String email,
    @NonNull Boolean emailVerified,
    @NonNull String passwordHash,
    @Column("role")
    @NonNull Integer roleId,
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
        UserRole.USER.id(),
        null,
        null
    );
  }

  public @NonNull Long savedId() {
    if (id == null) {
      log.error("Пользователь без ID");
      throw new DomainException("Что-то пошло не так");
    }

    return id;
  }

  public @NonNull UserRole role() {
    return UserRole.fromId(roleId);
  }

  // Security

  public boolean isAdmin() {
    return UserRole.ADMIN.id() == roleId;
  }

  public boolean isModerator() {
    return UserRole.MODERATOR.id() == roleId;
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
    return List.of(new SimpleGrantedAuthority(role().fullName()));
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
        "role", roleId
    );
  }

  @Override
  public @NonNull String getName() {
    return email;
  }
}
