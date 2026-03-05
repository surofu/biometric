package com.whitestork.biometric.user.application.mapper;

import com.whitestork.biometric.user.application.response.UserResponse;
import com.whitestork.biometric.user.domain.User;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface UserMapper {

  UserResponse toResponse(User user);
}

