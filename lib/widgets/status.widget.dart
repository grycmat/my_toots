import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/api.service.dart';
import 'package:my_toots/widgets/status_card.widget.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({required this.status, Key? key}) : super(key: key);
  final Status status;

  Widget _showDetailsSheet(BuildContext context, Status status) {
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
          StatusCardWidget(status: status),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      child: InkWell(
          onTap: () => showModalBottomSheet(
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                context: context,
                builder: (context) => _showDetailsSheet(context, status),
              ),
          child: StatusCardWidget(status: status)),
    );
  }
}
