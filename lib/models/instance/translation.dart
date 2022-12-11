import 'dart:convert';

class Translation {
  bool? enabled;

  Translation({this.enabled});

  @override
  String toString() => 'Translation(enabled: $enabled)';

  factory Translation.fromMap(Map<String, dynamic> data) => Translation(
        enabled: data['enabled'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Translation].
  factory Translation.fromJson(String data) {
    return Translation.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Translation] to a JSON string.
  String toJson() => json.encode(toMap());
}
