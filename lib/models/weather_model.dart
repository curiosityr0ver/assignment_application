class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;

  Weather({required this.cityName, required this.temperature, required this.description, required this.iconCode});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'],
        description: json['weather'][0]['description'],
        iconCode: json['weather'][0]['icon']);
  }
}
