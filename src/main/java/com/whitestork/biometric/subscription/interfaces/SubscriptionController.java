package com.whitestork.biometric.subscription.interfaces;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.subscription.application.request.CreateSubscriptionRequest;
import com.whitestork.biometric.subscription.application.response.SubscriptionPageResponse;
import com.whitestork.biometric.subscription.application.usecase.CreateSubscriptionUseCase;
import com.whitestork.biometric.subscription.application.usecase.GetSubscriptionPageUseCase;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequestMapping("/subscription")
@RequiredArgsConstructor
public class SubscriptionController {

  private final GetSubscriptionPageUseCase getSubscriptionPageUseCase;
  private final CreateSubscriptionUseCase createSubscriptionUseCase;

  @GetMapping
  public String page(@AuthenticationPrincipal User user, Model model) {
    SubscriptionPageResponse response = getSubscriptionPageUseCase.execute(user);
    model.addAttribute("plan", response.plan());
    model.addAttribute("activeSubscription", response.activeSubscription());
    model.addAttribute("hasActive", response.hasActiveSubscription());
    return "subscription/checkout";
  }

  @PostMapping
  public String subscribe(
      @AuthenticationPrincipal User user,
      @ModelAttribute CreateSubscriptionRequest request,
      BindingResult bindingResult,
      Model model,
      RedirectAttributes redirectAttributes
  ) {
    if (bindingResult.hasErrors()) {
      SubscriptionPageResponse response = getSubscriptionPageUseCase.execute(user);
      model.addAttribute("plan", response.plan());
      model.addAttribute("activeSubscription", response.activeSubscription());
      model.addAttribute("hasActive", response.hasActiveSubscription());
      model.addAttribute("errors", bindingResult.getAllErrors());
      model.addAttribute("formRequest", request);
      return "subscription/checkout";
    }

    try {
      createSubscriptionUseCase.execute(user, request);
      redirectAttributes.addFlashAttribute("successMessage", "Подписка успешно оформлена!");
      return "redirect:/profile";
    } catch (DomainException e) {
      redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
      return "redirect:/subscription";
    }
  }
}