package com.whitestork.biometric.measurement.application.request;

import java.time.LocalDate;
import org.jspecify.annotations.NonNull;

public record SaveMeasurementRequest(
    @NonNull
    String userEmail,
    @NonNull
    Long indicatorId,
    @NonNull
    Double value,
    @NonNull
    LocalDate date
) {
}
