package com.whitestork.biometric.user.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.util.Arrays;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Accessors;
import org.jspecify.annotations.NonNull;

@Getter
@RequiredArgsConstructor
@Accessors(fluent = true)
public enum UserRole {
  ADMIN(10, "Администратор"),
  MODERATOR(20, "Модератор"),
  USER(30, "Пользователь");

  private final int id;
  private final String description;

  public static UserRole fromId(int id) {
    return Arrays.stream(values())
        .filter(r -> r.id() == id)
        .findFirst()
        .orElseThrow(
            () -> new DomainException("Роль пользователя с ID \"%s\" не найдена".formatted(id))
        );
  }

  public @NonNull String fullName() {
    return "ROLE_" + name();
  }
}
