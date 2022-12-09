import 'dart:convert';

class Original {
  int? width;
  int? height;
  String? size;
  double? aspect;

  Original({this.width, this.height, this.size, this.aspect});

  @override
  String toString() {
    return 'Original(width: $width, height: $height, size: $size, aspect: $aspect)';
  }

  factory Original.fromMap(Map<String, dynamic> data) => Original(
        width: data['width'] as int?,
        height: data['height'] as int?,
        size: data['size'] as String?,
        aspect: (data['aspect'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'width': width,
        'height': height,
        'size': size,
        'aspect': aspect,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Original].
  factory Original.fromJson(String data) {
    return Original.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Original] to a JSON string.
  String toJson() => json.encode(toMap());
}
