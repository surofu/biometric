package com.whitestork.biometric.shared.application.service;

import java.util.Map;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClient;

@Component
public class GmailOAuth2TokenProvider {
  private static final String TOKEN_URI = "https://oauth2.googleapis.com/token";

  private final String clientId;
  private final String clientSecret;
  private final String refreshToken;
  private final RestClient restClient;

  public GmailOAuth2TokenProvider(
      @Value("${google.oauth.client-id}") String clientId,
      @Value("${google.oauth.client-secret}") String clientSecret,
      @Value("${google.oauth.refresh-token}") String refreshToken
  ) {
    this.clientId = clientId;
    this.clientSecret = clientSecret;
    this.refreshToken = refreshToken;
    this.restClient = RestClient.builder().baseUrl(TOKEN_URI).build();
  }

  public String getAccessToken() {
    MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
    body.add("client_id", clientId);
    body.add("client_secret", clientSecret);
    body.add("refresh_token", refreshToken);
    body.add("grant_type", "refresh_token");

    Map<?, ?> response = restClient.post()
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        .body(body)
        .retrieve()
        .onStatus(status -> !status.is2xxSuccessful(), (req, res) -> {
          String responseBody = new String(res.getBody().readAllBytes());
          throw new RuntimeException(
              "Failed to refresh Google OAuth2 token, status: "
                  + res.getStatusCode() + ", body: " + responseBody
          );
        })
        .body(Map.class);

    if (response == null || !response.containsKey("access_token")) {
      throw new RuntimeException("No access_token in Google OAuth2 response");
    }

    return (String) response.get("access_token");
  }
}