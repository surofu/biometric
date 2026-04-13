package com.whitestork.biometric.profession.application.component;

import com.whitestork.biometric.profession.domain.Profession;
import com.whitestork.biometric.profession.infrastructrure.persistence.ProfessionRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProfessionProvider {
  private final ProfessionRepository repository;

  public @NonNull Profession withId(@NonNull Long id) {
    return repository.findById(id).orElseThrow(
        () -> new DomainException("Профессия с ID \"%s\" не найдена".formatted(id))
    );
  }
}
