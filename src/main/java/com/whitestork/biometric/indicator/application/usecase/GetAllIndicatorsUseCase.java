package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetAllIndicatorsUseCase {
  private final IndicatorRepository repository;

  @NonNull
  @Cacheable(value = "indicators", unless = "#result.empty")
  public List<IndicatorResponse> execute() {
    return repository.findAllResponses();
  }
}
