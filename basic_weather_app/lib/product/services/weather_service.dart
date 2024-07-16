import 'dart:convert';

import 'package:basic_weather_app/core/constants.dart';
import 'package:basic_weather_app/product/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("API Response: ${utf8.decode(response.bodyBytes)}"); // API yanıtını UTF-8 olarak çöz ve yazdır
        return ApiResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      } else {
        throw Exception("Failed to load weather: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed to load weather: $e");
    }
  }
}
