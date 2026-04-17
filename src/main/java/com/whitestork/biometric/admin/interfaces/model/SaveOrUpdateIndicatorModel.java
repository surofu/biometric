package com.whitestork.biometric.admin.interfaces.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SaveOrUpdateIndicatorModel {
  private Long id;
  private Long categoryId;
  private String name;
  private String unit;
  private Double referenceMin;
  private Double referenceMax;
  private String description;
}