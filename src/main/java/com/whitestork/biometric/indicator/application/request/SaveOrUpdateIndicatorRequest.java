package com.whitestork.biometric.indicator.application.request;

import lombok.With;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record SaveOrUpdateIndicatorRequest(
    @Nullable Long id,
    @Nullable Long userId,
    @Nullable Long categoryId,
    @NonNull String name,
    @NonNull String unit,
    @NonNull Double referenceMin,
    @NonNull Double referenceMax,
    @NonNull String description
) {
}
