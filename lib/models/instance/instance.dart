import 'dart:convert';

import 'configuration.dart';
import 'contact.dart';
import 'registrations.dart';
import 'rule.dart';
import 'thumbnail.dart';
import 'usage.dart';

class Instance {
  String domain;
  String title;
  String version;
  String sourceUrl;
  String description;
  Usage? usage;
  String? thumbnail;
  List<String> languages;
  Configuration configuration;
  Registrations registrations;
  Contact contact;
  List<Rule> rules;

  Instance({
    required this.domain,
    required this.title,
    required this.version,
    required this.sourceUrl,
    required this.description,
    required this.usage,
    this.thumbnail,
    required this.languages,
    required this.configuration,
    required this.registrations,
    required this.contact,
    required this.rules,
  });

  @override
  String toString() {
    return 'Instance(domain: $domain, title: $title, version: $version, sourceUrl: $sourceUrl, description: $description, usage: $usage, thumbnail: $thumbnail, languages: $languages, configuration: $configuration, registrations: $registrations, contact: $contact, rules: $rules)';
  }

  factory Instance.fromMap(Map<String, dynamic> data) => Instance(
        domain: data['domain'] as String,
        title: data['title'] as String,
        version: data['version'] as String,
        sourceUrl: data['source_url'] as String,
        description: data['description'] as String,
        usage: data['usage'] == null
            ? null
            : Usage.fromMap(data['usage'] as Map<String, dynamic>),
        thumbnail: data['thumbnail'] as String?,
        languages: data['languages'] as List<String>,
        configuration: Configuration.fromMap(
            data['configuration'] as Map<String, dynamic>),
        registrations: Registrations.fromMap(
            data['registrations'] as Map<String, dynamic>),
        contact: Contact.fromMap(data['contact'] as Map<String, dynamic>),
        rules: (data['rules'] as List<dynamic>)
            .map((e) => Rule.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'domain': domain,
        'title': title,
        'version': version,
        'source_url': sourceUrl,
        'description': description,
        'usage': usage?.toMap(),
        'thumbnail': thumbnail,
        'languages': languages,
        'configuration': configuration.toMap(),
        'registrations': registrations.toMap(),
        'contact': contact.toMap(),
        'rules': rules.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Instance].
  factory Instance.fromJson(String data) {
    return Instance.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Instance] to a JSON string.
  String toJson() => json.encode(toMap());
}
