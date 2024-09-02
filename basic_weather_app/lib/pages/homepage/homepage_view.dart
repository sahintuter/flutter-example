import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:basic_weather_app/product/viewmodels/weather_view_model.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: ChangeNotifierProvider(
          create: (_) => WeatherViewModel(),
          builder: (context, _) {
            final viewModel = Provider.of<WeatherViewModel>(context);
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 50),
                      child: SearchBar(
                        hintText: "Search City...",
                        onSubmitted: (value) {
                          viewModel.getWeatherData(value);
                        },
                      ),
                    ),
                    viewModel.isLoading
                        ? const CircularProgressIndicator()
                        : Lottie.asset(_getWeatherAnimation(
                            viewModel.response?.current?.condition?.text ??
                                'N/A')),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          viewModel.response != null
                              ? '${viewModel.response!.current?.tempC}°C'
                              : "City Waiting...",
                          style: _customTextStyle(context),
                        ),
                        Text(
                          viewModel.response != null
                              ? viewModel.response!.current?.condition?.text ??
                                  'N/A'
                              : "City Waiting...",
                          style: _customTextStyle(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  TextStyle _customTextStyle(BuildContext context) {
    return GoogleFonts.nunito(
      textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
    );
  }

  String _getWeatherAnimation(String? condition) {
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
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }
}
