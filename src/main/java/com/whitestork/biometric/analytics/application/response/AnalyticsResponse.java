package com.whitestork.biometric.analytics.application.response;

import com.whitestork.biometric.analytics.domain.AnalyticsData;
import com.whitestork.biometric.analytics.domain.MeasurementPoint;
import java.util.List;
import org.jspecify.annotations.NonNull;

public record AnalyticsResponse(
    @NonNull String indicatorName, // Холестерин
    @NonNull String intervalName, // Динамика за 2025 год
    @NonNull AnalyticsData data, // data для new uPlot(opts, data, chartElem);
    @NonNull Double referenceMin,
    @NonNull Double referenceMax,
    @NonNull List<MeasurementPoint> measurements
) {
}
