package com.whitestork.biometric.doctor.domain;

import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("doctors")
public record Doctor(
    @Id
    @Nullable Long id,
    @NonNull String name,
    @NonNull String description
) {
}
