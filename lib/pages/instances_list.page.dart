import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/search_instances/instance.dart';
import 'package:my_toots/models/search_instances/search_instances.dart';
import 'package:my_toots/pages/web_login.page.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/instance_search_result.widget.dart';

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
