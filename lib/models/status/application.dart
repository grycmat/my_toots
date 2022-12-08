import 'dart:convert';

class Application {
  String? name;
  String? website;

  Application({this.name, this.website});

  @override
  String toString() => 'Application(name: $name, website: $website)';

  factory Application.fromMap(Map<String, dynamic> data) => Application(
        name: data['name'] as String?,
        website: data['website'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'website': website,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Application].
  factory Application.fromJson(String data) {
    return Application.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Application] to a JSON string.
  String toJson() => json.encode(toMap());
}
