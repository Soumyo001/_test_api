import 'dart:convert';
import 'package:basic_crud_operations/models/user.dart';
import 'package:basic_crud_operations/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserApi {
  final String baseUri = baseUrl;

  Future<List<User>> getAllUserData() async {
    List<User> userData = [];
    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List jsonData = jsonDecode(response.body);
        userData = jsonData.map((e) => User.fromJson(e)).toList();
      }
    } catch (e) {
      return userData;
    }
    return userData;
  }

  Future<User> getUserByID(int userID) async {
    User user = User(userId: 0, name: 'Not Found', address: 'Not Found');
    final uri = Uri.parse("$baseUri/$userID");
    late final http.Response response;
    try {
      response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        user = User.fromJson(json);
      }
    } catch (e) {
      return user;
    }
    return user;
  }

  Future<http.Response> addUser(User user) async {
    late final http.Response response;
    final uri = Uri.parse(baseUri);
    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<http.Response> updateUser(int userID, User user) async {
    late final http.Response response;
    final uri = Uri.parse('$baseUri/$userID');
    try {
      response = await http.put(
        uri,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    } catch (e) {
      return response;
    }
    return response;
  }

  Future<http.Response> deleteUser(int userId) async {
    late final http.Response response;
    final uri = Uri.parse('$baseUri/$userId');
    try {
      response = await http.delete(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      return response;
    }
    return response;
  }
}
