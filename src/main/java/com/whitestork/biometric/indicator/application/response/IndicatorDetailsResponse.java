package com.whitestork.biometric.indicator.application.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IndicatorDetailsResponse {
  private Long id;
  private String name;
  private String unit;
  private Long categoryId;
  private String categoryName;
  private Double referenceMin;
  private Double referenceMax;
  private String description;
}
