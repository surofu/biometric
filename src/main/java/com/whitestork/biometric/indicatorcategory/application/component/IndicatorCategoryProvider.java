package com.whitestork.biometric.indicatorcategory.application.component;

import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryDetailsResponse;
import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import com.whitestork.biometric.indicatorcategory.infrastructure.persistence.IndicatorCategoryRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.util.function.Supplier;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class IndicatorCategoryProvider {
  private final IndicatorCategoryRepository repository;

  public @NonNull IndicatorCategory withId(@NonNull Long id) {
    return repository.findById(id).orElseThrow(handleNotFound(id));
  }

  public @NonNull IndicatorCategoryDetailsResponse withIdDetailsResponse(@NonNull Long id) {
    return repository.findByIdDetailsResponse(id).orElseThrow(handleNotFound(id));
  }

  private @NonNull Supplier<DomainException> handleNotFound(@NonNull Long id) {
    return () -> new DomainException("Категория индикаторов с ID \"%s\" не найдена".formatted(id));
  }
}
