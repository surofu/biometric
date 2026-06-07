package com.whitestork.biometric.indicator.application.component;

import com.whitestork.biometric.indicator.application.response.IndicatorDetailsResponse;
import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.util.function.Supplier;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class IndicatorProvider {
  private final IndicatorRepository repository;

  public @NonNull Indicator withId(@NonNull Long id) {
    return repository.findById(id).orElseThrow(handleException(id));
  }

  public @NonNull Indicator withIdAndUserId(@NonNull Long id, @NonNull Long userId) {
    return repository.findByIdAndUserId(id, userId).orElseThrow(handleException(id));
  }

  public @NonNull IndicatorDetailsResponse withIdDetailsResponse(@NonNull Long id) {
    return repository.findByIdPublicDetailsResponse(id).orElseThrow(handleException(id));
  }

  public @NonNull IndicatorDetailsResponse withIdAndUserIdDetailsResponse(@NonNull Long id, @NonNull Long userId) {
    return repository.findByIdAndUserIdDetailsResponse(id, userId).orElseThrow(handleException(id));
  }

  private @NonNull Supplier<DomainException> handleException(@NonNull Long id) {
    return () -> new DomainException("Индикатор с ID \"%s\" не найден".formatted(id));
  }
}
