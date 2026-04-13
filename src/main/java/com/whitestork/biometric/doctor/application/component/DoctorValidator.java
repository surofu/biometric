package com.whitestork.biometric.doctor.application.component;

import com.whitestork.biometric.doctor.infrastructure.persistence.DoctorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DoctorValidator {
  private final DoctorRepository repository;

  public void uniqueName(@NonNull String name) {
    if (repository.existsByName(name)) {
      throw new DomainException("Доктор \"%s\" уже существует".formatted(name));
    }
  }
}
