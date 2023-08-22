import 'dart:convert';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<TimeEntries?> getTimesEntriesService(
    Map<String, dynamic>? args, ApiTools apiTools) async {
  try {
    Uri urlGen = Uri(
      scheme: apiTools.sheme,
      host: apiTools.host,
      path: 'time_entries.json',
      queryParameters: args,
    );
    final response =
        await http.get(urlGen, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return response.statusCode == 200
        ? TimeEntries.fromJson(json.decode(response.body))
        : null;
  } catch (e) {
    debugPrint('$e');
    return null;
  }
}
