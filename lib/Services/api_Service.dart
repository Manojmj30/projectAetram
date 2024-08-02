

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/News_model.dart';


class ApiService {
  final String weatherUrl = 'http://api.weatherapi.com/v1/current.json';
  final String newsUrl = 'https://newsapi.org/v2/top-headlines';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final response = await http.get(Uri.parse('$weatherUrl?key=f0c09f559b654b048ff170903240108&q=$lat,$lon'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final temperature = data['current']['temp_c'];
      final condition = data['current']['condition']['text'];
      print('Temperature: $temperature°C');
      print('Condition: $condition');
      return data;
    } else {
      throw Exception('Failed to load weather data');
    }
  }


  Future<News> fetchNews(String category) async {
    final response = await http.get(Uri.parse('$newsUrl?category=$category&apiKey=ddeb517fd3034aecad73e48df8e1940b'));
    if (response.statusCode == 200) {
      return News.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load news');
    }
  }
}
