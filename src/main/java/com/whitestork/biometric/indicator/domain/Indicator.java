package com.whitestork.biometric.indicator.domain;

import lombok.With;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Slf4j
@With
@Table("indicators")
public record Indicator(
    @Id
    @Nullable Long id,
    @NonNull Long categoryId,
    @NonNull String name,
    @NonNull String unit,
    @NonNull Double referenceMin,
    @NonNull Double referenceMax,
    @NonNull String description
) {
}
