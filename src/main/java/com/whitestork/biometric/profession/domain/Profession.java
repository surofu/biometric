package com.whitestork.biometric.profession.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Slf4j
@Table("professions")
public record Profession(
    @Id
    @Nullable Long id,
    @NonNull String name
) {

  public @NonNull Long savedId() {
    if (id == null) {
      log.error("Профессия без ID");
      throw new DomainException("Что-то пошло не так");
    }
    return id;
  }
}
