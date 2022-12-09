import 'dart:convert';

class StatusApplication {
  String? name;
  String? website;

  StatusApplication({this.name, this.website});

  @override
  String toString() => 'StatusApplication(name: $name, website: $website)';

  factory StatusApplication.fromMap(Map<String, dynamic> data) =>
      StatusApplication(
        name: data['name'] as String?,
        website: data['website'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'website': website,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StatusApplication].
  factory StatusApplication.fromJson(String data) {
    return StatusApplication.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StatusApplication] to a JSON string.
  String toJson() => json.encode(toMap());
}
