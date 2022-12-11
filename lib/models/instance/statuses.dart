import 'dart:convert';

class Statuses {
  int maxCharacters;
  int maxMediaAttachments;
  int charactersReservedPerUrl;

  Statuses({
    required this.maxCharacters,
    required this.maxMediaAttachments,
    required this.charactersReservedPerUrl,
  });

  @override
  String toString() {
    return 'Statuses(maxCharacters: $maxCharacters, maxMediaAttachments: $maxMediaAttachments, charactersReservedPerUrl: $charactersReservedPerUrl)';
  }

  factory Statuses.fromMap(Map<String, dynamic> data) => Statuses(
        maxCharacters: data['max_characters'] as int,
        maxMediaAttachments: data['max_media_attachments'] as int,
        charactersReservedPerUrl: data['characters_reserved_per_url'] as int,
      );

  Map<String, dynamic> toMap() => {
        'max_characters': maxCharacters,
        'max_media_attachments': maxMediaAttachments,
        'characters_reserved_per_url': charactersReservedPerUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Statuses].
  factory Statuses.fromJson(String data) {
    return Statuses.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Statuses] to a JSON string.
  String toJson() => json.encode(toMap());
}
