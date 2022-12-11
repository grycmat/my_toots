import 'dart:convert';

class Accounts {
  int maxFeaturedTags;

  Accounts({required this.maxFeaturedTags});

  @override
  String toString() => 'Accounts(maxFeaturedTags: $maxFeaturedTags)';

  factory Accounts.fromMap(Map<String, dynamic> data) => Accounts(
        maxFeaturedTags: data['max_featured_tags'] as int,
      );

  Map<String, dynamic> toMap() => {
        'max_featured_tags': maxFeaturedTags,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Accounts].
  factory Accounts.fromJson(String data) {
    return Accounts.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Accounts] to a JSON string.
  String toJson() => json.encode(toMap());
}
