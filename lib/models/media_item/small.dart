import 'dart:convert';

class Small {
  int? width;
  int? height;
  String? size;
  double? aspect;

  Small({this.width, this.height, this.size, this.aspect});

  @override
  String toString() {
    return 'Small(width: $width, height: $height, size: $size, aspect: $aspect)';
  }

  factory Small.fromMap(Map<String, dynamic> data) => Small(
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
  /// Parses the string and returns the resulting Json object as [Small].
  factory Small.fromJson(String data) {
    return Small.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Small] to a JSON string.
  String toJson() => json.encode(toMap());
}
