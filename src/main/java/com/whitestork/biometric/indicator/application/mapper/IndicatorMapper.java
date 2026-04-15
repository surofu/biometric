package com.whitestork.biometric.indicator.application.mapper;

import com.whitestork.biometric.admin.interfaces.model.SaveOrUpdateIndicatorModel;
import com.whitestork.biometric.indicator.application.request.SaveIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.SaveOrUpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.UpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.domain.Indicator;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface IndicatorMapper {

  SaveIndicatorRequest toSaveRequest(SaveOrUpdateIndicatorRequest request);

  UpdateIndicatorRequest toUpdateRequest(SaveOrUpdateIndicatorRequest request);

  SaveOrUpdateIndicatorModel toSaveOrUpdateModel(IndicatorResponse response);

  SaveOrUpdateIndicatorRequest toSaveOrUpdateRequest(SaveOrUpdateIndicatorModel model);

  @Mapping(target = "id", ignore = true)
  Indicator toDomain(SaveIndicatorRequest request);

  @Mapping(target = "id", ignore = true)
  Indicator toDomain(UpdateIndicatorRequest request);
}
