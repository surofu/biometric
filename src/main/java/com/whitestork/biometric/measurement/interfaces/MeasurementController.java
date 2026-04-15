package com.whitestork.biometric.measurement.interfaces;

import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetAllIndicatorCategoriesUseCase;
import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.response.MeasurementGroupResponse;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.application.usecase.DeleteMeasurementUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetUserMeasurementByIdAndUserEmailUseCase;
import com.whitestork.biometric.measurement.application.usecase.GetUserMeasurementPageUseCase;
import com.whitestork.biometric.measurement.application.usecase.SaveOrUpdateMeasurementUseCase;
import com.whitestork.biometric.measurement.interfaces.model.SaveOrUpdateMeasurementModel;
import com.whitestork.biometric.shared.domain.KeysetCursor;
import com.whitestork.biometric.shared.domain.KeysetPage;
import com.whitestork.biometric.user.domain.User;
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
import org.springframework.web.bind.annotation.DeleteMapping;
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
  private final DeleteMeasurementUseCase deleteMeasurementUseCase;
  private final SaveOrUpdateMeasurementUseCase saveOrUpdateMeasurementUseCase;
  private final MeasurementMapper mapper;

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String list(
      @NonNull @RequestParam(defaultValue = "20", required = false) Integer pageSize,
      @Nullable @RequestParam(required = false) String cursor,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model,
      @NonNull HttpServletRequest request,
      @NonNull HttpServletResponse response
  ) {
    KeysetPage<MeasurementGroupResponse> page = getUserMeasurementPageUseCase.execute(
        user.email(),
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

  @GetMapping("/add")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String add(@NonNull Model model) {
    populateFormModel(model, new SaveOrUpdateMeasurementModel());
    return "measurement/save-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String edit(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    MeasurementResponse measurement = getUserMeasurementByIdAndUserEmailUseCase.execute(
        id,
        user.email()
    );
    populateFormModel(model, mapper.toSaveOrUpdateModel(measurement).withUserEmail(user.email()));
    return "measurement/save-form";
  }

  @PostMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String save(
      @NonNull @ModelAttribute SaveOrUpdateMeasurementModel request,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    try {
      saveOrUpdateMeasurementUseCase.execute(
          mapper.toSaveOrUpdateRequest(request),
          user
      );
      String successMessage = request.getId() == null
          ? "Показатель успешно добавлен!"
          : "Показатель успешно изменён!";
      model.addAttribute("successMessage", successMessage);
      populateFormModel(model, new SaveOrUpdateMeasurementModel().withDate(request.getDate()));
      return "measurement/save-form";

    } catch (Exception exception) {
      log.warn("Ошибка при сохранении показателя: {}", exception.getMessage());
      model.addAttribute("errorMessage", exception.getMessage());
      populateFormModel(model, request);
      return "measurement/save-form";
    }
  }

  @DeleteMapping("/{id}")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String delete(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      deleteMeasurementUseCase.execute(id, user.email());
      redirectAttributes.addFlashAttribute("successMessage", "Показатель успешно удален");
    } catch (Exception exception) {
      log.warn("DomainException при удалении: {}", exception.getMessage());
      redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
    }
    return "redirect:/measurements";
  }

  private void populateFormModel(
      @NonNull Model model,
      @NonNull SaveOrUpdateMeasurementModel measurement
  ) {
    model.addAttribute("measurement", measurement);
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
  }
}