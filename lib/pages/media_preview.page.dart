import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/media_attachment/media_attachment.dart';

class MediaPreviewPage extends StatelessWidget {
  const MediaPreviewPage({required this.mediaAttachment, Key? key})
      : super(key: key);
  final MediaAttachment mediaAttachment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media'),
      ),
      body: Center(
        child: Draggable(
          onDragEnd: (details) {
            if (details.offset.dy > 100) {
              Navigator.of(context).pop();
            }
          },
          axis: Axis.vertical,
          childWhenDragging: Container(),
          feedback: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              imageUrl: mediaAttachment.previewUrl,
              fit: BoxFit.cover),
          child: Hero(
            tag: mediaAttachment.id,
            child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width,
                imageUrl: mediaAttachment.previewUrl,
                fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
