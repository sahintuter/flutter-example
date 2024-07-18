import 'dart:convert';
import 'dart:io';

import 'package:basic_weather_app/core/constants.dart';
import 'package:basic_weather_app/product/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == HttpStatus.ok) {
      
        return ApiResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load weather: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed to load weather: $e");
    }
  }
}
