import 'dart:convert';

import 'package:my_toots/models/account/emoji.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:my_toots/models/status/mention.dart';
import 'package:my_toots/models/status/poll.dart';
import 'package:my_toots/models/status/tag.dart';

import '../account/account.dart';
import 'status_application.dart';

class Status {
  String id;
  DateTime createdAt;
  String? inReplyToId;
  String? inReplyToAccountId;
  bool? sensitive;
  String? spoilerText;
  String? visibility;
  String? language;
  String? uri;
  String? url;
  int repliesCount;
  int reblogsCount;
  int favouritesCount;
  DateTime? editedAt;
  bool? favourited;
  bool? reblogged;
  bool? muted;
  bool? bookmarked;
  String content;
  List<dynamic>? filtered;
  Status? reblog;
  StatusApplication? application;
  Account account;
  List<MediaAttachment> mediaAttachments;
  List<Mention>? mentions;
  List<Tag>? tags;
  List<Emoji>? emojis;
  dynamic card;
  Poll? poll;

  Status({
    required this.id,
    required this.createdAt,
    this.inReplyToId,
    this.inReplyToAccountId,
    this.sensitive,
    this.spoilerText,
    this.visibility,
    this.language,
    this.uri,
    this.url,
    required this.repliesCount,
    required this.reblogsCount,
    required this.favouritesCount,
    required this.editedAt,
    required this.favourited,
    required this.reblogged,
    this.muted,
    this.bookmarked,
    required this.content,
    this.filtered,
    this.reblog,
    this.application,
    required this.account,
    required this.mediaAttachments,
    this.mentions,
    this.tags,
    this.emojis,
    this.card,
    this.poll,
  });

  @override
  String toString() {
    return 'Status(id: $id, createdAt: $createdAt, inReplyToId: $inReplyToId, inReplyToAccountId: $inReplyToAccountId, sensitive: $sensitive, spoilerText: $spoilerText, visibility: $visibility, language: $language, uri: $uri, url: $url, repliesCount: $repliesCount, reblogsCount: $reblogsCount, favouritesCount: $favouritesCount, editedAt: $editedAt, favourited: $favourited, reblogged: $reblogged, muted: $muted, bookmarked: $bookmarked, content: $content, filtered: $filtered, reblog: $reblog, application: $application, account: $account, mediaAttachments: $mediaAttachments, mentions: $mentions, tags: $tags, emojis: $emojis, card: $card, poll: $poll)';
  }

  factory Status.fromMap(Map<String, dynamic> data) => Status(
        id: data['id'] as String,
        createdAt: DateTime.parse(data['created_at']),
        inReplyToId: data['in_reply_to_id'] as dynamic,
        inReplyToAccountId: data['in_reply_to_account_id'] as dynamic,
        sensitive: data['sensitive'] as bool?,
        spoilerText: data['spoiler_text'] as String?,
        visibility: data['visibility'] as String?,
        language: data['language'] as String?,
        uri: data['uri'] as String?,
        url: data['url'] as String?,
        repliesCount: data['replies_count'] as int,
        reblogsCount: data['reblogs_count'] as int,
        favouritesCount: data['favourites_count'] as int,
        editedAt: data['edited_at'] == null
            ? null
            : DateTime.parse(data['edited_at'] as String),
        favourited: data['favourited'],
        reblogged: data['reblogged'] as bool,
        muted: data['muted'] as bool?,
        bookmarked: data['bookmarked'] as bool?,
        content: data['content'] as String,
        filtered: data['filtered'] as List<dynamic>?,
        reblog: data['reblog'] == null
            ? null
            : Status.fromMap(data['reblog'] as Map<String, dynamic>),
        application: data['application'] == null
            ? null
            : StatusApplication.fromMap(
                data['application'] as Map<String, dynamic>),
        account: Account.fromMap(data['account'] as Map<String, dynamic>),
        mediaAttachments: data['media_attachments'] == null
            ? []
            : (data['media_attachments'] as List<dynamic>)
                .map((e) => MediaAttachment.fromMap(e as Map<String, dynamic>))
                .toList(),
        mentions: (data['mentions'] as List<dynamic>?)
            ?.map((e) => Mention.fromMap(e as Map<String, dynamic>))
            .toList(),
        tags: (data['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromMap(e as Map<String, dynamic>))
            .toList(),
        emojis: (data['emojis'] as List<dynamic>?)
            ?.map((e) => Emoji.fromMap(e as Map<String, dynamic>))
            .toList(),
        card: data['card'] as dynamic,
        poll: data['poll'] == null
            ? null
            : Poll.fromMap(data['poll'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'created_at': createdAt.toIso8601String(),
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
        'application': application?.toMap(),
        'account': account.toMap(),
        'media_attachments': mediaAttachments,
        'mentions': mentions,
        'tags': tags,
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
