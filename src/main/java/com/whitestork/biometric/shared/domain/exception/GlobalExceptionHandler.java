package com.whitestork.biometric.shared.domain.exception;

import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.authorization.AuthorizationDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

  @ExceptionHandler(DomainException.class)
  public @NonNull String handleDomainException(
      @NonNull DomainException exception,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    log.error("Domain exception: {}", exception.getMessage(), exception);
    redirectAttributes.addFlashAttribute("errorMessage", exception.getMessage());
    return "redirect:/";
  }

  @ExceptionHandler(NoResourceFoundException.class)
  public @NonNull String handleNoResourceFoundException(
      @NonNull NoResourceFoundException exception
  ) {
    log.warn("NoResourceFound exception: {}", exception.getMessage());
    return "redirect:/";
  }

  @ExceptionHandler(AuthorizationDeniedException.class)
  public @NonNull String handleAuthorizationDeniedException(
      @NonNull AuthorizationDeniedException exception,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    log.warn("Ошибка авторизации: {}", exception.getAuthorizationResult());
    redirectAttributes.addFlashAttribute("errorMessage", "Ошибка авторизации");
    return "redirect:/";
  }

  @ExceptionHandler(Exception.class)
  public @NonNull String handleGenericException(
      @NonNull Exception exception,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    log.error("Unexpected error", exception);
    redirectAttributes.addFlashAttribute("errorMessage", "Произошла неизвестная ошибка");
    return "redirect:/";
  }
}