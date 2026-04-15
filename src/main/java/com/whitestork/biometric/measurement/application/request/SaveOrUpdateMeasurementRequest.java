package com.whitestork.biometric.measurement.application.request;

import java.time.LocalDate;
import lombok.With;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

@With
public record SaveOrUpdateMeasurementRequest(
    @Nullable Long id,
    @NonNull String userEmail,
    @NonNull Long indicatorId,
    @NonNull Double value,
    @NonNull LocalDate date
) {
}
