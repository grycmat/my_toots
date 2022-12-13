import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:my_toots/pages/media_preview.page.dart';
import 'package:shimmer/shimmer.dart';

class MediaAttachmentWidget extends StatelessWidget {
  const MediaAttachmentWidget({required this.mediaAttachments, Key? key})
      : super(key: key);
  final List<MediaAttachment> mediaAttachments;

  Widget _renderMediaItem(
          BuildContext context, MediaAttachment mediaAttachment) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MediaPreviewPage(
                    mediaAttachment: mediaAttachment,
                  ),
                ),
              );
            },
            child: Hero(
              tag: mediaAttachment.id,
              child: CachedNetworkImage(
                imageUrl: mediaAttachment.previewUrl,
                width: double.infinity,
                height: 230,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.green.shade100,
                  highlightColor: Colors.green.shade500,
                  child: Container(
                    height: 230,
                    width: double.infinity,
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    switch (mediaAttachments.length) {
      case 1:
        return _renderMediaItem(context, mediaAttachments.first);
      case 2:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (var mediaAttachment in mediaAttachments)
                _renderMediaItem(context, mediaAttachment)
            ],
          ),
        );
      case 4:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            children: <Widget>[
              for (var mediaAttachment in mediaAttachments)
                _renderMediaItem(context, mediaAttachment)
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
