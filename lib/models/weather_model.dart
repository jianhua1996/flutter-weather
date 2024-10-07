class WeatherModel {
  String cityName;
  double minTemp;
  double maxTemp;
  String mainCondition;
  String description;

  WeatherModel(
      {required this.cityName,
      required this.minTemp,
      required this.maxTemp,
      required this.mainCondition,
      required this.description});

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    return WeatherModel(
      cityName: cityName,
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
    );
  }
}
