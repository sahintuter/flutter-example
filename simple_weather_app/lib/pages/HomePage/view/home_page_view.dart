import 'package:flutter/material.dart';
import 'package:simple_weather_app/product/models/weather_model.dart';
import 'package:simple_weather_app/product/services/weather_service.dart';


class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {

// api key
final _weatherService = WeatherService('ff3ccfbc318e30373d3c73a30f2ba05c');
WeatherModel? _weatherModel;

// fetch weather 
_fetchWeather() async{
  // get current city

String cityName = await _weatherService.getCurrentCity();


// get weather for city

try {
   final weather = await _weatherService.getWeather(cityName);
  setState(() {
    _weatherModel = weather;
  }); 
} catch (e) {
  print(e); 
}
}
// weather animation

@override
  void initState() {
    super.initState();
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Column(
children: [
  Text(_weatherModel?.cityName ?? "Şehir Yükleniyor..."),
  Text('${_weatherModel?.temperature.round().toString()}°C'),
],
    ),
    );
  }
}