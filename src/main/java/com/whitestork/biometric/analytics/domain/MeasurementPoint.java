package com.whitestork.biometric.analytics.domain;

import org.jspecify.annotations.NonNull;

public record MeasurementPoint(
    @NonNull String label,
    @NonNull Double value
) {
}
