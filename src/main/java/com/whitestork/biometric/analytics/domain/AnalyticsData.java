package com.whitestork.biometric.analytics.domain;

import java.util.List;
import org.jspecify.annotations.NonNull;

public record AnalyticsData(
    @NonNull List<String> labels,
    @NonNull List<String> shotLabels,
    @NonNull List<Double> values,
    @NonNull List<Double> referenceMin,
    @NonNull List<Double> referenceMax
) {
}
