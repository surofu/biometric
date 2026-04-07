package com.whitestork.biometric.measurement.application.response;

import java.time.LocalDate;
import org.jspecify.annotations.NonNull;

public record MeasurementResponse(
    @NonNull Long id,
    @NonNull Double value,
    @NonNull LocalDate date,
    // Indicator Info
    @NonNull Long indicatorId,
    @NonNull String indicatorName,
    @NonNull String indicatorUnit,
    @NonNull Double indicatorReferenceMin,
    @NonNull Double indicatorReferenceMax
) {
}
