package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.service.IndicatorCategoryDeleter;
import com.whitestork.biometric.indicatorcategory.application.service.IndicatorCategoryProvider;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DeleteIndicatorCategoryByIdUseCase {
  private final IndicatorCategoryProvider provider;
  private final IndicatorCategoryDeleter deleter;

  public void execute(@NonNull Long id) {
    deleter.delete(provider.withId(id));
  }
}
