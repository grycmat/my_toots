import 'dart:convert';

class Thumbnail {
  String url;
  String? blurhash;
  dynamic versions;

  Thumbnail({required this.url, this.blurhash, this.versions});

  @override
  String toString() {
    return 'Thumbnail(url: $url, blurhash: $blurhash, versions: $versions)';
  }

  factory Thumbnail.fromMap(Map<String, dynamic> data) => Thumbnail(
        url: data['url'] as String,
        blurhash: data['blurhash'] as String?,
        versions: data['versions'],
      );

  Map<String, dynamic> toMap() => {
        'url': url,
        'blurhash': blurhash,
        'versions': versions?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Thumbnail].
  factory Thumbnail.fromJson(String data) {
    return Thumbnail.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Thumbnail] to a JSON string.
  String toJson() => json.encode(toMap());
}
