import 'dart:convert';

class Application {
  String id;
  String name;
  String? website;
  String redirectUri;
  String clientId;
  String clientSecret;
  String vapidKey;

  Application({
    required this.id,
    required this.name,
    this.website,
    required this.redirectUri,
    required this.clientId,
    required this.clientSecret,
    required this.vapidKey,
  });

  @override
  String toString() {
    return 'Application(id: $id, name: $name, website: $website, redirectUri: $redirectUri, clientId: $clientId, clientSecret: $clientSecret, vapidKey: $vapidKey)';
  }

  factory Application.fromMap(Map<String, dynamic> data) => Application(
        id: data['id'] as String,
        name: data['name'] as String,
        website: data['website'] as String?,
        redirectUri: data['redirect_uri'] as String,
        clientId: data['client_id'] as String,
        clientSecret: data['client_secret'] as String,
        vapidKey: data['vapid_key'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'website': website,
        'redirect_uri': redirectUri,
        'client_id': clientId,
        'client_secret': clientSecret,
        'vapid_key': vapidKey,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Application].
  factory Application.fromJson(String data) {
    return Application.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Application] to a JSON string.
  String toJson() => json.encode(toMap());
}
