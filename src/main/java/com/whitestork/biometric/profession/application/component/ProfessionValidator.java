package com.whitestork.biometric.profession.application.component;

import com.whitestork.biometric.profession.infrastructrure.persistence.ProfessionRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProfessionValidator {
  private final ProfessionRepository repository;

  public void uniqueName(@NonNull String name) {
    if (repository.existsByName(name)) {
      throw new DomainException("Профессия \"%s\" уже существует".formatted(name));
    }
  }
}
