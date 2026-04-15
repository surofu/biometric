package com.whitestork.biometric.doctor.application.mapper;

import com.whitestork.biometric.doctor.application.request.SaveDoctorRequest;
import com.whitestork.biometric.doctor.application.request.SaveOrUpdateDoctorRequest;
import com.whitestork.biometric.doctor.application.request.UpdateDoctorRequest;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.domain.Doctor;
import com.whitestork.biometric.admin.interfaces.model.SaveOrUpdateDoctorModel;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface DoctorMapper {

  SaveOrUpdateDoctorRequest toSaveOrUpdateDoctorRequest(SaveOrUpdateDoctorModel model);

  SaveOrUpdateDoctorModel toSaveOrUpdateDoctorModel(DoctorResponse response);

  SaveDoctorRequest toSaveRequest(SaveOrUpdateDoctorRequest request);

  UpdateDoctorRequest toUpdateRequest(SaveOrUpdateDoctorRequest request);

  Doctor toDomain(SaveDoctorRequest request);

  Doctor toDomain(UpdateDoctorRequest request);

  DoctorResponse toResponse(Doctor doctor);
}
