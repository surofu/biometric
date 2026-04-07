package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.mapper.IndicatorCategoryMapper;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.application.service.IndicatorCategoryProvider;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetIndicatorCategoryByIdUseCase {
  private final IndicatorCategoryMapper categoryMapper;
  private final IndicatorCategoryProvider provider;

  public @NonNull IndicatorCategoryResponse execute(@NonNull Long id) {
    return categoryMapper.toResponse(provider.withId(id));
  }
}
