import 'dart:convert';

class OAuthResponse {
  String accessToken;
  String tokenType;
  String scope;
  int createdAt;

  OAuthResponse({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'OAuthResponse(accessToken: $accessToken, tokenType: $tokenType, scope: $scope, createdAt: $createdAt)';
  }

  factory OAuthResponse.fromMap(Map<String, dynamic> data) => OAuthResponse(
        accessToken: data['access_token'] as String,
        tokenType: data['token_type'] as String,
        scope: data['scope'] as String,
        createdAt: data['created_at'] as int,
      );

  Map<String, dynamic> toMap() => {
        'access_token': accessToken,
        'token_type': tokenType,
        'scope': scope,
        'created_at': createdAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OAuthResponse].
  factory OAuthResponse.fromJson(String data) {
    return OAuthResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OAuthResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
