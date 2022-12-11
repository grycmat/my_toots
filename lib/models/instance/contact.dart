import 'dart:convert';

import 'package:my_toots/models/account/account.dart';

class Contact {
  String email;
  Account account;

  Contact({required this.email, required this.account});

  @override
  String toString() => 'Contact(email: $email, account: $account)';

  factory Contact.fromMap(Map<String, dynamic> data) => Contact(
        email: data['email'] as String,
        account: Account.fromMap(data['account'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'email': email,
        'account': account.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Contact].
  factory Contact.fromJson(String data) {
    return Contact.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Contact] to a JSON string.
  String toJson() => json.encode(toMap());
}
