package com.whitestork.biometric.indicatorcategory.application.mapper;

import com.whitestork.biometric.admin.interfaces.model.SaveOrUpdateIndicatorCategoryModel;
import com.whitestork.biometric.indicatorcategory.application.request.SaveIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.request.SaveOrUpdateIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.request.UpdateIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryDetailsResponse;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public interface IndicatorCategoryMapper {

  IndicatorCategoryResponse toResponse(IndicatorCategory category);

  IndicatorCategory toDomain(SaveIndicatorCategoryRequest request);

  IndicatorCategory toDomain(UpdateIndicatorCategoryRequest request);

  SaveOrUpdateIndicatorCategoryModel toSaveOrUpdateModel(IndicatorCategoryDetailsResponse response);

  SaveIndicatorCategoryRequest toSaveRequest(SaveOrUpdateIndicatorCategoryRequest request);

  UpdateIndicatorCategoryRequest toUpdateRequest(SaveOrUpdateIndicatorCategoryRequest request);
}
