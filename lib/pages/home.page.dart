import 'package:flutter/material.dart';
import 'package:my_toots/pages/timeline.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _pageIndex = 0;
  late TabController _tabController;

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
      appBar: AppBar(
        title: const Text('Title'),
      ),
      bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            _tabController.animateTo(value);
            setState(() {
              _pageIndex = value;
            });
          },
          selectedIndex: _pageIndex,
          destinations: const [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.search),
              label: 'Search',
            ),
            NavigationDestination(
              icon: const Icon(Icons.notifications),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: const Icon(Icons.mail),
              label: 'Messages',
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
