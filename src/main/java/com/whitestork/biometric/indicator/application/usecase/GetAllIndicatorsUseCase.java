package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetAllIndicatorsUseCase {
  private final IndicatorRepository repository;

  @NonNull
  public Iterable<IndicatorResponse> execute() {
    return repository.findAllResponses();
  }
}
