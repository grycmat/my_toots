import 'dart:convert';

import 'meta.dart';

class MediaAttachment {
  String id;
  String type;
  String url;
  String previewUrl;
  String? remoteUrl;
  String? textUrl;
  Meta? meta;
  String? description;
  String? blurhash;

  MediaAttachment({
    required this.id,
    required this.type,
    required this.url,
    required this.previewUrl,
    this.remoteUrl,
    this.textUrl,
    this.meta,
    this.description,
    this.blurhash,
  });

  @override
  String toString() {
    return 'MediaAttachment(id: $id, type: $type, url: $url, previewUrl: $previewUrl, remoteUrl: $remoteUrl, textUrl: $textUrl, meta: $meta, description: $description, blurhash: $blurhash)';
  }

  factory MediaAttachment.fromMap(Map<String, dynamic> data) => MediaAttachment(
        id: data['id'] as String,
        type: data['type'] as String,
        url: data['url'] as String,
        previewUrl: data['preview_url'] as String,
        remoteUrl: data['remote_url'] as String?,
        textUrl: data['text_url'] as String?,
        meta: data['meta'] == null
            ? null
            : Meta.fromMap(data['meta'] as Map<String, dynamic>),
        description: data['description'] as String?,
        blurhash: data['blurhash'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'url': url,
        'preview_url': previewUrl,
        'remote_url': remoteUrl,
        'text_url': textUrl,
        'meta': meta?.toMap(),
        'description': description,
        'blurhash': blurhash,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MediaAttachment].
  factory MediaAttachment.fromJson(String data) {
    return MediaAttachment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MediaAttachment] to a JSON string.
  String toJson() => json.encode(toMap());
}
