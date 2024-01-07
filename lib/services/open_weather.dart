import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather_model.dart';

Future<Weather> fetchWeather(selectedCity) async {
  const apiKey = '1174b711b880a3545e9467f38ac5faa8';
  final city = selectedCity;

  final response =
      await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric'));

  if (response.statusCode == 200) {
    return Weather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load weather data');
  }
}

Future<Image> getWeatherIcon(String iconCode) async {
  final response = await http.get(Uri.parse('http://openweathermap.org/img/wn/$iconCode.png'));

  if (response.statusCode == 200) {
    return Image.memory(response.bodyBytes);
  } else {
    throw Exception('Failed to load weather icon');
  }
}
