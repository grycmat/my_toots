import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:shimmer/shimmer.dart';

class MediaAttachmentWidget extends StatelessWidget {
  const MediaAttachmentWidget({required this.mediaAttachments, Key? key})
      : super(key: key);
  final List<MediaAttachment> mediaAttachments;

  @override
  Widget build(BuildContext context) {
    switch (mediaAttachments.length) {
      case 1:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: mediaAttachments.first.previewUrl,
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
        );
      case 2:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [
              for (var mediaAttachment in mediaAttachments)
                CachedNetworkImage(
                  imageUrl: mediaAttachment.previewUrl,
                  width: double.infinity,
                  height: 115,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.green.shade100,
                    highlightColor: Colors.green.shade500,
                    child: Container(
                      height: 115,
                      width: double.infinity,
                      color: Colors.white38,
                    ),
                  ),
                )
            ],
          ),
        );
      case 4:
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            children: <Widget>[
              for (var mediaAttachment in mediaAttachments)
                CachedNetworkImage(
                  imageUrl: mediaAttachment.previewUrl,
                  width: double.infinity,
                  height: 115,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.green.shade100,
                    highlightColor: Colors.green.shade500,
                    child: Container(
                      height: 115,
                      width: double.infinity,
                      color: Colors.white38,
                    ),
                  ),
                )
            ],
          ),
        );
      default:
        return Container();
    }
  }
}
