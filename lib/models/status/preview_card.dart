import 'dart:convert';

class PreviewCard {
  String url;
  String title;
  String description;
  String type;
  String authorName;
  String authorUrl;
  String providerName;
  String providerUrl;
  String html;
  int width;
  int height;
  String? image;
  String embedUrl;
  String? blurhash;

  PreviewCard({
    required this.url,
    required this.title,
    required this.description,
    required this.type,
    required this.authorName,
    required this.authorUrl,
    required this.providerName,
    required this.providerUrl,
    required this.html,
    required this.width,
    required this.height,
    this.image,
    required this.embedUrl,
    this.blurhash,
  });

  @override
  String toString() {
    return 'PreviewCard(url: $url, title: $title, description: $description, type: $type, authorName: $authorName, authorUrl: $authorUrl, providerName: $providerName, providerUrl: $providerUrl, html: $html, width: $width, height: $height, image: $image, embedUrl: $embedUrl, blurhash: $blurhash)';
  }

  factory PreviewCard.fromMap(Map<String, dynamic> data) => PreviewCard(
        url: data['url'] as String,
        title: data['title'] as String,
        description: data['description'] as String,
        type: data['type'] as String,
        authorName: data['author_name'] as String,
        authorUrl: data['author_url'] as String,
        providerName: data['provider_name'] as String,
        providerUrl: data['provider_url'] as String,
        html: data['html'] as String,
        width: data['width'] as int,
        height: data['height'] as int,
        image: data['image'] as String?,
        embedUrl: data['embed_url'] as String,
        blurhash: data['blurhash'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'url': url,
        'title': title,
        'description': description,
        'type': type,
        'author_name': authorName,
        'author_url': authorUrl,
        'provider_name': providerName,
        'provider_url': providerUrl,
        'html': html,
        'width': width,
        'height': height,
        'image': image,
        'embed_url': embedUrl,
        'blurhash': blurhash,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PreviewCard].
  factory PreviewCard.fromJson(String data) {
    return PreviewCard.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PreviewCard] to a JSON string.
  String toJson() => json.encode(toMap());

  PreviewCard copyWith({
    String? url,
    String? title,
    String? description,
    String? type,
    String? authorName,
    String? authorUrl,
    String? providerName,
    String? providerUrl,
    String? html,
    int? width,
    int? height,
    dynamic image,
    String? embedUrl,
    dynamic blurhash,
  }) {
    return PreviewCard(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      authorName: authorName ?? this.authorName,
      authorUrl: authorUrl ?? this.authorUrl,
      providerName: providerName ?? this.providerName,
      providerUrl: providerUrl ?? this.providerUrl,
      html: html ?? this.html,
      width: width ?? this.width,
      height: height ?? this.height,
      image: image ?? this.image,
      embedUrl: embedUrl ?? this.embedUrl,
      blurhash: blurhash ?? this.blurhash,
    );
  }
}
