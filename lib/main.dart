import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/overview_weather_page.dart';
import 'package:weather_app/pages/search_city_weather_page.dart';
import 'package:weather_app/pages/weather_blog_page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/services/weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService =
      WeatherService('658ec2b282e3a76cb100c7460d350da7');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(weatherService: weatherService),
    );
  }
}

class HomePage extends StatefulWidget {
  final WeatherService weatherService;

  HomePage({required this.weatherService});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  Weather? _weather;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setWeather(Weather weather) {
    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      WeatherPage(weather: _weather),
      SearchWeather(
        weatherService: widget.weatherService,
        setWeather: _setWeather,
      ),
      OverviewPage(weatherService: widget.weatherService),
      WeatherBlogPage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Current',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Overview', // Add Overview label and icon
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blog',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
