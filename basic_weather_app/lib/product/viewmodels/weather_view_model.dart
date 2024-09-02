import 'package:basic_weather_app/product/models/weather_model.dart';
import 'package:basic_weather_app/product/services/weather_service.dart';
import 'package:flutter/material.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();

  ApiResponse? _response;

  ApiResponse? get response => _response;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getWeatherData(String location) async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse response = await _weatherService.getCurrentWeather(location);
      _response = response;
    } catch (e) {
      // print("Error fetching weather data: $e");
      // Hata durumunu daha iyi anlamak için burada loglama veya hata işleme ekleyin
      throw Exception("Error fetching weather data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
