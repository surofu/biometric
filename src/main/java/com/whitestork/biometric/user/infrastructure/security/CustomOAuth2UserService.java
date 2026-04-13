package com.whitestork.biometric.user.infrastructure.security;

import com.whitestork.biometric.user.application.component.UserProvider;
import com.whitestork.biometric.user.application.component.UserSaver;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
  private final UserProvider userProvider;
  private final UserSaver userSaver;

  @Override
  public @NonNull OAuth2User loadUser(@NonNull OAuth2UserRequest userRequest)
      throws OAuth2AuthenticationException {
    OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);
    String email = oAuth2User.getAttribute("email");

    if (email == null) {
      throw new OAuth2AuthenticationException("Email не получен от Google");
    }

    try {
      User user = userProvider.withEmail(email);

      if (user.emailVerified()) {
        log.info("User {} logged in with authorities: {}", email, user.getAuthorities());
        return user;
      }

      return userSaver.save(user.withEmailVerified(true));
    } catch (Exception exception) {
      log.warn("Ошибка авторизации через Google: {}", exception.getMessage(), exception);
      return userSaver.save(User.verifiedByGoogle(email));
    }
  }
}