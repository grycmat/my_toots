import 'dart:convert';

import 'users.dart';

class Usage {
  Users? users;

  Usage({this.users});

  @override
  String toString() => 'Usage(users: $users)';

  factory Usage.fromMap(Map<String, dynamic> data) => Usage(
        users: data['users'] == null
            ? null
            : Users.fromMap(data['users'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'users': users?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Usage].
  factory Usage.fromJson(String data) {
    return Usage.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Usage] to a JSON string.
  String toJson() => json.encode(toMap());
}
