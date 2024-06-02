import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/lists_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = 'http://localhost:6036/list';

class ListRepository {
  final http.Client client;

  ListRepository({http.Client? client}) : client = client ?? http.Client();

  Future<String?> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<List<GroceryList>> fetchAllLists() async {
    final token = await _getToken();
    final response = await client.get(Uri.parse('$baseUrl/alllists'),
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((list) => GroceryList.fromJson(list)).toList();
    } else {
      throw Exception('Failed to load lists');
    }
  }

  Future<String> addList(String date, String content) async {
    final token = await _getToken();
    final response = await client.post(
      Uri.parse('$baseUrl/create'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({'date': date, 'content': content}),
    );
    if (response.statusCode == 201) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Failed to add list');
    }
  }

  Future<void> editList(String id, String date, String content) async {
    final token = await _getToken();
    final response = await client.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: json.encode({'date': date, 'content': content}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to edit list');
    }
  }

  Future<void> deleteList(String id) async {
    final token = await _getToken();
    final response = await client.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete list');
    }
  }
}
