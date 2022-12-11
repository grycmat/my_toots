import 'dart:convert';

import 'accounts.dart';
import 'media_attachments.dart';
import 'polls.dart';
import 'statuses.dart';
import 'translation.dart';
import 'urls.dart';

class Configuration {
  Urls urls;
  Accounts accounts;
  Statuses statuses;
  MediaAttachments mediaAttachments;
  Polls polls;
  Translation translation;

  Configuration({
    required this.urls,
    required this.accounts,
    required this.statuses,
    required this.mediaAttachments,
    required this.polls,
    required this.translation,
  });

  @override
  String toString() {
    return 'Configuration(urls: $urls, accounts: $accounts, statuses: $statuses, mediaAttachments: $mediaAttachments, polls: $polls, translation: $translation)';
  }

  factory Configuration.fromMap(Map<String, dynamic> data) => Configuration(
        urls: Urls.fromMap(data['urls'] as Map<String, dynamic>),
        accounts: Accounts.fromMap(data['accounts'] as Map<String, dynamic>),
        statuses: Statuses.fromMap(data['statuses'] as Map<String, dynamic>),
        mediaAttachments: MediaAttachments.fromMap(
            data['media_attachments'] as Map<String, dynamic>),
        polls: Polls.fromMap(data['polls'] as Map<String, dynamic>),
        translation:
            Translation.fromMap(data['translation'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'urls': urls.toMap(),
        'accounts': accounts.toMap(),
        'statuses': statuses.toMap(),
        'media_attachments': mediaAttachments.toMap(),
        'polls': polls.toMap(),
        'translation': translation.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Configuration].
  factory Configuration.fromJson(String data) {
    return Configuration.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Configuration] to a JSON string.
  String toJson() => json.encode(toMap());
}
