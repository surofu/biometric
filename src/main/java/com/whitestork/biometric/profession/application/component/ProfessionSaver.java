package com.whitestork.biometric.profession.application.component;

import com.whitestork.biometric.profession.domain.Profession;
import com.whitestork.biometric.profession.infrastructrure.persistence.ProfessionRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class ProfessionSaver {
  private final ProfessionRepository repository;

  @Transactional
  public @NonNull Profession save(@NonNull Profession profession) {
    return repository.save(profession);
  }
}
