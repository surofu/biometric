package com.whitestork.biometric.indicatorcategory.application.component;

import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import com.whitestork.biometric.indicatorcategory.infrastructure.persistence.IndicatorCategoryRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class IndicatorCategoryProvider {
  private final IndicatorCategoryRepository repository;

  public @NonNull IndicatorCategory withId(@NonNull Long id) {
    return  repository.findById(id).orElseThrow(
        () -> new DomainException("Категория индикаторов с ID \"%s\" не найдена".formatted(id))
    );
  }
}
