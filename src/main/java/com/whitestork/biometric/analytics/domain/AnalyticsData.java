package com.whitestork.biometric.analytics.domain;

import java.util.List;

public record AnalyticsData(
    List<String> labels,
    List<String> shotLabels,
    List<Double> values,
    List<Double> referenceMin,
    List<Double> referenceMax
) {
}
