package com.whitestork.biometric.profession.application.mapper;

import com.whitestork.biometric.profession.application.request.SaveOrUpdateProfessionRequest;
import com.whitestork.biometric.profession.application.request.SaveProfessionRequest;
import com.whitestork.biometric.profession.application.request.UpdateProfessionRequest;
import com.whitestork.biometric.profession.application.response.ProfessionDetailsResponse;
import com.whitestork.biometric.profession.application.response.ProfessionResponse;
import com.whitestork.biometric.profession.domain.Profession;
import com.whitestork.biometric.admin.interfaces.model.SaveOrUpdateProfessionModel;
import com.whitestork.biometric.profession.infrastructrure.projection.ProfessionDetailsProjection;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface ProfessionMapper {
  SaveOrUpdateProfessionModel toModel(ProfessionDetailsResponse response);

  SaveOrUpdateProfessionRequest toRequest(SaveOrUpdateProfessionModel response);

  SaveProfessionRequest toSaveRequest(SaveOrUpdateProfessionRequest request);

  UpdateProfessionRequest toUpdateRequest(SaveOrUpdateProfessionRequest request);

  Profession toDomain(SaveProfessionRequest request);

  Profession toDomain(UpdateProfessionRequest request);

  ProfessionResponse toResponse(Profession profession);

  ProfessionDetailsResponse toDetailsResponse(ProfessionDetailsProjection projection);
}
