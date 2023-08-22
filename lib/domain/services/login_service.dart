import 'dart:convert';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<User?> loginService(String user, String pass, String server) async {
  try {
    String encoded = base64.encode(utf8.encode("$user:$pass"));
    final split = server.split('://');
    Uri urlGen = Uri(
      scheme: split[0],
      host: split[1],
      path: '/users/current.json',
      queryParameters: {'include': 'memberships'},
    );
    final response =
        await http.get(urlGen, headers: {'Authorization': 'Basic $encoded'});
    return response.statusCode == 200
        ? UserOnly.fromJson(json.decode(response.body)).user
        : null;
  } catch (e) {
    debugPrint('loginService: $e');
    return null;
  }
}

Future<User?> verifyAuthService(ApiTools apiTools) async {
  try {
    Uri urlGen = Uri(
      scheme: apiTools.sheme,
      host: apiTools.host,
      path: '/users/current.json',
      queryParameters: {'include': 'memberships'},
    );
    final response =
        await http.get(urlGen, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return response.statusCode == 200
        ? UserOnly.fromJson(json.decode(response.body)).user
        : null;
  } catch (e) {
    debugPrint('$e');
    return null;
  }
}
