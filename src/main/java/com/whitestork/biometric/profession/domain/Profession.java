package com.whitestork.biometric.profession.domain;

import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("professions")
public record Profession(
    @Id
    @Nullable Long id,
    @NonNull String name
) {
}
