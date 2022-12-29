import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/account_basic_info.widget.dart';
import 'package:my_toots/widgets/status_container.widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({required this.account, Key? key}) : super(key: key);
  final Account account;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<Status> statuses = [];

  @override
  void initState() {
    getIt.get<ApiService>().getTimelineById(widget.account.id).then((value) {
      setState(() {
        statuses = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.9),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.account.acct),
                  )),
              background: CachedNetworkImage(
                  imageUrl: widget.account.headerStatic, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Column(
                  children: [
                    AccountBasicInfoWidget(account: widget.account),
                    Html(data: widget.account.note!),
                    // Row(
                    //   children: const <Widget>[
                    //     Padding(
                    //       padding: EdgeInsets.all(8.0),
                    //       child: ChoiceChip(label: Text('Bio'), selected: true),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.all(8.0),
                    //       child:
                    //           ChoiceChip(label: Text('Posts'), selected: false),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, index) {
              return StatusContainerWidget(
                status: statuses[index],
              );
            }, childCount: statuses.length),
          ),
        ],
      ),
    );
  }
}
