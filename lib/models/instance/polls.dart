import 'dart:convert';

class Polls {
  int maxOptions;
  int maxCharactersPerOption;
  int minExpiration;
  int maxExpiration;

  Polls({
    required this.maxOptions,
    required this.maxCharactersPerOption,
    required this.minExpiration,
    required this.maxExpiration,
  });

  @override
  String toString() {
    return 'Polls(maxOptions: $maxOptions, maxCharactersPerOption: $maxCharactersPerOption, minExpiration: $minExpiration, maxExpiration: $maxExpiration)';
  }

  factory Polls.fromMap(Map<String, dynamic> data) => Polls(
        maxOptions: data['max_options'] as int,
        maxCharactersPerOption: data['max_characters_per_option'] as int,
        minExpiration: data['min_expiration'] as int,
        maxExpiration: data['max_expiration'] as int,
      );

  Map<String, dynamic> toMap() => {
        'max_options': maxOptions,
        'max_characters_per_option': maxCharactersPerOption,
        'min_expiration': minExpiration,
        'max_expiration': maxExpiration,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Polls].
  factory Polls.fromJson(String data) {
    return Polls.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Polls] to a JSON string.
  String toJson() => json.encode(toMap());
}
