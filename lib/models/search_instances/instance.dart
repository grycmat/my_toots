import 'dart:convert';

class Instance {
  String id;
  String name;
  DateTime? addedAt;
  DateTime? updatedAt;
  DateTime? checkedAt;
  int? uptime;
  bool? up;
  bool? dead;
  String? version;
  bool? ipv6;
  int? httpsScore;
  String? httpsRank;
  int? obsScore;
  String? obsRank;
  String? users;
  String? statuses;
  String? connections;
  bool? openRegistrations;
  dynamic info;
  String? thumbnail;
  String? thumbnailProxy;
  dynamic activeUsers;
  String? email;
  String? admin;

  Instance({
    required this.id,
    required this.name,
    this.addedAt,
    this.updatedAt,
    this.checkedAt,
    this.uptime,
    this.up,
    this.dead,
    this.version,
    this.ipv6,
    this.httpsScore,
    this.httpsRank,
    this.obsScore,
    this.obsRank,
    this.users,
    this.statuses,
    this.connections,
    this.openRegistrations,
    this.info,
    this.thumbnail,
    this.thumbnailProxy,
    this.activeUsers,
    this.email,
    this.admin,
  });

  @override
  String toString() {
    return 'Instance(id: $id, name: $name, addedAt: $addedAt, updatedAt: $updatedAt, checkedAt: $checkedAt, uptime: $uptime, up: $up, dead: $dead, version: $version, ipv6: $ipv6, httpsScore: $httpsScore, httpsRank: $httpsRank, obsScore: $obsScore, obsRank: $obsRank, users: $users, statuses: $statuses, connections: $connections, openRegistrations: $openRegistrations, info: $info, thumbnail: $thumbnail, thumbnailProxy: $thumbnailProxy, activeUsers: $activeUsers, email: $email, admin: $admin)';
  }

  factory Instance.fromMap(Map<String, dynamic> data) => Instance(
        id: data['id'] as String,
        name: data['name'] as String,
        addedAt: data['added_at'] == null
            ? null
            : DateTime.parse(data['added_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        checkedAt: data['checked_at'] == null
            ? null
            : DateTime.parse(data['checked_at'] as String),
        uptime: data['uptime'] as int?,
        up: data['up'] as bool?,
        dead: data['dead'] as bool?,
        version: data['version'] as String?,
        ipv6: data['ipv6'] as bool?,
        httpsScore: data['https_score'] as int?,
        httpsRank: data['https_rank'] as String?,
        obsScore: data['obs_score'] as int?,
        obsRank: data['obs_rank'] as String?,
        users: data['users'] as String?,
        statuses: data['statuses'] as String?,
        connections: data['connections'] as String?,
        openRegistrations: data['open_registrations'] as bool?,
        info: data['info'] as dynamic,
        thumbnail: data['thumbnail'] as String?,
        thumbnailProxy: data['thumbnail_proxy'] as String?,
        activeUsers: data['active_users'] as dynamic,
        email: data['email'] as String?,
        admin: data['admin'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'added_at': addedAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'checked_at': checkedAt?.toIso8601String(),
        'uptime': uptime,
        'up': up,
        'dead': dead,
        'version': version,
        'ipv6': ipv6,
        'https_score': httpsScore,
        'https_rank': httpsRank,
        'obs_score': obsScore,
        'obs_rank': obsRank,
        'users': users,
        'statuses': statuses,
        'connections': connections,
        'open_registrations': openRegistrations,
        'info': info,
        'thumbnail': thumbnail,
        'thumbnail_proxy': thumbnailProxy,
        'active_users': activeUsers,
        'email': email,
        'admin': admin,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Instance].
  factory Instance.fromJson(String data) {
    return Instance.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Instance] to a JSON string.
  String toJson() => json.encode(toMap());
}
