package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.component.IndicatorCategoryProvider;
import com.whitestork.biometric.indicatorcategory.application.component.IndicatorCategorySaver;
import com.whitestork.biometric.indicatorcategory.application.component.IndicatorCategoryValidator;
import com.whitestork.biometric.indicatorcategory.application.mapper.IndicatorCategoryMapper;
import com.whitestork.biometric.indicatorcategory.application.request.UpdateIndicatorCategoryRequest;
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

  public void execute(@NonNull UpdateIndicatorCategoryRequest request) {
    IndicatorCategory oldIndicatorCategory = provider.withId(request.id());

    if (!Objects.equals(oldIndicatorCategory.name(), request.name())) {
      validator.uniqueName(request.name());
    }

    IndicatorCategory updatedIndicatorCategory = categoryMapper.toDomain(request);
    saver.save(updatedIndicatorCategory);
  }
}
