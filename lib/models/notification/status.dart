import 'dart:convert';

import 'account.dart';
import 'poll.dart';
import 'tag.dart';

class Status {
  String? id;
  DateTime? createdAt;
  dynamic inReplyToId;
  dynamic inReplyToAccountId;
  bool? sensitive;
  String? spoilerText;
  String? visibility;
  String? language;
  String? uri;
  String? url;
  int? repliesCount;
  int? reblogsCount;
  int? favouritesCount;
  dynamic editedAt;
  bool? favourited;
  bool? reblogged;
  bool? muted;
  bool? bookmarked;
  String? content;
  List<dynamic>? filtered;
  dynamic reblog;
  Account? account;
  List<dynamic>? mediaAttachments;
  List<dynamic>? mentions;
  List<Tag>? tags;
  List<dynamic>? emojis;
  dynamic card;
  Poll? poll;

  Status({
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
    this.favourited,
    this.reblogged,
    this.muted,
    this.bookmarked,
    this.content,
    this.filtered,
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
    return 'Status(id: $id, createdAt: $createdAt, inReplyToId: $inReplyToId, inReplyToAccountId: $inReplyToAccountId, sensitive: $sensitive, spoilerText: $spoilerText, visibility: $visibility, language: $language, uri: $uri, url: $url, repliesCount: $repliesCount, reblogsCount: $reblogsCount, favouritesCount: $favouritesCount, editedAt: $editedAt, favourited: $favourited, reblogged: $reblogged, muted: $muted, bookmarked: $bookmarked, content: $content, filtered: $filtered, reblog: $reblog, account: $account, mediaAttachments: $mediaAttachments, mentions: $mentions, tags: $tags, emojis: $emojis, card: $card, poll: $poll)';
  }

  factory Status.fromMap(Map<String, dynamic> data) => Status(
        id: data['id'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        inReplyToId: data['in_reply_to_id'] as dynamic,
        inReplyToAccountId: data['in_reply_to_account_id'] as dynamic,
        sensitive: data['sensitive'] as bool?,
        spoilerText: data['spoiler_text'] as String?,
        visibility: data['visibility'] as String?,
        language: data['language'] as String?,
        uri: data['uri'] as String?,
        url: data['url'] as String?,
        repliesCount: data['replies_count'] as int?,
        reblogsCount: data['reblogs_count'] as int?,
        favouritesCount: data['favourites_count'] as int?,
        editedAt: data['edited_at'] as dynamic,
        favourited: data['favourited'] as bool?,
        reblogged: data['reblogged'] as bool?,
        muted: data['muted'] as bool?,
        bookmarked: data['bookmarked'] as bool?,
        content: data['content'] as String?,
        filtered: data['filtered'] as List<dynamic>?,
        reblog: data['reblog'] as dynamic,
        account: data['account'] == null
            ? null
            : Account.fromMap(data['account'] as Map<String, dynamic>),
        mediaAttachments: data['media_attachments'] as List<dynamic>?,
        mentions: data['mentions'] as List<dynamic>?,
        tags: (data['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromMap(e as Map<String, dynamic>))
            .toList(),
        emojis: data['emojis'] as List<dynamic>?,
        card: data['card'] as dynamic,
        poll: data['poll'] == null
            ? null
            : Poll.fromMap(data['poll'] as Map<String, dynamic>),
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
        'favourited': favourited,
        'reblogged': reblogged,
        'muted': muted,
        'bookmarked': bookmarked,
        'content': content,
        'filtered': filtered,
        'reblog': reblog,
        'account': account?.toMap(),
        'media_attachments': mediaAttachments,
        'mentions': mentions,
        'tags': tags?.map((e) => e.toMap()).toList(),
        'emojis': emojis,
        'card': card,
        'poll': poll?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Status].
  factory Status.fromJson(String data) {
    return Status.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Status] to a JSON string.
  String toJson() => json.encode(toMap());
}
