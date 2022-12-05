import 'dart:convert';

class Emoji {
  String? shortcode;
  String? url;
  String? staticUrl;
  bool? visibleInPicker;

  Emoji({this.shortcode, this.url, this.staticUrl, this.visibleInPicker});

  @override
  String toString() {
    return 'Emoji(shortcode: $shortcode, url: $url, staticUrl: $staticUrl, visibleInPicker: $visibleInPicker)';
  }

  factory Emoji.fromMap(Map<String, dynamic> data) => Emoji(
        shortcode: data['shortcode'] as String?,
        url: data['url'] as String?,
        staticUrl: data['static_url'] as String?,
        visibleInPicker: data['visible_in_picker'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'shortcode': shortcode,
        'url': url,
        'static_url': staticUrl,
        'visible_in_picker': visibleInPicker,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Emoji].
  factory Emoji.fromJson(String data) {
    return Emoji.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Emoji] to a JSON string.
  String toJson() => json.encode(toMap());
}
