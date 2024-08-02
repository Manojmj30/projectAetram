class Weather {
  final double temperature;
  final String description;
  final List<Forecast> forecast;

  Weather({required this.temperature, required this.description, required this.forecast});

  factory Weather.fromJson(Map<String, dynamic> json) {
    var list = json['daily'] as List;
    List<Forecast> forecast = list.map((i) => Forecast.fromJson(i)).toList();
    return Weather(
      temperature: json['current']['temp'].toDouble(),
      description: json['current']['weather'][0]['description'],
      forecast: forecast,
    );
  }
}

class Forecast {
  final double temp;
  final String description;

  Forecast({required this.temp, required this.description});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      temp: json['temp']['day'].toDouble(),
      description: json['weather'][0]['description'],
    );
  }
}
