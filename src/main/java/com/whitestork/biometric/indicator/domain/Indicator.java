package com.whitestork.biometric.indicator.domain;

import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Table("indicators")
public record Indicator(
    @Id
    Long id,
    String name,
    String unit,
    Double referenceMin,
    Double referenceMax
) {
}
