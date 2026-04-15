package com.whitestork.biometric.user.application.mapper;

import com.whitestork.biometric.user.application.request.ChangePasswordRequest;
import com.whitestork.biometric.user.application.request.RegisterUserRequest;
import com.whitestork.biometric.user.interfaces.model.ChangePasswordModel;
import com.whitestork.biometric.user.interfaces.model.RegisterUserModel;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface UserMapper {

  RegisterUserRequest toRequest(RegisterUserModel model);

  ChangePasswordRequest toRequest(ChangePasswordModel model);
}

