import 'package:flutter/material.dart';
import 'package:my_toots/pages/web_login.page.dart';

class InstancesListPage extends StatefulWidget {
  const InstancesListPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<InstancesListPage> createState() => _InstancesListPageState();
}

class _InstancesListPageState extends State<InstancesListPage> {
  late final TextEditingController _controller;
  bool _isSearching = false;

  @override
  initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  prefixText: 'https://',
                  border: OutlineInputBorder(),
                  labelText: 'Find Instance',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => WebLoginPage(_controller.text),
                    ),
                  );
                },
                child: const Text('Log in'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
