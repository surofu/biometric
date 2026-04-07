package com.whitestork.biometric.indicatorcategory.domain;


import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("indicator_categories")
public record IndicatorCategory(
    @Id
    @Nullable Long id,
    @NonNull String name,
    @NonNull String description
) {
}
