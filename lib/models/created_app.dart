import 'dart:convert';

class CreatedApp {
  String id;
  String name;
  String? website;
  String redirectUri;
  String clientId;
  String clientSecret;
  String vapidKey;

  CreatedApp({
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
    return 'CreatedApp(id: $id, name: $name, website: $website, redirectUri: $redirectUri, clientId: $clientId, clientSecret: $clientSecret, vapidKey: $vapidKey)';
  }

  factory CreatedApp.fromMap(Map<String, dynamic> data) => CreatedApp(
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
  /// Parses the string and returns the resulting Json object as [CreatedApp].
  factory CreatedApp.fromJson(String data) {
    return CreatedApp.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreatedApp] to a JSON string.
  String toJson() => json.encode(toMap());
}
