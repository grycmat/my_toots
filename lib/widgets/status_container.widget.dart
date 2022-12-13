import 'package:flutter/material.dart';
import 'package:my_toots/getIt.instance.dart';
import 'package:my_toots/models/status/status.dart';
import 'package:my_toots/services/widget.service.dart';
import 'package:my_toots/widgets/status.widget.dart';
import 'package:my_toots/widgets/status_details.widget.dart';

class StatusContainerWidget extends StatelessWidget {
  const StatusContainerWidget({required this.status, Key? key})
      : super(key: key);
  final Status status;

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
          builder: (context) =>
              getIt.get<WidgetService>().getDetailsSheet(context, status),
        ),
        child: StatusWidget(status: status),
      ),
    );
  }
}
