package com.whitestork.biometric.indicator.application.response;

import org.jspecify.annotations.NonNull;

public record IndicatorResponse(
    @NonNull Long id,
    @NonNull String name,
    @NonNull String unit,
    @NonNull Double referenceMin,
    @NonNull Double referenceMax
) {
}
