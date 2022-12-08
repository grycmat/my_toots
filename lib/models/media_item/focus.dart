import 'dart:convert';

class Focus {
  double x;
  double y;

  Focus({required this.x, required this.y});

  @override
  String toString() => 'Focus(x: $x, y: $y)';

  factory Focus.fromMap(Map<String, dynamic> data) => Focus(
        x: (data['x'] as num).toDouble(),
        y: (data['y'] as num).toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'x': x,
        'y': y,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Focus].
  factory Focus.fromJson(String data) {
    return Focus.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Focus] to a JSON string.
  String toJson() => json.encode(toMap());
}
