import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/status/preview_card.dart';

class LinkPreviewWidget extends StatelessWidget {
  const LinkPreviewWidget({required this.previewCard, Key? key})
      : super(key: key);
  final PreviewCard previewCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: previewCard.image != null
                      ? CachedNetworkImage(
                          imageUrl: previewCard.image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        previewCard.title,
                      ),
                      previewCard.authorName.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 8, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Icon(
                                    Icons.account_circle_rounded,
                                    size: 16,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                    child: Text(
                                      previewCard.authorName,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                      Text(
                        previewCard.description,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
