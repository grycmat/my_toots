import 'dart:convert';

import 'account.dart';
import 'status.dart';

class Notification {
  String? id;
  String? type;
  DateTime? createdAt;
  Account? account;
  Status? status;

  Notification({
    this.id,
    this.type,
    this.createdAt,
    this.account,
    this.status,
  });

  @override
  String toString() {
    return 'Notification(id: $id, type: $type, createdAt: $createdAt, account: $account, status: $status)';
  }

  factory Notification.fromMap(Map<String, dynamic> data) => Notification(
        id: data['id'] as String?,
        type: data['type'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        account: data['account'] == null
            ? null
            : Account.fromMap(data['account'] as Map<String, dynamic>),
        status: data['status'] == null
            ? null
            : Status.fromMap(data['status'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'created_at': createdAt?.toIso8601String(),
        'account': account?.toMap(),
        'status': status?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Notification].
  factory Notification.fromJson(String data) {
    return Notification.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Notification] to a JSON string.
  String toJson() => json.encode(toMap());
}
