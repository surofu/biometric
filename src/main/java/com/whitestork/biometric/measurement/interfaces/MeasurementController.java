package com.whitestork.biometric.measurement.interfaces;

import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.response.MeasurementGroupResponse;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.application.usecase.DeleteMeasurementUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetUserMeasurementPageUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetUserMeasurementByIdAndUserEmailUseCase;
import com.whitestork.biometric.measurement.application.usecase.SaveMeasurementUseCase;
import com.whitestork.biometric.measurement.application.usecase.UpdateMeasurementUseCase;
import com.whitestork.biometric.measurement.interfaces.model.SaveOrUpdateMeasurementModel;
import com.whitestork.biometric.shared.domain.KeysetCursor;
import com.whitestork.biometric.shared.domain.KeysetPage;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequestMapping("/measurements")
@RequiredArgsConstructor
public class MeasurementController {
  private final GetAllIndicatorsUseCase getAllIndicatorsUseCase;
  private final GetUserMeasurementPageUseCase getUserMeasurementPageUseCase;
  private final GetUserMeasurementByIdAndUserEmailUseCase getUserMeasurementByIdAndUserEmailUseCase;
  private final DeleteMeasurementUseCase deleteMeasurementUseCase;
  private final MeasurementMapper measurementMapper;
  private final SaveMeasurementUseCase saveMeasurementUseCase;
  private final UpdateMeasurementUseCase updateMeasurementUseCase;

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String all(
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
      return "measurement/measurement-groups";
    }
    return "measurement/measurements";
  }

  @GetMapping("/new")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String newMeasurementForm(@NonNull Model model) {
    model.addAttribute("measurement", new SaveOrUpdateMeasurementModel());
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
    SaveOrUpdateMeasurementModel request = new SaveOrUpdateMeasurementModel(
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
  public @NonNull String saveMeasurement(
      @NonNull @Valid @ModelAttribute("measurement") SaveOrUpdateMeasurementModel request,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull BindingResult bindingResult,
      @NonNull Model model
  ) {
    SaveOrUpdateMeasurementModel saveOrUpdateMeasurementModel = new SaveOrUpdateMeasurementModel(
        request.id(),
        securityUser.email(),
        request.indicatorId(),
        request.value(),
        request.date()
    );

    if (bindingResult.hasErrors()) {
      model.addAttribute("validationErrors", bindingResult);
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute("measurement", saveOrUpdateMeasurementModel);
      return "measurement/measurement-form";
    }

    try {
      if (saveOrUpdateMeasurementModel.id() != null) {
        updateMeasurementUseCase.execute(measurementMapper.toUpdateMeasurementRequest(
            saveOrUpdateMeasurementModel
        ));
      } else {
        saveMeasurementUseCase.execute(measurementMapper.toSaveMeasurementRequest(
            saveOrUpdateMeasurementModel
        ));
      }

      String successMessage = request.id() == null
          ? "Показатель успешно добавлен!"
          : "Показатель успешно изменен!";
      model.addAttribute("successMessage", successMessage);
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute(
          "measurement",
          new SaveOrUpdateMeasurementModel().withDate(request.date())
      );
      return "measurement/measurement-form";
    } catch (DomainException exception) {
      log.warn("DomainException при сохранении: {}", exception.getMessage());
      model.addAttribute("errorMessage", exception.getMessage());
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute("measurement", saveOrUpdateMeasurementModel);
      return "measurement/measurement-form";
    } catch (Exception exception) {
      log.error("Неизвестная ошибка при сохранении: {}", exception.getMessage(), exception);
      model.addAttribute("errorMessage", exception.getMessage());
      model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
      model.addAttribute("measurement", saveOrUpdateMeasurementModel);
      return "measurement/measurement-form";
    }
  }

  @PostMapping("/{id}/delete")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String deleteMeasurement(
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
