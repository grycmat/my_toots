import 'package:flutter/material.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/widgets/status_card.widget.dart';
import 'package:my_toots/widgets/status_details.widget.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({required this.status, Key? key}) : super(key: key);
  final Status status;

  Widget _showDetailsSheet(BuildContext context, Status status) =>
      StatusDetailsWidget(status);

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
