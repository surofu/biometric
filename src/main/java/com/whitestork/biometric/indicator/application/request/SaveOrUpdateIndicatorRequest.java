package com.whitestork.biometric.indicator.application.request;

public record SaveOrUpdateIndicatorRequest(
    Long id,
    Long categoryId,
    String name,
    String unit,
    Double referenceMin,
    Double referenceMax
) {
}
