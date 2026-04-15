package com.whitestork.biometric.admin.interfaces.model;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SaveOrUpdateProfessionModel {
  private Long id;
  private String name;
  private List<Long> doctorIds;
}
