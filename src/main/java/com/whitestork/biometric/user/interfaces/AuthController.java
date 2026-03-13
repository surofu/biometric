package com.whitestork.biometric.user.interfaces;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.request.ChangePasswordRequest;
import com.whitestork.biometric.user.application.request.RegisterUserRequest;
import com.whitestork.biometric.user.application.usecase.ChangePasswordUseCase;
import com.whitestork.biometric.user.application.usecase.RegisterUserUseCase;
import com.whitestork.biometric.user.application.usecase.VerifyTokenUseCase;
import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import com.whitestork.biometric.user.interfaces.model.ChangePasswordModel;
import com.whitestork.biometric.user.interfaces.model.RegisterUserModel;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.context.SecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AuthController {
  private final RegisterUserUseCase registerUserUseCase;
  private final SecurityContextRepository securityContextRepository;
  private final VerifyTokenUseCase verifyTokenUseCase;
  private final ChangePasswordUseCase changePasswordUseCase;
  private final UserDetailsService userDetailsService;

  @GetMapping("/register")
  public @NonNull String registerPage(
      @Nullable @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model
  ) {
    if (securityUser != null) {
      return "redirect:/";
    }

    model.addAttribute("registerModel", new RegisterUserModel());
    return "auth/register";
  }

  @GetMapping("/login")
  public @NonNull String loginPage(
      @Nullable @RequestParam(required = false) String error,
      @Nullable @RequestParam(required = false) String logout,
      @Nullable @AuthenticationPrincipal SecurityUser securityUser,
      HttpServletRequest request,
      Model model
  ) {
    if (error != null) {
      String sessionError = (String) request.getSession().getAttribute("errorMessage");
      model.addAttribute("errorMessage",
          sessionError != null ? sessionError : "Неверный email или пароль");
      request.getSession().removeAttribute("errorMessage");
    }
    if (logout != null) {
      model.addAttribute("infoMessage", "Вы вышли из системы");
    }
    if (securityUser != null) {
      return "redirect:/";
    }
    return "auth/login";
  }

  @PostMapping("/register")
  public @NonNull String register(
      @NonNull @Valid @ModelAttribute RegisterUserModel registerModel,
      @NonNull BindingResult result,
      @NonNull HttpServletRequest httpRequest,
      @NonNull HttpServletResponse httpResponse,
      @NonNull Model model
  ) {
    if (result.hasErrors()) {
      model.addAttribute("registerModel", registerModel);
      model.addAttribute("errorMessage", result.getAllErrors().getFirst().getDefaultMessage());
      return "auth/register";
    }

    if (!Objects.equals(registerModel.password(), registerModel.confirmPassword())) {
      model.addAttribute("registerModel", registerModel);
      model.addAttribute("errorMessage", "Пароли должны совпадать");
      return "auth/register";
    }

    try {
      RegisterUserRequest request = new RegisterUserRequest(
          registerModel.email(),
          registerModel.password()
      );
      registerUserUseCase.execute(request);
      authenticateUserAndSetSession(registerModel.email(), httpRequest, httpResponse);
      return "redirect:/";
//      return "redirect:/email-sent?email=" + request.email();
    } catch (DomainException exception) {
      model.addAttribute("errorMessage", exception.getMessage());
      model.addAttribute("registerModel", registerModel);
      return "auth/register";
    }
  }

  @GetMapping("/email-sent")
  public @NonNull String emailSent(
      @RequestParam
      @Validated
      @NotBlank(message = "Почта обязательна")
      @Email(regexp = "^[A-Za-z0-9+_.-]+@(.+)$", message = "Некорректный формат почты")
      @NonNull String email,
      @NonNull BindingResult result,
      @Nullable @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    if (securityUser != null) {
      return "redirect:/";
    }

    if (result.hasErrors()) {
      redirectAttributes.addFlashAttribute(
          "errorMessage",
          result.getAllErrors().getFirst().getDefaultMessage()
      );
      return "redirect:/register";
    }

    model.addAttribute("email", email);
    return "auth/email-sent";
  }

  @GetMapping("/verify-email")
  public @NonNull String verifyEmail(
      @NonNull @RequestParam String token,
      @NonNull HttpServletRequest httpRequest,
      @NonNull HttpServletResponse httpResponse,
      @NonNull Model model
  ) {
    try {
      String email = verifyTokenUseCase.execute(token);
      authenticateUserAndSetSession(email, httpRequest, httpResponse);
      return "redirect:/";
    } catch (DomainException e) {
      model.addAttribute("errorMessage", e.getMessage());
      return "auth/login";
    }
  }

  @GetMapping("/change-password")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String changePassword(Model model) {
    model.addAttribute("changePasswordModel", new ChangePasswordModel());
    return "auth/change-password";
  }

  @PostMapping("/change-password")
  @PreAuthorize("isAuthenticated()")
  public String changePassword(
      @NonNull @Valid @ModelAttribute ChangePasswordModel changePasswordModel,
      @NonNull BindingResult result,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull HttpServletRequest httpRequest,
      @NonNull HttpServletResponse httpResponse,
      @NonNull Model model
  ) {
    if (result.hasErrors()) {
      model.addAttribute("changePasswordModel", changePasswordModel);
      model.addAttribute("errorMessage", result.getAllErrors().getFirst().getDefaultMessage());
      return "auth/change-password";
    }

    if (!Objects.equals(changePasswordModel.newPassword(),
        changePasswordModel.confirmNewPassword())) {
      model.addAttribute("changePasswordModel", changePasswordModel);
      model.addAttribute("errorMessage", "Новые пароли не совпадают");
      return "auth/change-password";
    }

    try {
      ChangePasswordRequest request = new ChangePasswordRequest(
          securityUser.email(),
          changePasswordModel.oldPassword(),
          changePasswordModel.newPassword()
      );
      changePasswordUseCase.execute(request);
      authenticateUserAndSetSession(securityUser.email(), httpRequest, httpResponse);
      return "redirect:/profile?passwordChanged";
    } catch (DomainException exception) {
      model.addAttribute("changePasswordModel", changePasswordModel);
      model.addAttribute("errorMessage", exception.getMessage());
      return "auth/change-password";
    }
  }

  private void authenticateUserAndSetSession(
      @NonNull String email,
      @NonNull HttpServletRequest request,
      @NonNull HttpServletResponse response
  ) {
    UserDetails userDetails = userDetailsService.loadUserByUsername(email);
    UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
        userDetails,
        null,
        userDetails.getAuthorities()
    );
    SecurityContextHolder.getContext().setAuthentication(authToken);
    securityContextRepository.saveContext(
        SecurityContextHolder.getContext(),
        request,
        response
    );
  }
}