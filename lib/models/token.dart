import 'dart:convert';

class Token {
  String accessToken;
  String tokenType;
  String scope;
  int createdAt;

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.scope,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, tokenType: $tokenType, scope: $scope, createdAt: $createdAt)';
  }

  factory Token.fromMap(Map<String, dynamic> data) => Token(
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
  /// Parses the string and returns the resulting Json object as [Token].
  factory Token.fromJson(String data) {
    return Token.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Token] to a JSON string.
  String toJson() => json.encode(toMap());
}
