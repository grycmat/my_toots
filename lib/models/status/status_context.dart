import 'package:my_toots/models/status/status.dart';

class StatusContext {
  List<Status> ancestors;
  List<Status> descendants;

  StatusContext({required this.ancestors, required this.descendants});

  factory StatusContext.fromMap(Map<String, dynamic> data) => StatusContext(
        ancestors:
            List<Status>.from(data["ancestors"].map((x) => Status.fromMap(x))),
        descendants: List<Status>.from(
          data["descendants"].map(
            (x) => Status.fromMap(x),
          ),
        ),
      );
}
