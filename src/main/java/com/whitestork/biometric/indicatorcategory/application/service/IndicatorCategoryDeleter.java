package com.whitestork.biometric.indicatorcategory.application.service;

import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import com.whitestork.biometric.indicatorcategory.infrastructure.persistence.IndicatorCategoryRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class IndicatorCategoryDeleter {
  private final IndicatorCategoryRepository repository;

  @Transactional
  public void delete(@NonNull IndicatorCategory indicatorCategory) {
    repository.delete(indicatorCategory);
  }
}
