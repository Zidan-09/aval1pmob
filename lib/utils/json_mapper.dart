import 'dart:convert';

class JsonMapper {
  static T toEntity<T>(String json, T Function(Map<String, dynamic>) fromJson) {
    final dynamic decoded = jsonDecode(json);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Expected a JSON object at the root.');
    }
    return fromJson(decoded);
  }

  static List<T> toEntityList<T>(
    String json, {
    String listKey = 'entries',
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    final dynamic decoded = jsonDecode(json);

    final dynamic rawList;
    if (decoded is Map<String, dynamic>) {
      if (!decoded.containsKey(listKey)) {
        throw FormatException('Missing "$listKey" key in JSON object.');
      }
      rawList = decoded[listKey];
    } else if (decoded is List) {
      rawList = decoded;
    } else {
      throw const FormatException('Unsupported JSON root type.');
    }

    if (rawList is! List) {
      throw FormatException('Expected "$listKey" to be a JSON array.');
    }
    if (rawList.isEmpty) {
      throw FormatException('Empty "$listKey" list in JSON.');
    }

    return rawList.map((item) {
      if (item is! Map<String, dynamic>) {
        throw const FormatException('Invalid entry: expected JSON object.');
      }
      return fromJson(item);
    }).toList();
  }
}
