package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.component.IndicatorCategoryProvider;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryDetailsResponse;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetIndicatorCategoryByIdUseCase {
  private final IndicatorCategoryProvider provider;

  public @NonNull IndicatorCategoryDetailsResponse execute(@NonNull Long id) {
    return provider.withIdDetailsResponse(id);
  }
}
