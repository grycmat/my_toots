import 'dart:convert';

class Mention {
  String id;
  String username;
  String url;
  String acct;

  Mention(
      {required this.id,
      required this.username,
      required this.url,
      required this.acct});

  @override
  String toString() {
    return 'Mention(id: $id, username: $username, url: $url, acct: $acct)';
  }

  factory Mention.fromMap(Map<String, dynamic> data) => Mention(
        id: data['id'] as String,
        username: data['username'] as String,
        url: data['url'] as String,
        acct: data['acct'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'url': url,
        'acct': acct,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Mention].
  factory Mention.fromJson(String data) {
    return Mention.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Mention] to a JSON string.
  String toJson() => json.encode(toMap());
}
