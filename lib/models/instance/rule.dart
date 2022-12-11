import 'dart:convert';

class Rule {
  String id;
  String text;

  Rule({required this.id, required this.text});

  @override
  String toString() => 'Rule(id: $id, text: $text)';

  factory Rule.fromMap(Map<String, dynamic> data) => Rule(
        id: data['id'] as String,
        text: data['text'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rule].
  factory Rule.fromJson(String data) {
    return Rule.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rule] to a JSON string.
  String toJson() => json.encode(toMap());
}
