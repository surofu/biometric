package com.whitestork.biometric.measurement.interfaces;

import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetAllIndicatorCategoriesUseCase;
import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.response.MeasurementGroupResponse;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.application.usecase.DeleteMeasurementUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetUserMeasurementByIdAndUserEmailUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetUserMeasurementPageUseCase;
import com.whitestork.biometric.measurement.application.usecase.SaveMeasurementUseCase;
import com.whitestork.biometric.measurement.application.usecase.UpdateMeasurementUseCase;
import com.whitestork.biometric.measurement.interfaces.model.SaveOrUpdateMeasurementModel;
import com.whitestork.biometric.shared.domain.KeysetCursor;
import com.whitestork.biometric.shared.domain.KeysetPage;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequestMapping("/measurements")
@RequiredArgsConstructor
public class MeasurementController {

  private final GetAllIndicatorsUseCase getAllIndicatorsUseCase;
  private final GetAllIndicatorCategoriesUseCase getAllIndicatorCategoriesUseCase;
  private final GetUserMeasurementPageUseCase getUserMeasurementPageUseCase;
  private final GetUserMeasurementByIdAndUserEmailUseCase getUserMeasurementByIdAndUserEmailUseCase;
  private final SaveMeasurementUseCase saveMeasurementUseCase;
  private final UpdateMeasurementUseCase updateMeasurementUseCase;
  private final DeleteMeasurementUseCase deleteMeasurementUseCase;
  private final MeasurementMapper measurementMapper;

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String list(
      @NonNull @RequestParam(defaultValue = "20", required = false) Integer pageSize,
      @Nullable @RequestParam(required = false) String cursor,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model,
      @NonNull HttpServletRequest request,
      @NonNull HttpServletResponse response
  ) {
    KeysetPage<MeasurementGroupResponse> page = getUserMeasurementPageUseCase.execute(
        securityUser.email(),
        cursor != null ? KeysetCursor.fromString(cursor) : null,
        pageSize
    );

    model.addAttribute("isFirstPage", cursor == null);
    model.addAttribute("page", page);
    model.addAttribute("pageSize", pageSize);

    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
      response.setHeader("X-Next-Cursor", page.nextCursor() != null ? page.nextCursor() : "");
      response.setHeader("X-Has-Next", String.valueOf(page.hasNext()));
      return "measurement/groups";
    }

    return "measurement/all";
  }

  @GetMapping("/new")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String newForm(@NonNull Model model) {
    populateFormModel(model, new SaveOrUpdateMeasurementModel());
    return "measurement/save-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String editForm(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model
  ) {
    MeasurementResponse measurement =
        getUserMeasurementByIdAndUserEmailUseCase.execute(id, securityUser.email());
    SaveOrUpdateMeasurementModel formModel = new SaveOrUpdateMeasurementModel(
        measurement.id(),
        securityUser.email(),
        measurement.indicatorId(),
        measurement.value(),
        measurement.date()
    );
    populateFormModel(model, formModel);
    return "measurement/save-form";
  }

  @PostMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String save(
      @NonNull @ModelAttribute("measurement") SaveOrUpdateMeasurementModel request,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model
  ) {
    SaveOrUpdateMeasurementModel formModel = new SaveOrUpdateMeasurementModel(
        request.id(),
        securityUser.email(),
        request.indicatorId(),
        request.value(),
        request.date()
    );

    try {
      if (formModel.id() != null) {
        updateMeasurementUseCase.execute(measurementMapper.toUpdateMeasurementRequest(formModel));
      } else {
        saveMeasurementUseCase.execute(measurementMapper.toSaveMeasurementRequest(formModel));
      }

      String successMessage = request.id() == null
          ? "Показатель успешно добавлен!"
          : "Показатель успешно изменён!";
      model.addAttribute("successMessage", successMessage);
      populateFormModel(model, new SaveOrUpdateMeasurementModel().withDate(request.date()));
      return "measurement/save-form";

    } catch (DomainException e) {
      log.warn("DomainException при сохранении: {}", e.getMessage());
      model.addAttribute("errorMessage", e.getMessage());
      populateFormModel(model, formModel);
      return "measurement/save-form";

    } catch (Exception e) {
      log.error("Неизвестная ошибка при сохранении: {}", e.getMessage(), e);
      model.addAttribute("errorMessage", e.getMessage());
      populateFormModel(model, formModel);
      return "measurement/save-form";
    }
  }

  @PostMapping("/{id}/delete")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String delete(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      deleteMeasurementUseCase.execute(id, securityUser.email());
    } catch (DomainException e) {
      log.warn("DomainException при удалении: {}", e.getMessage());
      redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
    } catch (Exception e) {
      log.error("Неизвестная ошибка при удалении: {}", e.getMessage(), e);
      redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
    }
    return "redirect:/measurements";
  }

  private void populateFormModel(@NonNull Model model,
                                 @NonNull SaveOrUpdateMeasurementModel measurement) {
    model.addAttribute("measurement", measurement);
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
  }
}