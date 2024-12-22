import 'dart:convert';
import 'package:app_test_alif/models/comment.dart';
import 'package:http/http.dart' as http;

class CommentRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/comments';

  Future<List<Comment>> fetchComments(int postId) async {
    final response = await http.get(Uri.parse('$apiUrl?postId=$postId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future createComment(Comment comment) async {
    try {
      var response = await http.post(
          Uri.parse("https://jsonplaceholder.typicode.com/comments"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(comment.toJson()));
      if (response.statusCode == 201) {
        print("Саздали новий камент");
      } else {
        throw Exception("неудалос создат камент ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("неудалос создат камент ${e}");
    }
  }

  Future updateComment(Comment comment) async {
    try {
      var response = await http.put(
          Uri.parse(
              "https://jsonplaceholder.typicode.com/comments/${comment.id}"),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(comment.toJson()));
      if (response.statusCode == 200) {
        print("сомент изменено");
      } else {
        throw Exception("неудалос изменит камент ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("неудалос изменит камент ${e}");
    }
  }

  Future deleteComment(int commentId) async {
    try {
      var response = await http.delete(Uri.parse(
          "https://jsonplaceholder.typicode.com/comments/${commentId}"));
      if (response.statusCode == 200) {
        print("Камент успешно удалено");
      } else {
        throw Exception("не удалос удалит коммент ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("не удалос удалит коммент ${e}");
    }
  }
}
