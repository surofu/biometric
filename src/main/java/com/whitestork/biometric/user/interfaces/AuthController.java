package com.whitestork.biometric.user.interfaces;

import com.whitestork.biometric.user.application.mapper.UserMapper;
import com.whitestork.biometric.user.application.usecase.ChangePasswordUseCase;
import com.whitestork.biometric.user.application.usecase.RegisterUserUseCase;
import com.whitestork.biometric.user.application.usecase.VerifyTokenUseCase;
import com.whitestork.biometric.user.domain.User;
import com.whitestork.biometric.user.interfaces.model.ChangePasswordModel;
import com.whitestork.biometric.user.interfaces.model.RegisterUserModel;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Slf4j
@Controller
@RequiredArgsConstructor
public class AuthController {
  private final RegisterUserUseCase registerUserUseCase;
  private final SecurityContextRepository securityContextRepository;
  private final VerifyTokenUseCase verifyTokenUseCase;
  private final ChangePasswordUseCase changePasswordUseCase;
  private final UserDetailsService userDetailsService;
  private final UserMapper mapper;

  @GetMapping("/register")
  public @NonNull String registerPage(
      @Nullable @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    if (user != null) {
      return "redirect:/";
    }

    model.addAttribute("request", new RegisterUserModel());
    return "auth/register";
  }

  @GetMapping("/login")
  public @NonNull String loginPage(
      @Nullable @RequestParam(required = false) String error,
      @Nullable @RequestParam(required = false) String logout,
      @Nullable @AuthenticationPrincipal User user,
      HttpServletRequest request,
      Model model
  ) {
    if (error != null) {
      String sessionError = (String) request.getSession().getAttribute("errorMessage");
      model.addAttribute("errorMessage", sessionError != null
          ? sessionError
          : "Неверный email или пароль"
      );
      request.getSession().removeAttribute("errorMessage");
    }
    if (logout != null) {
      model.addAttribute("infoMessage", "Вы вышли из системы");
    }
    if (user != null) {
      return "redirect:/";
    }
    return "auth/login";
  }

  @PostMapping("/register")
  public @NonNull String register(
      @NonNull @ModelAttribute RegisterUserModel request,
      @NonNull HttpServletRequest httpRequest,
      @NonNull HttpServletResponse httpResponse,
      @NonNull Model model
  ) {
    if (!Objects.equals(request.getPassword(), request.getConfirmPassword())) {
      model.addAttribute("request", request);
      model.addAttribute("errorMessage", "Пароли должны совпадать");
      return "auth/register";
    }

    try {
      registerUserUseCase.execute(mapper.toRequest(request));
      authenticateUserAndSetSession(request.getEmail(), httpRequest, httpResponse);
      return "redirect:/";
//      return "redirect:/email-sent?email=" + request.email();
    } catch (Exception exception) {
      model.addAttribute("errorMessage", exception.getMessage());
      model.addAttribute("request", request);
      return "auth/register";
    }
  }

  @GetMapping("/email-sent")
  public @NonNull String emailSent(
      @RequestParam
      @NonNull String email,
      @Nullable @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    if (user != null) {
      return "redirect:/";
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
    } catch (Exception exception) {
      model.addAttribute("errorMessage", exception.getMessage());
      return "auth/login";
    }
  }

  @GetMapping("/change-password")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String changePassword(Model model) {
    model.addAttribute("request", new ChangePasswordModel());
    return "auth/change-password";
  }

  @PostMapping("/change-password")
  @PreAuthorize("isAuthenticated()")
  public String changePassword(
      @NonNull @ModelAttribute ChangePasswordModel request,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull HttpServletRequest httpRequest,
      @NonNull HttpServletResponse httpResponse,
      @NonNull Model model
  ) {
    if (!Objects.equals(
        request.getNewPassword(),
        request.getConfirmNewPassword()
    )) {
      model.addAttribute("request", request);
      model.addAttribute("errorMessage", "Новые пароли не совпадают");
      return "auth/change-password";
    }

    try {
      changePasswordUseCase.execute(mapper.toRequest(request, user.email()));
      authenticateUserAndSetSession(user.email(), httpRequest, httpResponse);
      return "redirect:/profile?passwordChanged";
    } catch (Exception exception) {
      log.error(exception.getMessage(), exception);
      model.addAttribute("request", request);
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