package com.whitestork.biometric.shared.domain.exception;

import com.whitestork.biometric.shared.application.response.ErrorMessage;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authorization.AuthorizationDeniedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.resource.NoResourceFoundException;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

  @ExceptionHandler(DomainException.class)
  public String handleDomainException(
      DomainException exception,
      RedirectAttributes redirectAttributes
  ) {
    log.error("Domain exception: {}", exception.getMessage(), exception);
    ErrorMessage errorMessage = ErrorMessage.from(exception);
    redirectAttributes.addFlashAttribute("error", errorMessage);
    return "redirect:/error";
  }

  @ExceptionHandler(NoResourceFoundException.class)
  public String handleNoResourceFoundException(NoResourceFoundException exception) {
    log.warn("NoResourceFound exception: {}", exception.getMessage());
    return "redirect:/";
  }

  @ExceptionHandler(AuthorizationDeniedException.class)
  public String handleAuthorizationDeniedException(
      AuthorizationDeniedException ex,
      RedirectAttributes redirectAttributes
  ) {
    log.warn("Ошибка авторизации: {}", ex.getAuthorizationResult());
    ErrorMessage errorMessage = new ErrorMessage(
        "Ошибка авторизации",
        java.time.Instant.now().toString()
    );
    redirectAttributes.addFlashAttribute("error", errorMessage);
    return "redirect:/error";
  }

  @ExceptionHandler(Exception.class)
  public String handleGenericException(Exception ex, RedirectAttributes redirectAttributes) {
    log.error("Unexpected error", ex);
    ErrorMessage errorMessage = new ErrorMessage(
        "Произошла непредвиденная ошибка",
        java.time.Instant.now().toString()
    );
    redirectAttributes.addFlashAttribute("error", errorMessage);
    return "redirect:/error";
  }
}