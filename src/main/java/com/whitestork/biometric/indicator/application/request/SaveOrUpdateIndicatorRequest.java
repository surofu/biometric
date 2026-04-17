package com.whitestork.biometric.indicator.application.request;

import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record SaveOrUpdateIndicatorRequest(
    @Nullable Long id,
    @NonNull Long categoryId,
    @NonNull String name,
    @NonNull String unit,
    @NonNull Double referenceMin,
    @NonNull Double referenceMax,
    @NonNull String description
) {
}
