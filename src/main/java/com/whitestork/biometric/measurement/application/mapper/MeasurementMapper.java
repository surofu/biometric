package com.whitestork.biometric.measurement.application.mapper;

import com.whitestork.biometric.measurement.application.request.SaveMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.SaveOrUpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.UpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.measurement.interfaces.model.SaveOrUpdateMeasurementModel;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface MeasurementMapper {

  SaveMeasurementRequest toSaveRequest(SaveOrUpdateMeasurementRequest request);

  UpdateMeasurementRequest toUpdateRequest(SaveOrUpdateMeasurementRequest request);

  SaveOrUpdateMeasurementModel toSaveOrUpdateModel(MeasurementResponse response);

  SaveOrUpdateMeasurementRequest toSaveOrUpdateRequest(SaveOrUpdateMeasurementModel model);

  Measurement toDomain(SaveMeasurementRequest request);

  @Mapping(target = "id", ignore = true)
  Measurement toDomain(UpdateMeasurementRequest request);

  MeasurementResponse toResponse(Measurement measurement);
}
