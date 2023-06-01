import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';
import 'package:my_toots/widgets/status/status_media_attachment_details.widget.dart';

class MediaAttachmentWidget extends StatelessWidget {
  const MediaAttachmentWidget({required this.mediaAttachments, Key? key})
      : super(key: key);
  final List<MediaAttachment> mediaAttachments;

  @override
  Widget build(BuildContext context) {
    if (mediaAttachments.length == 1) {
      return mediaAttachments.first.type == 'image'
          ? StatusMediaAttachmentDetailsWidget(
              mediaAttachment: mediaAttachments.first)
          : Container();
    }

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
            mediaAttachment.type == 'image'
                ? StatusMediaAttachmentDetailsWidget(
                    mediaAttachment: mediaAttachment)
                : Container()
        ],
      ),
    );
  }
}
