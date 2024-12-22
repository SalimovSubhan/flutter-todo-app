import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_test_alif/models/user.dart';

class UserRepository {
  Future<List<User>> fetchUsers() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load users: $e');
    }
  }

  Future<void> createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 201) {
        print("Создали новий ползовател ${response.statusCode}");
      } else {
        throw Exception('Failed to create user');
      }
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<void> updateUser(User user) async {
    try {
      final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/users/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );
      if (response.statusCode == 200) {
        print("Изменение прошло успешно");
      } else {
        throw Exception('Failed to update user');
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> deleteUser(int userId) async {
    try {
      final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/users/$userId'),
      );
      if (response.statusCode == 200) {
        print("ползовател удалено");
      } else {
        throw Exception('Ошибка пост не удалися');
      }
    } catch (e) {
      throw Exception('Ошибка пост не удалися $e');
    }
  }
}
