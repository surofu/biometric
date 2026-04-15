package com.whitestork.biometric.analytics.domain;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AnalyticsData {
  private List<String> labels;
  private List<String> shotLabels;
  private List<Double> values;
  private List<Double> referenceMin;
  private List<Double> referenceMax;
}
