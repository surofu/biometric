package com.whitestork.biometric.indicator.application.mapper;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.domain.Indicator;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface IndicatorMapper {

  IndicatorResponse toResponse(Indicator indicator);
}
