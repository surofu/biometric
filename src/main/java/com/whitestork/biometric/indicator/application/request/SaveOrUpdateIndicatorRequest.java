package com.whitestork.biometric.indicator.application.request;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;

public record SaveOrUpdateIndicatorRequest(
    Long id,
    Long categoryId,
    String name,
    String unit,
    Double referenceMin,
    Double referenceMax
) {

  public SaveOrUpdateIndicatorRequest() {
    this(null, null, null, null, null, null);
  }

  public SaveOrUpdateIndicatorRequest(IndicatorResponse response) {
    this(
        response.id(),
        response.categoryId(),
        response.name(),
        response.unit(),
        response.referenceMin(),
        response.referenceMax()
    );
  }
}
