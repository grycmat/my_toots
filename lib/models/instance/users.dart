import 'dart:convert';

class Users {
  int? activeMonth;

  Users({this.activeMonth});

  @override
  String toString() => 'Users(activeMonth: $activeMonth)';

  factory Users.fromMap(Map<String, dynamic> data) => Users(
        activeMonth: data['active_month'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'active_month': activeMonth,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Users].
  factory Users.fromJson(String data) {
    return Users.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Users] to a JSON string.
  String toJson() => json.encode(toMap());
}
