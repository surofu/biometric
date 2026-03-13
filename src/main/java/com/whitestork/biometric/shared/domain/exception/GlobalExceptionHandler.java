package com.whitestork.biometric.shared.domain.exception;

import com.whitestork.biometric.shared.application.response.ErrorMessage;
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
    ErrorMessage errorMessage = ErrorMessage.from(exception);
    redirectAttributes.addFlashAttribute("errorMessage", errorMessage);
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
      @NonNull AuthorizationDeniedException ex,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    log.warn("Ошибка авторизации: {}", ex.getAuthorizationResult());
    ErrorMessage errorMessage = new ErrorMessage(
        "Ошибка авторизации",
        java.time.Instant.now().toString()
    );
    redirectAttributes.addFlashAttribute("errorMessage", errorMessage);
    return "redirect:/";
  }

  @ExceptionHandler(Exception.class)
  public @NonNull String handleGenericException(
      @NonNull Exception exception,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    log.error("Unexpected error", exception);
    ErrorMessage errorMessage = new ErrorMessage(
        "Произошла непредвиденная ошибка",
        java.time.Instant.now().toString()
    );
    redirectAttributes.addFlashAttribute("errorMessage", errorMessage);
    return "redirect:/";
  }
}