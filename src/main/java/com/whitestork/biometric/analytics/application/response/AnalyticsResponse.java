package com.whitestork.biometric.analytics.application.response;

import com.whitestork.biometric.analytics.domain.AnalyticsData;
import com.whitestork.biometric.analytics.domain.MeasurementPoint;
import java.util.List;

public record AnalyticsResponse(
    String indicatorName, // Холестерин
    String intervalName, // Динамика за 2025 год
    AnalyticsData data, // data для new uPlot(opts, data, chartElem);
    Double referenceMin,
    Double referenceMax,
    List<MeasurementPoint> measurements
) {
}
