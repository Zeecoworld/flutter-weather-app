import 'package:flutter/material.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:lottie/lottie.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final _weatherService = WeatherService("API_KEY");
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
        return "assets/cloud.json";
      case 'sunny':
        return "assets/sunny.json";
      default:
        return "assets/sunny.json";
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Wrap the entire content in a Center widget to center everything horizontally
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Align children vertically in the center
          children: [
            //weather city
            Text(_weather?.cityName ?? "loading city..."), // City name
            const SizedBox(
                height:
                    20), // Optional: Adds some space between the city name and temp
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //weather temperature
            Text('${_weather?.temp.round()}C'), // Temperature

            //weather condition
            Text(_weather?.mainCondition ?? ""), // Temperature
          ],
        ),
      ),
    );
  }
}
