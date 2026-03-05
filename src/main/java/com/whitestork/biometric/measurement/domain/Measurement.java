package com.whitestork.biometric.measurement.domain;

import java.time.Instant;
import java.time.LocalDate;
import lombok.With;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@With
@Table("measurements")
public record Measurement(
    @Nullable
    @Id
    Long id,
    @NonNull
    Long userId,
    @NonNull
    Long indicatorId,
    @NonNull
    Double value,
    @NonNull
    LocalDate date,
    @NonNull
    Instant createdAt
) {
}
