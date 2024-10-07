import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class WeatherService {
  static const baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;
  final Dio http;

  WeatherService({required this.apiKey, required this.http});

  Future<Map<String, dynamic>> getWeatherData(Position geo) async {
    final response = await http.get(
        '${WeatherService.baseUrl}?lat=${geo.latitude}&lon=${geo.longitude}&appid=$apiKey&units=metric&lang=zh_cn'); // metric 指定为摄氏度， lang 指定为中文

    return response.data;
  }

  Future<String> getCityName(Position geo) async {
    var placemarks =
        await placemarkFromCoordinates(geo.latitude, geo.longitude);

    print('------------placemarks: $placemarks-------------');

    return placemarks[0].subLocality ?? '未知区域';
  }

  Future<Position> getPosition() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    var position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    return position;
  }
}
