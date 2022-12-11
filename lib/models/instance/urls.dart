import 'dart:convert';

class Urls {
  String? streaming;

  Urls({this.streaming});

  @override
  String toString() => 'Urls(streaming: $streaming)';

  factory Urls.fromMap(Map<String, dynamic> data) => Urls(
        streaming: data['streaming'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'streaming': streaming,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Urls].
  factory Urls.fromJson(String data) {
    return Urls.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Urls] to a JSON string.
  String toJson() => json.encode(toMap());
}
