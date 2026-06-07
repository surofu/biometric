package com.whitestork.biometric.indicator.application.mapper;

import com.whitestork.biometric.indicator.application.request.SaveIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.SaveOrUpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.UpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.response.IndicatorDetailsResponse;
import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.indicator.interfaces.model.SaveOrUpdateIndicatorModel;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface IndicatorMapper {

  SaveIndicatorRequest toSaveRequest(SaveOrUpdateIndicatorRequest request);

  UpdateIndicatorRequest toUpdateRequest(SaveOrUpdateIndicatorRequest request);

  SaveOrUpdateIndicatorModel toSaveOrUpdateModel(IndicatorDetailsResponse response);

  SaveOrUpdateIndicatorRequest toSaveOrUpdateRequest(SaveOrUpdateIndicatorModel model);

  SaveOrUpdateIndicatorRequest toSaveOrUpdateRequest(SaveOrUpdateIndicatorModel model, Long userId);

  Indicator toDomain(SaveIndicatorRequest request);

  Indicator toDomain(UpdateIndicatorRequest request);
}
