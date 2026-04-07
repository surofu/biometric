package com.whitestork.biometric.indicator.application.response;

import org.jspecify.annotations.NonNull;

public record IndicatorResponse(
    @NonNull Long id,
    @NonNull String name,
    @NonNull String unit,
    @NonNull Long categoryId,
    @NonNull String categoryName,
    @NonNull Double referenceMin,
    @NonNull Double referenceMax
) {
}
