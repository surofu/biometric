package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetMyAvailableIndicatorsUseCase {
  private final IndicatorRepository repository;

  @NonNull
  public Iterable<IndicatorResponse> execute(@NonNull String email) {
    return repository.findAllAvailable(email);
  }
}
