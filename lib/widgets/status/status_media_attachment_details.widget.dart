import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:my_toots/pages/media_preview.page.dart';

class StatusMediaAttachmentDetailsWidget extends StatelessWidget {
  const StatusMediaAttachmentDetailsWidget(
      {required this.mediaAttachment, Key? key})
      : super(key: key);
  final MediaAttachment mediaAttachment;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
            // placeholder removed becaus of huge cache list (for better performance)
            // placeholder: (context, url) => Shimmer.fromColors(
            //   baseColor: Colors.green.shade100,
            //   highlightColor: Colors.green.shade500,
            //   child: Container(
            //     height: 230,
            //     width: double.infinity,
            //     color: Colors.white38,
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
