//import 'dart:convert';
//import 'package:http/http.dart' as http;

/*class AuthService {
  final String baseUrl = 'https://ayni-api-v2.zeabur.app/api/v1/auth';

  Future<http.Response> signIn(String username, String password) async {
    final url = Uri.parse('$baseUrl/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
    return response;
  }

  Future<http.Response> signUp(String username, String email, String role, String password) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'email': email, 'role': role, 'password': password}),
    );
    return response;
  }
}*/