class Weather {
  final String cityName;
  final double temperature;
  final double pressure;
  final double humidity;
  final String mainCondition;
  final String description;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.pressure,
      required this.humidity,
      required this.mainCondition,
      required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        pressure: json['main']['pressure'].toDouble(),
        humidity: json['main']['humidity'].toDouble(),
        mainCondition: json['weather'][0]['main'],
        description: json['weather'][0]['description']);
  }
}
