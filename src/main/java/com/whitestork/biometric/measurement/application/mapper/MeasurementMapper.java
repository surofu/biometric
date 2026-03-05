package com.whitestork.biometric.measurement.application.mapper;

import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.measurement.application.request.SaveMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.SaveOrUpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.UpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.domain.Measurement;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface MeasurementMapper {

  SaveMeasurementRequest toSaveMeasurementRequest(SaveOrUpdateMeasurementRequest request);

  UpdateMeasurementRequest toUpdateMeasurementRequest(SaveOrUpdateMeasurementRequest request);

  Measurement toDomain(SaveMeasurementRequest request);

  @Mapping(target = "id", ignore = true)
  Measurement toDomain(UpdateMeasurementRequest request);

  @Mapping(target = "id", source = "measurement.id")
  @Mapping(target = "value", source = "measurement.value")
  @Mapping(target = "date", source = "measurement.date")
  @Mapping(target = "indicatorId", source = "indicator.id")
  @Mapping(target = "indicatorName", source = "indicator.name")
  @Mapping(target = "indicatorUnit", source = "indicator.unit")
  @Mapping(target = "indicatorReferenceMin", source = "indicator.referenceMin")
  @Mapping(target = "indicatorReferenceMax", source = "indicator.referenceMax")
  MeasurementResponse toResponse(Measurement measurement, Indicator indicator);
}
