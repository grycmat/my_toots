import 'dart:convert';

class History {
  String day;
  String accounts;
  String uses;

  History({required this.day, required this.accounts, required this.uses});

  @override
  String toString() {
    return 'History(day: $day, accounts: $accounts, uses: $uses)';
  }

  factory History.fromMap(Map<String, dynamic> data) => History(
        day: data['day'] as String,
        accounts: data['accounts'] as String,
        uses: data['uses'] as String,
      );

  Map<String, dynamic> toMap() => {
        'day': day,
        'accounts': accounts,
        'uses': uses,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [History].
  factory History.fromJson(String data) {
    return History.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [History] to a JSON string.
  String toJson() => json.encode(toMap());
}
