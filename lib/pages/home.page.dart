import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/account/account.dart';
import 'package:my_toots/pages/timeline.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/compose_status.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _pageIndex = 0;
  late TabController _tabController;
  final _textEditingController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  Widget _getComposeWidget() => ComposeStatusWidget();

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            context: context,
            builder: (_) => _getComposeWidget(),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        scrolledUnderElevation: 1,
        title: FutureBuilder(
          future: getIt.get<ApiService>().getMe(),
          builder: (_, AsyncSnapshot<Account> snapshot) {
            if (snapshot.hasData) {
              return Row(
                children: [
                  // CircleAvatar(
                  //   radius: 30,
                  //   backgroundImage: NetworkImage(snapshot.data!.avatarStatic),
                  // ),
                  Text(snapshot.data!.acct),
                ],
              );
            }
            return Text('');
          },
        ),
      ),
      bottomNavigationBar: NavigationBar(
          elevation: 5,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          onDestinationSelected: (value) {
            _tabController.animateTo(value);
            setState(() {
              _pageIndex = value;
            });
          },
          selectedIndex: _pageIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.mail),
              label: '',
            ),
          ]),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: TimelinePage()),
          Center(child: Text('Search')),
          Center(child: Text('Notifications')),
          Center(child: Text('Messages')),
        ],
      ),
    );
  }
}
