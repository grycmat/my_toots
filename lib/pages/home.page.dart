import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/pages/notifications.page.dart';
import 'package:my_toots/pages/public_timeline.page.dart';
import 'package:my_toots/pages/timeline.page.dart';
import 'package:my_toots/services/widget.service.dart';
import 'package:my_toots/widgets/compose_fab.widget.dart';
import 'package:my_toots/widgets/compose_status.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _pageIndex = 0;
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const ComposeFabWidget(),
      appBar: AppBar(
        backgroundColor: Colors.green.shade50,
        scrolledUnderElevation: 1,
        title: const Text('Home'),
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
              icon: Icon(Icons.notifications_outlined),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.globe),
              label: '',
            ),
            NavigationDestination(
              icon: Icon(Icons.markunread_outlined),
              label: '',
            ),
          ]),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: const [
            Center(child: TimelinePage()),
            Center(child: NotificationsPage()),
            Center(child: PublicTimelinePage()),
            Center(child: Text('Messages')),
          ],
        ),
      ),
    );
  }
}
