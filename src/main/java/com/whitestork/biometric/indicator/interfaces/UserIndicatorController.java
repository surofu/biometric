package com.whitestork.biometric.indicator.interfaces;

import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.response.IndicatorDetailsResponse;
import com.whitestork.biometric.indicator.application.usecase.DeleteIndicatorByIdAndUserIdUseCase;
import com.whitestork.biometric.indicator.application.usecase.GetAllUserIndicatorsUseCase;
import com.whitestork.biometric.indicator.application.usecase.GetIndicatorByIdAndUserIdUseCase;
import com.whitestork.biometric.indicator.application.usecase.SaveOrUpdateIndicatorUseCase;
import com.whitestork.biometric.indicator.interfaces.model.SaveOrUpdateIndicatorModel;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("user-indicators")
@PreAuthorize("@auth.isPremium(authentication) or @auth.isAdmin(authentication) or @auth.isModerator(authentication)")
public class UserIndicatorController {

  private final GetAllUserIndicatorsUseCase getAllUserIndicatorsUseCase;
  private final GetIndicatorByIdAndUserIdUseCase getIndicatorByIdAndUserIdUseCase;
  private final IndicatorMapper mapper;
  private final SaveOrUpdateIndicatorUseCase saveOrUpdateIndicatorUseCase;
  private final DeleteIndicatorByIdAndUserIdUseCase deleteIndicatorByIdAndUserIdUseCase;

  @ModelAttribute
  public void commonAttributes(@NonNull Model model) {
    model.addAttribute("request", new SaveOrUpdateIndicatorModel());
  }

  @GetMapping
  public @NonNull String all(
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    model.addAttribute("indicators", getAllUserIndicatorsUseCase.execute(user.savedId()));
    return "user-indicator/list";
  }

  @GetMapping("/add")
  public @NonNull String save(
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    return "user-indicator/save-form";
  }

  @PostMapping("/save")
  public @NonNull String save(
      @NonNull @ModelAttribute SaveOrUpdateIndicatorModel request,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull RedirectAttributes redirectAttributes,
      @NonNull Model model
  ) {
    try {
      saveOrUpdateIndicatorUseCase.execute(mapper.toSaveOrUpdateRequest(request, user.savedId()));
      redirectAttributes.addFlashAttribute("successMessage", "Индикатор успешно сохранен");
      return "redirect:/user-indicators";
    } catch (Exception e) {
      model.addAttribute("errorMessage", e.getMessage());
      model.addAttribute("request", request);
      return "user-indicator/save-form";
    }
  }

  @GetMapping("/{id}/edit")
  public @NonNull String update(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      IndicatorDetailsResponse response =
          getIndicatorByIdAndUserIdUseCase.execute(id, user.savedId());
      model.addAttribute("request", mapper.toSaveOrUpdateModel(response));
      return "user-indicator/save-form";
    } catch (Exception e) {
      redirectAttributes.addAttribute("errorMessage", e.getMessage());
      return "redirect:/user-indicators";
    }
  }

  @PostMapping("/{id}/edit")
  public @NonNull String update(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model,
      @NonNull @ModelAttribute SaveOrUpdateIndicatorModel request
  ) {
    try {
      saveOrUpdateIndicatorUseCase.execute(mapper.toSaveOrUpdateRequest(request, user.savedId()));
      model.addAttribute("successMessage", "Индикатор успешно сохранен");
      return "user-indicator/save-form";
    } catch (Exception e) {
      model.addAttribute("errorMessage", e.getMessage());
      model.addAttribute("request", request);
      return "user-indicator/save-form";
    }
  }

  @DeleteMapping("/{id}")
  public @NonNull String delete(
      @NonNull @PathVariable Long id,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      deleteIndicatorByIdAndUserIdUseCase.execute(id, user.savedId());
      redirectAttributes.addAttribute("successMessage", "Индикатор успешно удален");
    } catch (Exception e) {
      redirectAttributes.addAttribute("errorMessage", e.getMessage());
    }

    return "redirect:/user-indicators";
  }
}
