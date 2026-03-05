package com.whitestork.biometric.user.domain;

import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("users")
public record User(
    @Id
    @Nullable
    Long id,
    @NonNull
    String email,
    @NonNull
    String passwordHash
) {
  public User(@NonNull String email, @NonNull String passwordHash) {
    this(null, email, passwordHash);
  }
}
