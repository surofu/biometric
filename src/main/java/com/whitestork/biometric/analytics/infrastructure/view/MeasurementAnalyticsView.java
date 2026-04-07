package com.whitestork.biometric.analytics.infrastructure.view;

import java.time.LocalDate;
import org.jspecify.annotations.NonNull;

public record MeasurementAnalyticsView(
    @NonNull Double value,
    @NonNull LocalDate date
) {
}
