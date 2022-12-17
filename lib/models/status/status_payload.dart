import 'dart:convert';

class StatusPayload {
  final String status;
  final List<String>? mediaIds;
  String? inReplayToId;
  final bool? sensitive;
  final String? spoilerText;
  final String? visibility;
  final String? language;
  final String? scheduledAt;

  set inReplyToId(String? value) => inReplayToId = value;

  StatusPayload({
    required this.status,
    this.mediaIds,
    this.inReplayToId,
    this.sensitive,
    this.spoilerText,
    this.visibility,
    this.language,
    this.scheduledAt,
  });

  Map<String, dynamic> toMap() => {
        'status': status,
        'media_ids': mediaIds,
        'in_reply_to_id': inReplayToId,
        'sensitive': sensitive,
        'spoiler_text': spoilerText,
        'visibility': visibility,
        'language': language,
        'scheduled_at': scheduledAt,
      };

  String toJson() => json.encode(toMap());
}
