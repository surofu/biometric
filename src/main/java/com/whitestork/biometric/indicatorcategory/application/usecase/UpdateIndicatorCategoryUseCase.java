package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.mapper.IndicatorCategoryMapper;
import com.whitestork.biometric.indicatorcategory.application.request.UpdateIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.application.service.IndicatorCategoryProvider;
import com.whitestork.biometric.indicatorcategory.application.service.IndicatorCategorySaver;
import com.whitestork.biometric.indicatorcategory.application.service.IndicatorCategoryValidator;
import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UpdateIndicatorCategoryUseCase {
  private final IndicatorCategoryProvider provider;
  private final IndicatorCategoryValidator validator;
  private final IndicatorCategorySaver saver;
  private final IndicatorCategoryMapper categoryMapper;

  public @NonNull IndicatorCategoryResponse execute(
      @NonNull UpdateIndicatorCategoryRequest request
  ) {
    IndicatorCategory oldIndicatorCategory = provider.withId(request.id());

    if (!Objects.equals(oldIndicatorCategory.name(), request.name())) {
      validator.uniqueName(request.name());
    }

    IndicatorCategory updatedIndicatorCategory = categoryMapper.toDomain(request);
    IndicatorCategory savedIndicatorCategory = saver.save(updatedIndicatorCategory);
    return categoryMapper.toResponse(savedIndicatorCategory);
  }
}
