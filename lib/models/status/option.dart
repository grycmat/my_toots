import 'dart:convert';

class Option {
  String title;
  int votesCount;

  Option({required this.title, required this.votesCount});

  @override
  String toString() => 'Option(title: $title, votesCount: $votesCount)';

  factory Option.fromMap(Map<String, dynamic> data) => Option(
        title: data['title'] as String,
        votesCount: data['votes_count'] as int,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'votes_count': votesCount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Option].
  factory Option.fromJson(String data) {
    return Option.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Option] to a JSON string.
  String toJson() => json.encode(toMap());
}
