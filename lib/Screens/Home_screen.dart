import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/News_model.dart';
import '../Services/api_Service.dart';
import 'Settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  double _lat = 0.0, _lon = 0.0;
  Map<String, dynamic>? _weather;
  News? _news;
  String _category = 'general';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    Location location = Location();
    var locationData = await location.getLocation();
    setState(() {
      _lat = locationData.latitude!;
      _lon = locationData.longitude!;
      print('${_lat},${_lon}');
      _fetchWeatherAndNews();
    });
  }

  Future<void> _fetchWeatherAndNews() async {
    try {
      var weatherData = await _apiService.fetchWeather(_lat, _lon);
      var temperature = weatherData['current']['temp_c'];
      print('temperature:$temperature');                                 // keywords based on weather type
      String keyword;                                                    // if temp < 10 depression , if temp >30 fear, else happy
      if (temperature < 10) {
        keyword = 'depression';
      } else if (temperature > 30) {
        keyword = 'fear';
      } else {
        keyword = 'happy';
      }
       print('keyword:$keyword');
      setState(() {
        _weather = weatherData;
        _isLoading = true;
      });

      var newsData = await _apiService.fetchNews1(keyword);
      setState(() {
        _news = newsData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }


  Future<void> _fetchWeatherAndNews1() async {                                     // category based on user selection in setting screen
    try {
      var weatherData = await _apiService.fetchWeather(_lat, _lon);
      var temperature = weatherData['current']['temp_c'];
      setState(() {
        _weather = weatherData;
        print("Temperature: $temperature");
        print("Current category: $_category");
        _isLoading = true;
      });

      var newsData = await _apiService.fetchNews(_category);
      setState(() {
        _news = newsData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _navigateToSettings() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(initialCategory: _category),
      ),
    );

    if (result != null && result is String) {
      setState(() {
        _category = result;
        _isLoading = true;
      });
      _fetchWeatherAndNews1();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Weather & News App', style: TextStyle(color: Colors.white)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _weather == null || _news == null
          ? const Center(child: Text('No data available'))
          : Column(
        children: [
          const SizedBox(height: 10),
          Text('Location : ${_weather!['location']['name']}', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Temperature : ${_weather!['current']['temp_c']}°C', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Condition : ${_weather!['current']['condition']['text']}', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: _news!.articles!.length,
              itemBuilder: (context, index) {
                final article = _news!.articles![index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(article.title.toString()),
                    onTap: () => _launchURL(article.url.toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToSettings,
        child: const Icon(Icons.settings),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
