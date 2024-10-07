import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: '2cb630eb97aa14735c7b1820ee9e96aa', http: Dio());

  WeatherModel? _weather;

  Future<void> _getWeather() async {
    try {
      var position = await _weatherService.getPosition();
      var cityName = await _weatherService.getCityName(position);
      var weatherData = await _weatherService.getWeatherData(position);

      print('-----------------weatherData: $weatherData---------------------');

      setState(() {
        _weather = WeatherModel.fromJson(weatherData, cityName);
      });
    } catch (e) {
      print(e);
    }
  }

  resolveWeatherToJson(String? weatherCode) {
    if (weatherCode == null || weatherCode == 'clear') {
      return 'assets/lottie_json/clear.json';
    }
    switch (weatherCode) {
      case 'clouds':
        return 'assets/lottie_json/clouds.json';
      case 'drizzle':
        return 'assets/lottie_json/drizzle.json';
      case 'rain':
        return 'assets/lottie_json/rain.json';
      case 'thunderstorm':
        return 'assets/lottie_json/thunderstorm.json';
      case 'snow':
        return 'assets/lottie_json/snow.json';
      case 'mist':
        return 'assets/lottie_json/mist.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Text(
              _weather?.cityName ?? '定位中...',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Lottie.asset(
                resolveWeatherToJson(_weather?.mainCondition.toLowerCase())),
            const SizedBox(height: 20),
            Text(
              _weather?.description ?? '获取中...',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 10),
            Text(
              _weather == null
                  ? '获取中...'
                  : '${_weather?.minTemp.round()} ℃ ~ ${_weather?.maxTemp.round()} ℃',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
