package com.whitestork.biometric.analytics.application.response;

import com.whitestork.biometric.analytics.domain.AnalyticsData;
import com.whitestork.biometric.analytics.domain.MeasurementPoint;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AnalyticsResponse {
  private String indicatorName;
  private AnalyticsData data;
  private Double referenceMin;
  private Double referenceMax;
  private List<MeasurementPoint> measurements;
}
