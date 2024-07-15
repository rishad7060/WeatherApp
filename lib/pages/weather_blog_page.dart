import 'package:flutter/material.dart';
import 'package:weather_app/pages/blog_detail_page.dart'; // Adjust the import according to your project structure

class WeatherBlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final articles = [
      {
        'title': 'Understanding Weather Patterns',
        'shortContent':
            'Weather patterns are driven by a variety of factors including ...',
        'fullContent':
            'Weather patterns are driven by a variety of factors including atmospheric pressure, temperature, and humidity. These factors interact in complex ways to create the diverse weather conditions we experience. Understanding these patterns can help in predicting weather and preparing for various climatic events.',
        'image': 'assets/weather_pattern.jpg',
      },
      {
        'title': 'How to Predict the Weather',
        'shortContent': 'Predicting the weather involves using data from ...',
        'fullContent':
            'Predicting the weather involves using data from satellites, weather stations, and radars. Meteorologists analyze this data to identify trends and patterns. Advanced computer models then simulate these patterns to forecast weather conditions. Understanding how to read weather maps and data can also help individuals make their own weather predictions.',
        'image': 'assets/prediction.png',
      },
      {
        'title': 'The Impact of Climate Change',
        'shortContent': 'Climate change is having a significant impact on ...',
        'fullContent':
            'Climate change is having a significant impact on weather patterns around the world. Rising global temperatures are leading to more extreme weather events, such as hurricanes, droughts, and heavy rainfall. Understanding the causes and effects of climate change is crucial for developing strategies to mitigate its impact and adapt to changing conditions.',
        'image': 'assets/change.jpg',
      },
      {
        'title': 'The Role of Oceans in Weather',
        'shortContent':
            'Oceans play a crucial role in regulating weather by ...',
        'fullContent':
            'Oceans play a crucial role in regulating weather by storing and distributing heat across the globe. The interaction between ocean currents and atmospheric conditions significantly influences weather patterns...',
        'image': 'assets/ocean.jpg',
      },
      {
        'title': 'The Science Behind Rainbows',
        'shortContent':
            'Rainbows are fascinating weather phenomena that occur when ...',
        'fullContent':
            'Rainbows are fascinating weather phenomena that occur when light is refracted, dispersed, and reflected in water droplets. This process creates a spectrum of light that appears as a circular arc of colors...',
        'image': 'assets/rainbow.jpg',
      },
      {
        'title': 'Understanding Tornadoes',
        'shortContent':
            'Tornadoes are powerful and destructive weather events caused by ...',
        'fullContent':
            'Tornadoes are powerful and destructive weather events caused by severe thunderstorms. They form when warm, moist air meets cold, dry air, creating a rotating column of air that extends from a thunderstorm to the ground...',
        'image': 'assets/tornado.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Blog'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetailPage(
                    title: article['title']!,
                    content: article['fullContent']!,
                    image: article['image']!,
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        article['image']!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      article['title']!,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      article['shortContent']!,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
