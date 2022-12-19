import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/models/account/account.dart';

class AccountBasicInfoWidget extends StatelessWidget {
  const AccountBasicInfoWidget({required this.account, Key? key})
      : super(key: key);
  final Account account;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: account.avatarStatic,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                      child: Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              account.statusesCount.toString(),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Posts',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFB3B3B3),
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                      child: Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              account.followersCount.toString(),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Followers',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFB3B3B3),
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                      child: Container(
                        width: 70,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              account.followingCount.toString(),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Following',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFB3B3B3),
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      Text(
        account.displayName,
      ),
      Text(
        account.acct,
        style: const TextStyle(
          color: Color(0xFF787878),
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
    ]);
  }
}
