import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class SortWeatherPage extends StatefulWidget {
  final WeatherService weatherService;

  SortWeatherPage({required this.weatherService});

  @override
  _SortWeatherPageState createState() => _SortWeatherPageState();
}

class _SortWeatherPageState extends State<SortWeatherPage> {
  final List<String> _cities = [
    'New York',
    'Birmingham',
    'Sydney',
    'Tokyo',
    'Madrid'
  ];
  late Future<List<Map<String, dynamic>>> _weatherData;
  bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _weatherData = _fetchWeatherData();
  }

  Future<List<Map<String, dynamic>>> _fetchWeatherData() async {
    List<Map<String, dynamic>> weatherData = [];
    for (String city in _cities) {
      try {
        Weather weather = await widget.weatherService.searchWeather(city);
        weatherData.add({'city': city, 'temperature': weather.temperature});
      } catch (e) {
        print('Failed to load weather data for $city: $e');
        weatherData
            .add({'city': city, 'temperature': 'N/A', 'error': e.toString()});
      }
    }
    return weatherData;
  }

  void _sortWeatherData(List<Map<String, dynamic>> data) {
    data.sort((a, b) {
      if (a['temperature'] == 'N/A' || b['temperature'] == 'N/A') return 0;
      double tempA = a['temperature'];
      double tempB = b['temperature'];
      return _isAscending ? tempA.compareTo(tempB) : tempB.compareTo(tempA);
    });
    setState(() {
      _isAscending = !_isAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sort Weather'),
        actions: [
          IconButton(
            icon:
                Icon(_isAscending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: () {
              setState(() {
                _weatherData.then((data) => _sortWeatherData(data));
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load weather data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No weather data available'));
          }

          List<Map<String, dynamic>> weatherData = snapshot.data!;
          return ListView.builder(
            itemCount: weatherData.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = weatherData[index];
              return Card(
                margin: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(data['city']),
                  subtitle: data['temperature'] != 'N/A'
                      ? Text('Temperature: ${data['temperature']}°C')
                      : Text('Failed to load data: ${data['error']}'),
                  leading: Icon(Icons.thermostat),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
