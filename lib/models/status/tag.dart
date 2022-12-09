import 'dart:convert';

class Tag {
  String name;
  String url;

  Tag({required this.name, required this.url});

  @override
  String toString() => 'Tag(name: $name, url: $url)';

  factory Tag.fromMap(Map<String, dynamic> data) => Tag(
        name: data['name'] as String,
        url: data['url'] as String,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Tag].
  factory Tag.fromJson(String data) {
    return Tag.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Tag] to a JSON string.
  String toJson() => json.encode(toMap());
}
