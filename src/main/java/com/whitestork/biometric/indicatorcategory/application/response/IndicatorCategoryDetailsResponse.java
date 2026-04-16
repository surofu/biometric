package com.whitestork.biometric.indicatorcategory.application.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class IndicatorCategoryDetailsResponse {
  private Long id;
  private String name;
  private String description;
}
