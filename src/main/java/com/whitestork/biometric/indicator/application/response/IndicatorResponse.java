package com.whitestork.biometric.indicator.application.response;

public record IndicatorResponse(
    Long id,
    String name,
    String unit,
    Double referenceMin,
    Double referenceMax
) {
}
