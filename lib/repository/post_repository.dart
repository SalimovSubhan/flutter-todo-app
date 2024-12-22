import 'dart:convert';
import 'package:app_test_alif/models/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  final String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts(int userId) async {
    final response = await http.get(Uri.parse('$apiUrl?userId=$userId'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

Future createPost(Post post)async
{
 try {
    var response = await http.post(Uri.parse("https://jsonplaceholder.typicode.com/posts"),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(post.toJson())
  );
  if(response.statusCode==201){
    print("Новий пост создан");
  }else {
        throw Exception('Не удалос создат новий пост');
      }
 } catch (e) {
   throw Exception('Не удалос создат новий пост${e}');
 }
}

Future updatePost(Post post)async{
try {
  var response=await http.put(Uri.parse("https://jsonplaceholder.typicode.com/posts/${post.id}"),
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode(post.toJson())
  );
  if(response.statusCode==200)
  {
    print("Изменение поста удался");
  }else{throw Exception("не удалос изменит пост ${response.statusCode}");}
} catch (e) {
  throw Exception("не удалос изменит пост ${e}");
}
}

Future deletePost(int postId)async
{
  try {
    var response=await http.delete(Uri.parse("https://jsonplaceholder.typicode.com/posts/${postId}"));

    if(response.statusCode==200)
    {
      print("Удаление поста удалос");
    }
    else{throw Exception("Неудалос удалит пост ${response.statusCode}");}
  } catch (e) {
    throw Exception("Неудалос удалит пост ${e}");
  }
}

}
