import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/search_instances/instance.dart';
import 'package:my_toots/models/search_instances/search_instances.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/instance_search_result.widget.dart';

class InstancesListPage extends StatefulWidget {
  const InstancesListPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<InstancesListPage> createState() => _InstancesListPageState();
}

class _InstancesListPageState extends State<InstancesListPage> {
  final _controller = TextEditingController();
  final _apiService = getIt<ApiService>();
  bool _isSearching = false;
  List<Instance>? _instances;
  Timer? _debounce;

  @override
  initState() {
    super.initState();
    _controller.addListener(() {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 300), () {
        if (_controller.text.length > 2) {
          setState(() {
            _isSearching = true;
          });
          _apiService.searchInstances(_controller.text).then((value) {
            _isSearching = false;
            setState(() {
              _isSearching = false;
              _instances = SearchInstances.fromMap(value.data).instances;
            });
          });
        }
      });
    });
    _apiService.getSampleInstances().then((value) {
      final instances = SearchInstances.fromMap(value.data);
      setState(() {
        _instances = instances.instances;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    prefixText: 'https://',
                    border: const OutlineInputBorder(),
                    labelText: 'Find Instance',
                    suffix: _isSearching
                        ? const SizedBox(
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                          )
                        : null),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: _instances?.length,
                  itemBuilder: (context, index) => _instances != null
                      ? InstanceSearchResultWidget(instance: _instances![index])
                      : CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
