import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status.widget.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getIt.get<ApiService>().getHomeTimeline(),
        builder: (context, AsyncSnapshot<Response> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final response = snapshot.data!.data as List<dynamic>;
            final statuses = response.map((e) => Status.fromMap(e)).toList();
            return ListView.builder(
                itemBuilder: (_, index) {
                  return StatusWidget(
                    status: statuses[index],
                  );
                },
                itemCount: statuses.length);
          }
          return Container();
        },
      ),
    );
  }
}
