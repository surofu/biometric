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
  private Double borderMin;
  private Double borderMax;

  public boolean isNormal(int i) {
    double v = values.get(i);
    return v > borderMin && v < borderMax;
  }

  public boolean isBorderline(int i) {
    double v = values.get(i);
    return v >= referenceMin.get(i) && v <= referenceMax.get(i) && !isNormal(i);
  }

  public boolean isUpper(int i) {
    return values.get(i) > referenceMax.get(i);
  }
}