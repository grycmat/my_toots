import 'dart:convert';

import 'instance.dart';

class SearchInstances {
  List<Instance>? instances;

  SearchInstances({this.instances});

  @override
  String toString() => 'SearchInstances(instances: $instances)';

  factory SearchInstances.fromMap(Map<String, dynamic> data) {
    return SearchInstances(
      instances: (data['instances'] as List<dynamic>?)
          ?.map((e) => Instance.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'instances': instances?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SearchInstances].
  factory SearchInstances.fromJson(String data) {
    return SearchInstances.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SearchInstances] to a JSON string.
  String toJson() => json.encode(toMap());
}
