import 'dart:convert';

import 'focus.dart';
import 'original.dart';
import 'small.dart';

class Meta {
  Original? original;
  Small? small;
  Focus? focus;

  Meta({this.original, this.small, this.focus});

  @override
  String toString() {
    return 'Meta(original: $original, small: $small, focus: $focus)';
  }

  factory Meta.fromMap(Map<String, dynamic> data) => Meta(
        original: data['original'] == null
            ? null
            : Original.fromMap(data['original'] as Map<String, dynamic>),
        small: data['small'] == null
            ? null
            : Small.fromMap(data['small'] as Map<String, dynamic>),
        focus: data['focus'] == null
            ? null
            : Focus.fromMap(data['focus'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'original': original?.toMap(),
        'small': small?.toMap(),
        'focus': focus?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Meta].
  factory Meta.fromJson(String data) {
    return Meta.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Meta] to a JSON string.
  String toJson() => json.encode(toMap());
}
