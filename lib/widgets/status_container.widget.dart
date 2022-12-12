import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/status.widget.dart';
import 'package:my_toots/widgets/status_details.widget.dart';

class StatusContainerWidget extends StatelessWidget {
  const StatusContainerWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

  Widget _showDetailsSheet(BuildContext context, Status status) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              width: 70,
              height: 5,
            ),
          ),
          StatusDetailsWidget(status),
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
        child: StatusWidget(status: status),
      ),
    );
  }
}
