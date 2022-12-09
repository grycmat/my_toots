import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/search_instances/instance.dart';
import 'package:my_toots/pages/web_login.page.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class InstanceSearchResultWidget extends StatelessWidget {
  const InstanceSearchResultWidget({required this.instance, Key? key})
      : super(key: key);
  final Instance instance;

  Widget _createImage(thumbnail) {
    if (thumbnail == null) {
      return Container(
        width: double.infinity,
        height: 130,
        color: Colors.red,
      );
    }

    return CachedNetworkImage(
      imageUrl: thumbnail!,
      width: double.infinity,
      height: 130,
      fit: BoxFit.cover,
      placeholder: (context, url) => SkeletonLoader(
        builder: Container(
          width: double.infinity,
          height: 130,
          color: Colors.grey[300],
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: double.infinity,
        height: 130,
        color: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WebLoginPage(instance),
            ),
          );
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 160,
                child: Stack(
                  alignment: const AlignmentDirectional(0, 1),
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0, -1),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: _createImage(instance.thumbnail),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0, 1),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(16, 0, 24, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 12),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF4B39EF),
                                      Color(0xFF39D2C0),
                                      Color(0xFFFF5963)
                                    ],
                                    stops: [0, 0.3, 1],
                                    begin: AlignmentDirectional(1, 0.98),
                                    end: AlignmentDirectional(-1, -0.98),
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      2, 2, 2, 2),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Color(0xFF101213),
                                      size: 32,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 0),
                child: Text(
                  instance.name,
                  style: const TextStyle(
                    color: Color(0xFF101213),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 4, 16, 12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.people_outline_outlined,
                      color: Color(0xFF101213),
                      size: 30,
                    ),
                    Icon(
                      Icons.lock_outlined,
                      color: Color(0xFF101213),
                      size: 30,
                    ),
                    Icon(
                      Icons.login_outlined,
                      color: Color(0xFF101213),
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
