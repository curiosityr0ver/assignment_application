import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:assignment_application/services/open_weather.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({super.key});

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late Future<Weather> weatherData;
  String _selectedCity = 'New York'; // Default city

  @override
  void initState() {
    super.initState();
    weatherData = fetchWeather(_selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: _selectedCity,
          onChanged: (String? newValue) {
            setState(() {
              _selectedCity = newValue!;
              weatherData = fetchWeather(_selectedCity);
            });
          },
          items: <String>['New York', 'London', 'Tokyo', 'Paris'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        FutureBuilder<Weather>(
          future: weatherData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder<Image>(
                    future: getWeatherIcon(snapshot.data!.iconCode),
                    builder: (context, iconSnapshot) {
                      if (iconSnapshot.hasData) {
                        return SizedBox(
                          height: 50,
                          width: 50,
                          child: iconSnapshot.data,
                        );
                      } else if (iconSnapshot.hasError) {
                        return Text('Icon Error: ${iconSnapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  // Display weather information using snapshot.data
                  Text(snapshot.data!.cityName),
                  Text('${snapshot.data!.temperature}°C'),
                  Text(snapshot.data!.description),
                  // ... Add more weather information here
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }
}
