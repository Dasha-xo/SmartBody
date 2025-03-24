import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/inbody_data.dart';

class AnalysisService {
  static const String _baseUrl = 'your-api-url.com';

  Future<Map<String, dynamic>> analyzeData(InBodyData data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/analyze'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'body_fat': data.bodyFat,
        'muscle_mass': data.muscleMass,
        'water_level': data.waterLevel,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to analyze data');
    }
  }

  Future<List<Map<String, dynamic>>> getRecommendations(InBodyData data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/recommendations'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'body_fat': data.bodyFat,
        'muscle_mass': data.muscleMass,
        'water_level': data.waterLevel,
      }),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get recommendations');
    }
  }
}
