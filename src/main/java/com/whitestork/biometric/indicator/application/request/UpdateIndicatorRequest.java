package com.whitestork.biometric.indicator.application.request;

import org.jspecify.annotations.NonNull;

public record UpdateIndicatorRequest(
    @NonNull Long id,
    @NonNull Long categoryId,
    @NonNull String name,
    @NonNull String unit,
    @NonNull Double referenceMin,
    @NonNull Double referenceMax
) {
}
