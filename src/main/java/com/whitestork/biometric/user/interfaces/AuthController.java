package com.whitestork.biometric.user.interfaces;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.request.RegisterUserRequest;
import com.whitestork.biometric.user.application.usecase.RegisterUserUseCase;
import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.RememberMeServices;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AuthController {
  private final RegisterUserUseCase registerUserUseCase;
  private final AuthenticationManager authenticationManager;
  private final SecurityContextRepository securityContextRepository;
  private final RememberMeServices rememberMeServices;

  @GetMapping("/register")
  public String registerPage(
      @AuthenticationPrincipal SecurityUser securityUser,
      Model model
  ) {
    if (securityUser != null) {
      return "redirect:/";
    }

    model.addAttribute("registerRequest", new RegisterUserRequest());
    return "auth/register";
  }

  @PostMapping("/register")
  public String register(
      @Valid @ModelAttribute RegisterUserRequest request,
      BindingResult result,
      HttpServletRequest httpRequest,
      HttpServletResponse httpResponse,
      Model model
  ) {
    if (result.hasErrors()) {
      model.addAttribute("registerRequest", new RegisterUserRequest().withEmail(request.email()));
      model.addAttribute("errorMessage", result.getAllErrors().getFirst().getDefaultMessage());
      return "auth/register";
    }

    if (!Objects.equals(request.password(), request.confirmPassword())) {
      model.addAttribute("registerRequest", new RegisterUserRequest().withEmail(request.email()));
      model.addAttribute("errorMessage", "Пароли должны совпадать");
      return "auth/register";
    }

    try {
      registerUserUseCase.execute(request);
      authenticateUserAndSetSession(
          request.email(),
          request.password(),
          httpRequest,
          httpResponse
      );
      return "redirect:/";
    } catch (DomainException exception) {
      model.addAttribute("errorMessage", exception.getMessage());
      return "auth/register";
    } catch (Exception exception) {
      log.warn("Ошибка при автоматическом входе: {}", exception.getMessage(), exception);
      return "auth/register";
    }
  }

  private void authenticateUserAndSetSession(
      String email,
      String password,
      HttpServletRequest request,
      HttpServletResponse response
  ) {
    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
        email,
        password
    );
    Authentication authentication = authenticationManager.authenticate(authToken);
    SecurityContextHolder.getContext().setAuthentication(authentication);
    securityContextRepository.saveContext(
        SecurityContextHolder.getContext(),
        request,
        response
    );
    rememberMeServices.loginSuccess(request, response, authentication);
  }

  @GetMapping("/login")
  public String loginPage(
      @RequestParam(required = false) String error,
      @RequestParam(required = false) String logout,
      @AuthenticationPrincipal SecurityUser securityUser,
      Model model
  ) {
    if (error != null) {
      model.addAttribute("errorMessage", "Неверный email или пароль");
    }
    if (logout != null) {
      model.addAttribute("infoMessage", "Вы вышли из системы");
    }
    if (securityUser != null) {
      return "redirect:/";
    }
    return "auth/login";
  }
}