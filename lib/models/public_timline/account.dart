import 'dart:convert';

class Account {
  String? id;
  String? username;
  String? acct;
  String? displayName;
  bool? locked;
  bool? bot;
  bool? discoverable;
  bool? group;
  DateTime? createdAt;
  String? note;
  String? url;
  String? avatar;
  String? avatarStatic;
  String? header;
  String? headerStatic;
  int? followersCount;
  int? followingCount;
  int? statusesCount;
  String? lastStatusAt;
  List<dynamic>? emojis;
  List<dynamic>? fields;

  Account({
    this.id,
    this.username,
    this.acct,
    this.displayName,
    this.locked,
    this.bot,
    this.discoverable,
    this.group,
    this.createdAt,
    this.note,
    this.url,
    this.avatar,
    this.avatarStatic,
    this.header,
    this.headerStatic,
    this.followersCount,
    this.followingCount,
    this.statusesCount,
    this.lastStatusAt,
    this.emojis,
    this.fields,
  });

  @override
  String toString() {
    return 'Account(id: $id, username: $username, acct: $acct, displayName: $displayName, locked: $locked, bot: $bot, discoverable: $discoverable, group: $group, createdAt: $createdAt, note: $note, url: $url, avatar: $avatar, avatarStatic: $avatarStatic, header: $header, headerStatic: $headerStatic, followersCount: $followersCount, followingCount: $followingCount, statusesCount: $statusesCount, lastStatusAt: $lastStatusAt, emojis: $emojis, fields: $fields)';
  }

  factory Account.fromMap(Map<String, dynamic> data) => Account(
        id: data['id'] as String?,
        username: data['username'] as String?,
        acct: data['acct'] as String?,
        displayName: data['display_name'] as String?,
        locked: data['locked'] as bool?,
        bot: data['bot'] as bool?,
        discoverable: data['discoverable'] as bool?,
        group: data['group'] as bool?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        note: data['note'] as String?,
        url: data['url'] as String?,
        avatar: data['avatar'] as String?,
        avatarStatic: data['avatar_static'] as String?,
        header: data['header'] as String?,
        headerStatic: data['header_static'] as String?,
        followersCount: data['followers_count'] as int?,
        followingCount: data['following_count'] as int?,
        statusesCount: data['statuses_count'] as int?,
        lastStatusAt: data['last_status_at'] as String?,
        emojis: data['emojis'] as List<dynamic>?,
        fields: data['fields'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'username': username,
        'acct': acct,
        'display_name': displayName,
        'locked': locked,
        'bot': bot,
        'discoverable': discoverable,
        'group': group,
        'created_at': createdAt?.toIso8601String(),
        'note': note,
        'url': url,
        'avatar': avatar,
        'avatar_static': avatarStatic,
        'header': header,
        'header_static': headerStatic,
        'followers_count': followersCount,
        'following_count': followingCount,
        'statuses_count': statusesCount,
        'last_status_at': lastStatusAt,
        'emojis': emojis,
        'fields': fields,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Account].
  factory Account.fromJson(String data) {
    return Account.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Account] to a JSON string.
  String toJson() => json.encode(toMap());
}
