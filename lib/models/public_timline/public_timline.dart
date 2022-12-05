import 'dart:convert';

import 'account.dart';

class PublicTimline {
  String? id;
  DateTime? createdAt;
  dynamic inReplyToId;
  dynamic inReplyToAccountId;
  bool? sensitive;
  String? spoilerText;
  String? visibility;
  dynamic language;
  String? uri;
  String? url;
  int? repliesCount;
  int? reblogsCount;
  int? favouritesCount;
  dynamic editedAt;
  String? content;
  dynamic reblog;
  Account? account;
  List<dynamic>? mediaAttachments;
  List<dynamic>? mentions;
  List<dynamic>? tags;
  List<dynamic>? emojis;
  dynamic card;
  dynamic poll;

  PublicTimline({
    this.id,
    this.createdAt,
    this.inReplyToId,
    this.inReplyToAccountId,
    this.sensitive,
    this.spoilerText,
    this.visibility,
    this.language,
    this.uri,
    this.url,
    this.repliesCount,
    this.reblogsCount,
    this.favouritesCount,
    this.editedAt,
    this.content,
    this.reblog,
    this.account,
    this.mediaAttachments,
    this.mentions,
    this.tags,
    this.emojis,
    this.card,
    this.poll,
  });

  @override
  String toString() {
    return 'PublicTimline(id: $id, createdAt: $createdAt, inReplyToId: $inReplyToId, inReplyToAccountId: $inReplyToAccountId, sensitive: $sensitive, spoilerText: $spoilerText, visibility: $visibility, language: $language, uri: $uri, url: $url, repliesCount: $repliesCount, reblogsCount: $reblogsCount, favouritesCount: $favouritesCount, editedAt: $editedAt, content: $content, reblog: $reblog, account: $account, mediaAttachments: $mediaAttachments, mentions: $mentions, tags: $tags, emojis: $emojis, card: $card, poll: $poll)';
  }

  factory PublicTimline.fromMap(Map<String, dynamic> data) => PublicTimline(
        id: data['id'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        inReplyToId: data['in_reply_to_id'] as dynamic,
        inReplyToAccountId: data['in_reply_to_account_id'] as dynamic,
        sensitive: data['sensitive'] as bool?,
        spoilerText: data['spoiler_text'] as String?,
        visibility: data['visibility'] as String?,
        language: data['language'] as dynamic,
        uri: data['uri'] as String?,
        url: data['url'] as String?,
        repliesCount: data['replies_count'] as int?,
        reblogsCount: data['reblogs_count'] as int?,
        favouritesCount: data['favourites_count'] as int?,
        editedAt: data['edited_at'] as dynamic,
        content: data['content'] as String?,
        reblog: data['reblog'] as dynamic,
        account: data['account'] == null
            ? null
            : Account.fromMap(data['account'] as Map<String, dynamic>),
        mediaAttachments: data['media_attachments'] as List<dynamic>?,
        mentions: data['mentions'] as List<dynamic>?,
        tags: data['tags'] as List<dynamic>?,
        emojis: data['emojis'] as List<dynamic>?,
        card: data['card'] as dynamic,
        poll: data['poll'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt?.toIso8601String(),
        'in_reply_to_id': inReplyToId,
        'in_reply_to_account_id': inReplyToAccountId,
        'sensitive': sensitive,
        'spoiler_text': spoilerText,
        'visibility': visibility,
        'language': language,
        'uri': uri,
        'url': url,
        'replies_count': repliesCount,
        'reblogs_count': reblogsCount,
        'favourites_count': favouritesCount,
        'edited_at': editedAt,
        'content': content,
        'reblog': reblog,
        'account': account?.toMap(),
        'media_attachments': mediaAttachments,
        'mentions': mentions,
        'tags': tags,
        'emojis': emojis,
        'card': card,
        'poll': poll,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PublicTimline].
  factory PublicTimline.fromJson(String data) {
    return PublicTimline.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PublicTimline] to a JSON string.
  String toJson() => json.encode(toMap());
}
