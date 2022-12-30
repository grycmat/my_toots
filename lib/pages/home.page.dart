import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:my_toots/pages/notifications.page.dart';
import 'package:my_toots/pages/public_timeline.page.dart';
import 'package:my_toots/pages/timeline.page.dart';
import 'package:my_toots/services/theme.service.dart';
import 'package:my_toots/widgets/compose_fab.widget.dart';

class HomePage extends StatefulWidget with GetItStatefulWidgetMixin {
  HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with TickerProviderStateMixin, GetItStateMixin {
  int _pageIndex = 0;
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _pageIndex = _tabController.index;
      });
    });
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
      resizeToAvoidBottomInset: true,
      floatingActionButton: const ComposeFabWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          PopupMenuButton(
              elevation: 10,
              splashRadius: 10,
              itemBuilder: ((context) => [
                    PopupMenuItem(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wb_sunny_outlined),
                        Switch(
                            value: watchOnly((ThemeService s) => s.isDark),
                            onChanged: (value) {
                              get<ThemeService>().setIsDark(value);
                            }),
                        Icon(Icons.nights_stay_outlined)
                      ],
                    )),
                    PopupMenuItem(child: Text('Logout'))
                  ])),
          // watchOnly((ThemeService s) => s.isDark)
          //     ? const Icon(CupertinoIcons.moon_stars)
          //     : const Icon(CupertinoIcons.sun_max),
        ],
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
              label: 'Home timeline',
            ),
            NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              label: 'Notifications',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.globe),
              label: 'Public timeline',
            ),
            NavigationDestination(
              icon: Icon(Icons.markunread_outlined),
              label: 'Direct Messages',
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
