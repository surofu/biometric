package com.whitestork.biometric.doctor.application.component;

import com.whitestork.biometric.doctor.application.response.DoctorDetailsResponse;
import com.whitestork.biometric.doctor.domain.Doctor;
import com.whitestork.biometric.doctor.infrastructure.persistence.DoctorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.util.function.Supplier;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class DoctorProvider {
  private final DoctorRepository repository;

  public @NonNull Doctor withId(@NonNull Long id) {
    return repository.findById(id).orElseThrow(handleNotFound(id));
  }

  public @NonNull DoctorDetailsResponse withIdDetails(@NonNull Long id) {
    return repository.findByIdDetailsResponse(id).orElseThrow(handleNotFound(id));
  }

  private @NonNull Supplier<DomainException> handleNotFound(Long id) {
    return () -> new DomainException("Доктор с ID \"%s\" не найден".formatted(id));
  }
}
