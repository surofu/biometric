package com.whitestork.biometric.indicatorcategory.application.response;

import org.jspecify.annotations.NonNull;

public record IndicatorCategoryResponse(
    @NonNull Long id,
    @NonNull String name,
    @NonNull String description
) {
}
