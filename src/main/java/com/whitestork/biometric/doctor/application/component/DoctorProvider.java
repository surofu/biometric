package com.whitestork.biometric.doctor.application.component;

import com.whitestork.biometric.doctor.domain.Doctor;
import com.whitestork.biometric.doctor.infrastructure.persistence.DoctorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DoctorProvider {
  private final DoctorRepository repository;

  public @NonNull Doctor withId(@NonNull Long id) {
    return repository.findById(id).orElseThrow(
        () -> new DomainException("Доктор с ID \"%s\" не найден".formatted(id))
    );
  }
}
