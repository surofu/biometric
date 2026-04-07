package com.whitestork.biometric.indicatorcategory.application.request;

import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record SaveOrUpdateIndicatorCategoryRequest(
    @Nullable Long id,
    @NonNull String name,
    @NonNull String description
) {

  public SaveOrUpdateIndicatorCategoryRequest(IndicatorCategoryResponse category) {
      this(category.id(), category.name(), category.description());
  }
}
