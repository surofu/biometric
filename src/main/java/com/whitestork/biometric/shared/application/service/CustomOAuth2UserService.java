package com.whitestork.biometric.shared.application.service;

import com.whitestork.biometric.user.application.service.UserProvider;
import com.whitestork.biometric.user.application.service.UserSaver;
import com.whitestork.biometric.user.domain.User;
import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
  private final UserProvider userProvider;
  private final UserSaver userSaver;

  @Override
  public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
    OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);
//    oAuth2User.getAttributes().forEach((key, value) -> System.out.printf("%s: %s\n", key, value));

    String email = oAuth2User.getAttribute("email");
    if (email == null) {
      throw new OAuth2AuthenticationException("Email не получен от Google");
    }

    try {
      User user = userProvider.withEmail(email);

      if (!user.emailVerified()) {
        User savedUser = userSaver.save(user.withEmailVerified(true));
        return new SecurityUser(savedUser);
      }

      return new SecurityUser(user);
    } catch (Exception e) {
      User savedUser = userSaver.save(User.verifiedByGoogle(email));
      return new SecurityUser(savedUser);
    }
  }
}