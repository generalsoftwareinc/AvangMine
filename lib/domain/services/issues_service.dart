import 'dart:convert';
import 'dart:developer';
import 'package:avangmine_riverpod/domain/domain.dart';
import 'package:http/http.dart' as http;

Future<List<IssueStatus>?> getIssuesStatusService(ApiTools apiTools) async {
  try {
    Uri urlGen = Uri(
      scheme: apiTools.sheme,
      host: apiTools.host,
      path: 'issue_statuses.json',
    );
    final response =
        await http.get(urlGen, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return response.statusCode == 200
        ? IssueStatuses.fromJson(json.decode(response.body)).issueStatuses
        : null;
  } catch (e) {
    log('getIssuesStatusService: $e');
    return null;
  }
}

Future<ResponseIssue> getIssuesService(
    Map<String, dynamic>? args, ApiTools apiTools) async {
  try {
    Uri urlGen = Uri(
      scheme: apiTools.sheme,
      host: apiTools.host,
      path: 'issues.json',
      queryParameters: args,
    );
    final response =
        await http.get(urlGen, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return ResponseIssue(
        issues: Issues.fromJson(json.decode(response.body)),
        error: response.statusCode != 200);
  } catch (e) {
    log('getIssuesService: $e');
    return ResponseIssue(issues: null, error: true);
  }
}

Future<Issues?> getAssignedToMe(ApiTools apiTools) async {
  try {
    final url = Uri.parse(
        '${apiTools.sheme}://${apiTools.host}/issues.json?f[]=status_id&op[status_id]==&v[status_id][]=1&v[status_id][]=2&f[]=assigned_to_id&op[assigned_to_id]==&v[assigned_to_id][]=me&f[]=status_id&op[status_id]=o');
    var response =
        await http.get(url, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return Issues.fromJson(json.decode(response.body));
  } catch (e) {
    log('getAssignedToMe: $e');
    return null;
  }
}

Future<Issues?> getOverdueTasks(String date, ApiTools apiTools) async {
  try {
    final url = Uri.parse(
        '${apiTools.sheme}://${apiTools.host}/issues.json?f[]=status_id&op[status_id]==&v[status_id][]=1&v[status_id][]=2&f[]=assigned_to_id&op[assigned_to_id]==&v[assigned_to_id][]=me&f[]=due_date&op[due_date]=<=&v[due_date][]=$date');
    var response =
        await http.get(url, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return Issues.fromJson(json.decode(response.body));
  } catch (e) {
    log('getOverdueTasks: $e');
    return null;
  }
}

Future<int?> getIssueXProjectAssigned(int idProject, ApiTools apiTools) async {
  try {
    final url = Uri.parse(
        '${apiTools.sheme}://${apiTools.host}/issues.json?f[]=status_id&op[status_id]==&v[status_id][]=1&v[status_id][]=2&f[]=assigned_to_id&op[assigned_to_id]==&v[assigned_to_id][]=me&f[]=project_id&op[project_id]==&v[project_id][]=$idProject');
    var response =
        await http.get(url, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return Issues.fromJson(json.decode(response.body)).totalCount;
  } catch (e) {
    log('getIssueXProjectAssigned: $e');
    return null;
  }
}

Future<int?> getIssueXProjectByManager(int idProject, ApiTools apiTools) async {
  try {
    final url = Uri.parse(
        '${apiTools.sheme}://${apiTools.host}/issues.json?f[]=status_id&op[status_id]==&v[status_id][]=1&v[status_id][]=2&f[]=project_id&op[project_id]==&v[project_id][]=$idProject');
    var response =
        await http.get(url, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return Issues.fromJson(json.decode(response.body)).totalCount;
  } catch (e) {
    log('getIssueXProjectAssignedAll: $e');
    return null;
  }
}

Future<Issue?> getIssuesXIDService(int id, ApiTools apiTools) async {
  try {
    Uri urlGen = Uri(
        scheme: apiTools.sheme,
        host: apiTools.host,
        path: 'issues/$id.json',
        queryParameters: {
          'include':
              'children,relations,attachments,changesets,journals,watchers,allowed_statuses'
        });
    final response =
        await http.get(urlGen, headers: {'X-Redmine-API-Key': apiTools.apiKey});
    return response.statusCode == 200
        ? IssueOnly.fromJson(json.decode(response.body)).issue!
        : null;
  } catch (e) {
    log('getIssuesXIDService: $e');
    return null;
  }
}
