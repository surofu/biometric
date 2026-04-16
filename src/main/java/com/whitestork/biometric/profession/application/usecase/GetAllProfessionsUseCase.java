package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.profession.application.response.ProfessionResponse;
import com.whitestork.biometric.profession.infrastructrure.persistence.ProfessionRepository;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetAllProfessionsUseCase {
  private final ProfessionRepository repository;

  public @NonNull List<ProfessionResponse> execute() {
    return repository.findAllResponses();
  }
}
