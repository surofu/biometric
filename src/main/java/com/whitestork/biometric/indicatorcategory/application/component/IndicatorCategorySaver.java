package com.whitestork.biometric.indicatorcategory.application.component;

import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import com.whitestork.biometric.indicatorcategory.infrastructure.persistence.IndicatorCategoryRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class IndicatorCategorySaver {
  private final IndicatorCategoryRepository repository;

  @Transactional
  public void save(@NonNull IndicatorCategory indicatorCategory) {
    repository.save(indicatorCategory);
  }
}
