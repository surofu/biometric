package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.profession.application.response.ProfessionResponse;
import com.whitestork.biometric.profession.infrastructrure.persistence.ProfessionRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetAllProfessionsUseCase {
  private final ProfessionRepository repository;

  public @NonNull List<ProfessionResponse> execute() {
    return repository.findAllResponses();
  }
}
