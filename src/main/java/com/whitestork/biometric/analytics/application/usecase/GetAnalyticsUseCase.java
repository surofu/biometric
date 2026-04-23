package com.whitestork.biometric.analytics.application.usecase;

import com.whitestork.biometric.analytics.application.response.AnalyticsResponse;
import com.whitestork.biometric.analytics.domain.AnalyticsData;
import com.whitestork.biometric.analytics.domain.MeasurementPoint;
import com.whitestork.biometric.analytics.infrastructure.view.MeasurementAnalyticsView;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import com.whitestork.biometric.shared.application.component.DateFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetAnalyticsUseCase {
  private final IndicatorProvider indicatorProvider;
  private final MeasurementRepository measurementRepository;
  private final DateFormatter dateFormatter;

  public @NonNull AnalyticsResponse execute(@NonNull Long indicatorId, @NonNull String email) {
    Indicator indicator = indicatorProvider.withId(indicatorId);
    List<MeasurementAnalyticsView> measurements = measurementRepository.findAllAnalytics(
        indicatorId,
        email
    );

    List<String> labels = measurements.stream()
        .map(v -> "%s (%s)".formatted(
            dateFormatter.format(v.date()),
            dateFormatter.dayOfWeek(v.date()))
        )
        .toList();
    List<String> shortLabels = measurements.stream()
        .map(v -> dateFormatter.chartLabel(v.date()))
        .toList();
    List<Double> values = measurements.stream()
        .map(MeasurementAnalyticsView::value)
        .toList();

    List<Double> refMin = Collections.nCopies(measurements.size(), indicator.referenceMin());
    List<Double> refMax = Collections.nCopies(measurements.size(), indicator.referenceMax());

    AnalyticsData data = new AnalyticsData(labels, shortLabels, values, refMin, refMax);

    List<MeasurementPoint> measurementPoints = new ArrayList<>();
    for (int i = labels.size() - 1; i >= 0; i--) {
      measurementPoints.add(new MeasurementPoint(labels.get(i), values.get(i)));
    }

    return new AnalyticsResponse(
        indicator.name(),
        data,
        indicator.referenceMin(),
        indicator.referenceMax(),
        measurementPoints
    );
  }
}
