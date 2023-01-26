import 'dart:convert';

import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/hashtag/hashtag.dart';
import 'package:my_toots/models/status/status.dart';

class Search {
  List<Account> accounts;
  List<Status> statuses;
  List<Hashtag> hashtags;

  Search(
      {required this.accounts, required this.statuses, required this.hashtags});

  @override
  String toString() {
    return 'SearchResponse(accounts: $accounts, statuses: $statuses, hashtags: $hashtags)';
  }

  factory Search.fromMap(Map<String, dynamic> data) {
    return Search(
      accounts: (data['accounts'] as List<dynamic>)
          .map((e) => Account.fromMap(e as Map<String, dynamic>))
          .toList(),
      statuses: (data['statuses'] as List<dynamic>)
          .map((e) => Status.fromMap(e))
          .toList(),
      hashtags: (data['hashtags'] as List<dynamic>)
          .map((e) => Hashtag.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'accounts': accounts.map((e) => e.toMap()).toList(),
        'statuses': statuses,
        'hashtags': hashtags.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Search].
  factory Search.fromJson(String data) {
    return Search.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Search] to a JSON string.
  String toJson() => json.encode(toMap());
}
