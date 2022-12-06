import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/o_auth_response.dart';
import 'package:my_toots/models/public_timline/account.dart';
import 'package:my_toots/services/api.service.dart';

class MyAccountPage extends StatelessWidget {
  MyAccountPage({Key? key}) : super(key: key);
  final ApiService _service = getIt.get<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
              future: _service.authorizeUser().then((response) {
                print(response);
                _service.userOAuth = OAuthResponse.fromMap(response.data);
                return _service.getMe();
              }),
              builder: (context, AsyncSnapshot<Response> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Container(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  var account = Account.fromMap(snapshot.data!.data);
                  return Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(account.displayName!),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(account.avatarStatic!),
                            ),
                            Column(
                              children: [
                                Icon(Icons.people_outline_outlined),
                                Text(
                                  account.followersCount.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.people_alt_outlined),
                                Text(
                                  account.followingCount.toString(),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(Icons.format_list_numbered_outlined),
                                Text(
                                  account.statusesCount.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  child: Text('fallback'),
                );
              }),
        ),
      ),
    );
  }
}
