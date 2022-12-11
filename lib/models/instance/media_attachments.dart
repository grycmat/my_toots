import 'dart:convert';

class MediaAttachments {
  List<String> supportedMimeTypes;
  int imageSizeLimit;
  int? imageMatrixLimit;
  int videoSizeLimit;
  int videoFrameRateLimit;
  int videoMatrixLimit;

  MediaAttachments({
    required this.supportedMimeTypes,
    required this.imageSizeLimit,
    required this.imageMatrixLimit,
    required this.videoSizeLimit,
    required this.videoFrameRateLimit,
    required this.videoMatrixLimit,
  });

  @override
  String toString() {
    return 'MediaAttachments(supportedMimeTypes: $supportedMimeTypes, imageSizeLimit: $imageSizeLimit, imageMatrixLimit: $imageMatrixLimit, videoSizeLimit: $videoSizeLimit, videoFrameRateLimit: $videoFrameRateLimit, videoMatrixLimit: $videoMatrixLimit)';
  }

  factory MediaAttachments.fromMap(Map<String, dynamic> data) {
    return MediaAttachments(
      supportedMimeTypes: data['supported_mime_types'] as List<String>,
      imageSizeLimit: data['image_size_limit'] as int,
      imageMatrixLimit: data['image_matrix_limit'] as int,
      videoSizeLimit: data['video_size_limit'] as int,
      videoFrameRateLimit: data['video_frame_rate_limit'] as int,
      videoMatrixLimit: data['video_matrix_limit'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
        'supported_mime_types': supportedMimeTypes,
        'image_size_limit': imageSizeLimit,
        'image_matrix_limit': imageMatrixLimit,
        'video_size_limit': videoSizeLimit,
        'video_frame_rate_limit': videoFrameRateLimit,
        'video_matrix_limit': videoMatrixLimit,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MediaAttachments].
  factory MediaAttachments.fromJson(String data) {
    return MediaAttachments.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MediaAttachments] to a JSON string.
  String toJson() => json.encode(toMap());
}
