package com.whitestork.biometric.measurement.application.response;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MeasurementResponse {
  private Long id;
  private Double value;
  private LocalDate date;
  private Long indicatorId;
  private String indicatorName;
  private String indicatorUnit;
  private Double indicatorReferenceMin;
  private Double indicatorReferenceMax;

  public boolean isNormal() {
    return range() > 0.1 && range() < 0.9;
  }

  public boolean isBorderline() {
    return range() >= 0 && range() <= 1;
  }

  public boolean isUpper() {
    return range() > 1;
  }

  private double range() {
    double referenceDifference = indicatorReferenceMax - indicatorReferenceMin;
    double differenceMin = value - indicatorReferenceMin;
    return differenceMin / referenceDifference;
  }
}
