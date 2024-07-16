import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:basic_weather_app/product/services/weather_service.dart';
import 'package:basic_weather_app/product/models/weather_model.dart';

import 'package:lottie/lottie.dart';


class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  HomepageViewState createState() => HomepageViewState();
}

class HomepageViewState extends State<HomepageView> {
  ApiResponse? _response;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SearchBar(
                  hintText: "Search City...",
                  onSubmitted: (value) {
                    _getWeatherData(value);
                  },
                ),
              ),

              Lottie.asset(getWeatherAnimation(_response?.current?.condition?.text ?? 'N/A')),


                Column(
                  children: [
                    Text(
                      _response != null ? '${_response!.current?.tempC}°C' : "City Waiting...",
                      style: customTextStyle(context),
                    ),
                                 
                    Text(
                     _response != null ? _response!.current?.condition?.text ?? 'N/A' : "City Waiting...",
                      style: customTextStyle(context),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle customTextStyle(BuildContext context) {
    return GoogleFonts.nunito(
      textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
    );
  }

  Future<void> _getWeatherData(String location) async {
    try {
      ApiResponse response = await WeatherService().getCurrentWeather(location);
      setState(() {
        _response = response;
      });
    } catch (e) {
      print("Error fetching weather data: $e");
      // Hataları kullanıcıya bildir, örneğin Snackbar veya alert dialog göster
    }
  }

String getWeatherAnimation(String? condition){

if (condition == null) return 'assets/loading.json';
  
  switch (condition.toLowerCase()) {
    case 'clouds':
    case 'partly cloudy':
    case 'cloudly':
    case 'overcast':
    case 'fog':
      return 'assets/cloudly.json';
    case 'rain':
    case 'moderate rain':
    case 'light rain':
    case 'shower rain':
    case 'patchy rain nearby':
    case 'light rain shower':
      return 'assets/rain.json';  
    case 'sunny':
      return 'assets/sunny.json'; 
    default:
      return 'assets/loading.json';
  }
  

}


}
