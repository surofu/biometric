package com.whitestork.biometric.admin.interfaces;

import com.whitestork.biometric.admin.interfaces.model.SaveOrUpdateIndicatorModel;
import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.application.usecase.DeleteIndicatorByIdUseCase;
import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.indicator.application.usecase.SaveOrUpdateIndicatorUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetAllIndicatorCategoriesUseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/indicators")
public class AdminIndicatorController {
  private final GetAllIndicatorsUseCase getAllIndicatorsUseCase;
  private final IndicatorProvider indicatorProvider;
  private final SaveOrUpdateIndicatorUseCase saveOrUpdateIndicatorUseCase;
  private final DeleteIndicatorByIdUseCase deleteIndicatorByIdUseCase;
  private final GetAllIndicatorCategoriesUseCase getAllIndicatorCategoriesUseCase;
  private final IndicatorMapper mapper;

  @ModelAttribute
  public void commonAttributes(@NonNull Model model) {
    model.addAttribute("request", new SaveOrUpdateIndicatorModel());
  }

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String all(@NonNull Model model) {
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
    return "admin/indicators";
  }

  @GetMapping("/add")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String add(@NonNull Model model) {
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    return "admin/indicator-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String edit(@NonNull @PathVariable Long id, @NonNull Model model) {
    IndicatorResponse response = indicatorProvider.withIdResponse(id);
    model.addAttribute("request", mapper.toSaveOrUpdateModel(response));
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    return "admin/indicator-form";
  }

  @PostMapping("/save")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String save(
      @NonNull @ModelAttribute SaveOrUpdateIndicatorModel request,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    saveOrUpdateIndicatorUseCase.execute(mapper.toSaveOrUpdateRequest(request));
    redirectAttributes.addFlashAttribute("successMessage", "Индикатор успешно сохранен");
    return "redirect:/admin/indicators";
  }

  @DeleteMapping("/{id}")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String delete(
      @NonNull @PathVariable Long id,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    deleteIndicatorByIdUseCase.execute(id);
    redirectAttributes.addFlashAttribute("successMessage", "Индикатор успешно удален");
    return "redirect:/admin/indicators";
  }
}
