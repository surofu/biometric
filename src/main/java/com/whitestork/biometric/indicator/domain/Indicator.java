package com.whitestork.biometric.indicator.domain;

import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("indicators")
public record Indicator(
    @Id
    @Nullable Long id,
    @NonNull String name,
    @NonNull String unit,
    @NonNull Double referenceMin,
    @NonNull Double referenceMax
) {
}
