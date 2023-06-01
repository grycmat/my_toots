import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/pages/account.page.dart';

class StatusAccountRowWidget extends StatelessWidget {
  const StatusAccountRowWidget(
      {required this.account, this.avatarSize = 50, Key? key})
      : super(key: key);
  final Account account;
  final double avatarSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AccountPage(account: account),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: avatarSize,
            height: avatarSize,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: account.avatarStatic,
              fit: BoxFit.cover,
              // testing performance
              // placeholder: (_, __) => Shimmer.fromColors(
              //   baseColor: Theme.of(context).colorScheme.background,
              //   highlightColor: Theme.of(context).colorScheme.onBackground,
              //   child: Container(
              //     width: double.infinity,
              //     color: Colors.white70,
              //   ),
              // ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 4, 0, 4),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.displayName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(account.acct,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
