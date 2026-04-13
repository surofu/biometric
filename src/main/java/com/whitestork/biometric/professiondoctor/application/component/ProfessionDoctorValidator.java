package com.whitestork.biometric.professiondoctor.application.component;

import com.whitestork.biometric.professiondoctor.infrastructure.ProfessionDoctorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProfessionDoctorValidator {
  private final ProfessionDoctorRepository repository;

  public void uniqueIdPair(
      @NonNull Long professionId,
      @NonNull Long doctorId
  ) {
    if (repository.existsByProfessionIdAndDoctorId(professionId, doctorId)) {
      throw new DomainException(
          "Доктор \"%s\" уже привязан к профессии \"%s\"".formatted(doctorId, professionId)
      );
    }
  }
}
