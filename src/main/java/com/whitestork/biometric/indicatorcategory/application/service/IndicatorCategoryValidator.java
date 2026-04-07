package com.whitestork.biometric.indicatorcategory.application.service;

import com.whitestork.biometric.indicatorcategory.infrastructure.persistence.IndicatorCategoryRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class IndicatorCategoryValidator {
  private final IndicatorCategoryRepository repository;

  public void uniqueName(String name) {
    if (repository.existsByName(name)) {
      throw new DomainException("Категория индикаторов \"%s\" уже существует".formatted(name));
    }
  }
}
