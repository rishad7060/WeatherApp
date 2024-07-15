import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/models/weather_model.dart';

class OverviewPage extends StatefulWidget {
  final WeatherService weatherService;

  OverviewPage({required this.weatherService});

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final List<String> _cities = [
    'New York',
    'Birmingham',
    'Sydney',
    'Tokyo',
    'Madrid',
    'Colombo'
  ];
  late Future<List<Map<String, dynamic>>> _weatherData;

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
        weatherData.add({
          'city': city,
          'temperature': weather.temperature,
          'pressure': weather.pressure,
          'humidity': weather.humidity
        });
      } catch (e) {
        print('Failed to load weather data for $city: $e');
        weatherData.add({
          'city': city,
          'temperature': 'N/A',
          'pressure': 'N/A',
          'humidity': 'N/A'
        });
      }
    }
    return weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Overview'),
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
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.location_city,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                        title: Text(
                          data['city'],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Temperature: ${data['temperature']}°C',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.thermostat,
                          color: Colors.red,
                          size: 30.0,
                        ),
                      ),
                      SizedBox(height: 5),
                      _buildInfoRow('Pressure', '${data['pressure']} hPa'),
                      SizedBox(height: 5),
                      _buildInfoRow('Humidity', '${data['humidity']} %'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}
