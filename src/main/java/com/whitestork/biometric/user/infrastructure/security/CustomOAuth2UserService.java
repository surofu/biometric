package com.whitestork.biometric.user.infrastructure.security;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.component.UserProvider;
import com.whitestork.biometric.user.application.component.UserSaver;
import com.whitestork.biometric.user.domain.User;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
  private final UserProvider userProvider;
  private final UserSaver userSaver;

  @Override
  public @NonNull OAuth2User loadUser(
      @NonNull OAuth2UserRequest userRequest
  ) throws OAuth2AuthenticationException {
    OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);
    String email = oAuth2User.getAttribute("email");

    if (email == null) {
      throw new OAuth2AuthenticationException(
          "Не удалось получить электронную почту от сервиса Google"
      );
    }

    User user;

    try {
      user = userProvider.withEmail(email);
    } catch (DomainException exception) {
      HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
          .currentRequestAttributes())
          .getRequest();
      request.getSession().setAttribute("errorMessage", exception.getMessage());
      throw new OAuth2AuthenticationException("user.not.found");
    }

    if (user.emailVerified()) {
      return user;
    }

    return userSaver.save(user.withEmailVerified(true));
  }
}