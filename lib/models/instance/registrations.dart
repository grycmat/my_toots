import 'dart:convert';

class Registrations {
  bool enabled;
  bool approvalRequired;
  dynamic message;

  Registrations(
      {required this.enabled, required this.approvalRequired, this.message});

  @override
  String toString() {
    return 'Registrations(enabled: $enabled, approvalRequired: $approvalRequired, message: $message)';
  }

  factory Registrations.fromMap(Map<String, dynamic> data) => Registrations(
        enabled: data['enabled'] as bool,
        approvalRequired: data['approval_required'] as bool,
        message: data['message'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'enabled': enabled,
        'approval_required': approvalRequired,
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Registrations].
  factory Registrations.fromJson(String data) {
    return Registrations.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Registrations] to a JSON string.
  String toJson() => json.encode(toMap());
}
