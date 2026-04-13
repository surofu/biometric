package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.mapper.IndicatorCategoryMapper;
import com.whitestork.biometric.indicatorcategory.application.request.SaveIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.application.component.IndicatorCategorySaver;
import com.whitestork.biometric.indicatorcategory.application.component.IndicatorCategoryValidator;
import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveIndicatorCategoryUseCase {
  private final IndicatorCategoryValidator validator;
  private final IndicatorCategorySaver saver;
  private final IndicatorCategoryMapper categoryMapper;

  public @NonNull IndicatorCategoryResponse execute(
      @NonNull SaveIndicatorCategoryRequest request
  ) {
    validator.uniqueName(request.name());
    IndicatorCategory newIndicatorCategory = categoryMapper.toDomain(request);
    IndicatorCategory savedIndicatorCategory = saver.save(newIndicatorCategory);
    return categoryMapper.toResponse(savedIndicatorCategory);
  }
}
