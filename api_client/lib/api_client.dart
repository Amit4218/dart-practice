import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class User {
  int? userId;
  int? id;
  String? title;
  String? body;

  User({this.userId, this.id, this.title, this.body});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}

Future<User> getApiResponse() async {
  Uri uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/1");
  final res = await http.get(
    uri,
    headers: {"Content-Type": "application/json"},
  );

  final data = jsonDecode(res.body);
  return User.fromJson(data);
}

void main() async {
  User user = await getApiResponse();
  print("-------------------- Response ----------------------\n");
  print("Id: ${user.userId}\nTitle: ${user.title}\nBody: ${user.body}");
}
