import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://your-backend-url:8080'));

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });
      return response.data['token'];
    } catch (e) {
      throw Exception('Login failed');
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _dio.post('/register', data: {
        'email': email,
        'password': password,
      });
    } catch (e) {
      throw Exception('Registration failed');
    }
  }
}
