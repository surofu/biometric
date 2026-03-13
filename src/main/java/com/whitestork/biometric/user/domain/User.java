package com.whitestork.biometric.user.domain;

import lombok.With;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@With
@Table("users")
public record User(
    @Id
    @Nullable Long id,
    @NonNull String email,
    @NonNull Boolean emailVerified,
    @NonNull String passwordHash

) {
  public User(@NonNull String email, @NonNull String passwordHash) {
    this(null, email, false, passwordHash);
  }

  public static User verifiedByGoogle(@NonNull String email) {
    return new User(null, email, true, "");
  }
}
