import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/models/status/status_context.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status_card.widget.dart';

class StatusDetailsWidget extends StatefulWidget {
  final Status status;
  const StatusDetailsWidget(this.status, {Key? key}) : super(key: key);

  @override
  _StatusDetailsWidgetState createState() => _StatusDetailsWidgetState();
}

class _StatusDetailsWidgetState extends State<StatusDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.amber),
              height: 5,
              width: 50,
            ),
          ),
          StatusCardWidget(
            status: widget.status,
          ),
          FutureBuilder(
            future: getIt.get<ApiService>().getStatusContext(widget.status.id),
            builder: (context, AsyncSnapshot<StatusContext> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final statusContext = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (_, index) {
                      return StatusCardWidget(
                        status: statusContext.descendants[index],
                      );
                    },
                    itemCount: statusContext.descendants.length,
                  ),
                );
              }
              return Container();
            },
          )
        ],
      ),
    );
  }
}
