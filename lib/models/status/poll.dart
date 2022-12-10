import 'dart:convert';

import 'package:my_toots/models/account/emoji.dart';

import 'option.dart';

class Poll {
  String id;
  DateTime expiresAt;
  bool expired;
  bool multiple;
  int votesCount;
  int votersCount;
  bool? voted;
  List<dynamic>? ownVotes;
  List<dynamic>? options;
  List<dynamic>? emojis;

  Poll({
    required this.id,
    required this.expiresAt,
    required this.expired,
    required this.multiple,
    required this.votesCount,
    required this.votersCount,
    this.voted,
    this.ownVotes,
    required this.options,
    this.emojis,
  });

  @override
  String toString() {
    return 'Poll(id: $id, expiresAt: $expiresAt, expired: $expired, multiple: $multiple, votesCount: $votesCount, votersCount: $votersCount, voted: $voted, ownVotes: $ownVotes, options: $options, emojis: $emojis)';
  }

  factory Poll.fromMap(Map<String, dynamic> data) => Poll(
      id: data['id'] as String,
      expiresAt: DateTime.parse(data['expires_at'] as String),
      expired: data['expired'] as bool,
      multiple: data['multiple'] as bool,
      votesCount: data['votes_count'] as int,
      votersCount: data['voters_count'] as int,
      voted: data['voted'] as bool?,
      ownVotes: data['own_votes'] as List<dynamic>?,
      options: (data['options'] as List<dynamic>?) == null
          ? []
          : data['options']
              ?.map((e) => Option.fromMap(e as Map<String, dynamic>))
              .toList(),
      emojis: (data['emojis'] as List<dynamic>?) == null
          ? []
          : data['emojis']
              ?.map((e) => Emoji.fromMap(e as Map<String, dynamic>))
              .toList());

  Map<String, dynamic> toMap() => {
        'id': id,
        'expires_at': expiresAt.toIso8601String(),
        'expired': expired,
        'multiple': multiple,
        'votes_count': votesCount,
        'voters_count': votersCount,
        'voted': voted,
        'own_votes': ownVotes,
        'options': options?.map((e) => e.toMap()).toList(),
        'emojis': emojis?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Poll].
  factory Poll.fromJson(String data) {
    return Poll.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Poll] to a JSON string.
  String toJson() => json.encode(toMap());
}
