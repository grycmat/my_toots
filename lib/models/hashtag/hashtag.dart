import 'dart:convert';

import 'history.dart';

class Hashtag {
  String name;
  String url;
  List<History> history;
  bool following;

  Hashtag(
      {required this.name,
      required this.url,
      required this.history,
      required this.following});

  @override
  String toString() {
    return 'Hashtag(name: $name, url: $url, history: $history, following: $following)';
  }

  factory Hashtag.fromMap(Map<String, dynamic> data) => Hashtag(
        name: data['name'] as String,
        url: data['url'] as String,
        history: (data['history'] as List<dynamic>)
            .map((e) => History.fromMap(e as Map<String, dynamic>))
            .toList(),
        following: data['following'] as bool,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
        'history': history.map((e) => e.toMap()).toList(),
        'following': following,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Hashtag].
  factory Hashtag.fromJson(String data) {
    return Hashtag.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Hashtag] to a JSON string.
  String toJson() => json.encode(toMap());
}
