import 'dart:convert';

class Field {
  String? name;
  String? value;
  dynamic verifiedAt;

  Field({this.name, this.value, this.verifiedAt});

  @override
  String toString() {
    return 'Field(name: $name, value: $value, verifiedAt: $verifiedAt)';
  }

  factory Field.fromMap(Map<String, dynamic> data) => Field(
        name: data['name'] as String?,
        value: data['value'] as String?,
        verifiedAt: data['verified_at'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'value': value,
        'verified_at': verifiedAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Field].
  factory Field.fromJson(String data) {
    return Field.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Field] to a JSON string.
  String toJson() => json.encode(toMap());
}
