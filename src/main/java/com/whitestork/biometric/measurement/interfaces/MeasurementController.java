package com.whitestork.biometric.measurement.interfaces;

import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.measurement.application.request.SaveOrUpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.response.MeasurementGroupResponse;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.application.usecase.DeleteMeasurementUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetAllUserMeasurementsUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetUserMeasurementByIdAndUserEmailUseCase;
import com.whitestork.biometric.measurement.application.usecase.SaveOrUpdateMeasurementUseCase;
import com.whitestork.biometric.shared.exception.DomainException;
import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequestMapping("/measurements")
@RequiredArgsConstructor
public class MeasurementController {
  private final GetAllIndicatorsUseCase getAllIndicatorsUseCase;
  private final SaveOrUpdateMeasurementUseCase saveOrUpdateMeasurementUseCase;
  private final GetAllUserMeasurementsUseCase getAllUserMeasurementsUseCase;
  private final GetUserMeasurementByIdAndUserEmailUseCase getUserMeasurementByIdAndUserEmailUseCase;
  private final DeleteMeasurementUseCase deleteMeasurementUseCase;

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public String all(
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model
  ) {
    Iterable<MeasurementGroupResponse> measurementGroups =
        getAllUserMeasurementsUseCase.execute(securityUser.email());
    model.addAttribute("measurementGroups", measurementGroups);
    return "measurement/measurements";
  }

  @GetMapping("/new")
  @PreAuthorize("isAuthenticated()")
  public String newMeasurementForm(@NonNull Model model) {
    model.addAttribute("measurement", new SaveOrUpdateMeasurementRequest());
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
    return "measurement/measurement-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public String editMeasurementForm(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model
  ) {
    MeasurementResponse measurement =
        getUserMeasurementByIdAndUserEmailUseCase.execute(id, securityUser.email());
    SaveOrUpdateMeasurementRequest request = new SaveOrUpdateMeasurementRequest(
        measurement.id(),
        securityUser.email(),
        measurement.indicatorId(),
        measurement.value(),
        measurement.date()
    );
    model.addAttribute("measurement", request);
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
    return "measurement/measurement-form";
  }

  @PostMapping
  @PreAuthorize("isAuthenticated()")
  public String saveMeasurement(
      @NonNull @Valid @ModelAttribute("measurement") SaveOrUpdateMeasurementRequest request,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull BindingResult bindingResult,
      @NonNull Model model
  ) {
    SaveOrUpdateMeasurementRequest updatedRequest = new SaveOrUpdateMeasurementRequest(
        request.id(),
        securityUser.email(),
        request.indicatorId(),
        request.value(),
        request.date()
    );

    if (bindingResult.hasErrors()) {
      model.addAttribute("validationErrors", bindingResult);
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute("measurement", updatedRequest);
      return "measurement/measurement-form";
    }

    try {
      saveOrUpdateMeasurementUseCase.execute(updatedRequest);
      model.addAttribute("successMessage", "Показатель успешно добавлен!");
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute(
          "measurement",
          new SaveOrUpdateMeasurementRequest().withDate(request.date())
      );
      return "measurement/measurement-form";
    } catch (DomainException exception) {
      log.warn("DomainException при сохранении: {}", exception.getMessage());
      model.addAttribute("errorMessage", exception.getMessage());
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute("measurement", updatedRequest);
      return "measurement/measurement-form";
    } catch (Exception exception) {
      log.error("Неизвестная ошибка при сохранении: {}", exception.getMessage(), exception);
      model.addAttribute("errorMessage", exception.getMessage());
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute("measurement", updatedRequest);
      return "measurement/measurement-form";
    }
  }

  @PostMapping("/{id}/delete")
  @PreAuthorize("isAuthenticated()")
  public String deleteMeasurement(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      deleteMeasurementUseCase.execute(id, securityUser.email());
      return "redirect:/measurements";
    } catch (DomainException exception) {
      log.warn("DomainException при удалении: {}", exception.getMessage());
      redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
      return "redirect:/measurements";
    } catch (Exception exception) {
      log.error("Неизвестная ошибка при удалении: {}", exception.getMessage(), exception);
      redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
      return "redirect:/measurements";
    }
  }
}
