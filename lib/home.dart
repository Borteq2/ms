import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Talker talker = GetIt.I<Talker>();
  bool geoPermission = false;
  String _locationMessage = '';
  String _weatherInfo = '';
  late Position _position;
  String _apiKey = '713d2aecd8ffe2c5a2168f66a4f90082';
  Map<String, dynamic> weatherData = {
    'name': '',
    'main': {'temp': ''}
  };

  // Future<void> goToAppSettings() async {
  //   // Переход к настройкам приложения в системных настройках
  //   await openAppSettings();
  // }

  Future<void> _getLocation() async {
    // Проверка разрешения доступа к местоположению
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Обработка случая, если служба геолокации выключена
      setState(() {
        _locationMessage = 'Пожалуйста, включите службу геолокации';
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Обработка случая, если разрешение не предоставлено
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Пользователь отказал в доступе к местоположению
        setState(() {
          _locationMessage = 'Разрешение на доступ к местоположению отклонено';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Обработка случая, если разрешение отозвано навсегда
      setState(() {
        _locationMessage =
            'Разрешение на доступ к местоположению отозвано навсегда';
      });
      return;
    }

    // Получение текущего местоположения
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Обновление состояния с полученными координатами
    Response response = await Dio().get(
        'https://api.openweathermap.org/data/2.5/weather?lat=${_position.latitude}&lon=${_position.longitude}&appid=$_apiKey&units=metric&lang=ru');
    weatherData = response.data;
    talker.info(weatherData);
    setState(() {
      _weatherInfo = (weatherData['main']['temp']).toString();
    });
    setState(() {
      _locationMessage =
          'Широта: ${_position.latitude},\nДолгота: ${_position.longitude}';
      _weatherInfo = '${(weatherData['main']['temp']).toString()} °C';
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    // _getWeatherInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            Text(
              weatherData['name'].toString().isEmpty
                  ? ''
                  : weatherData['name'].toString(),
            ),
            const SizedBox(width: 20),
            Text(
              (weatherData['main']['temp']).toString().isEmpty
                  ? ''
                  : '${(weatherData['main']['temp']).toString()}°C',
            )
          ],
        ),
      ),
      body: weatherData['name'].toString().isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Center(
        // TODO: временно, для отработки логики парсинга температуры
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  weatherData['main']['temp'] >= -10 &&
                          weatherData['main']['temp'] < 0
                      ? const Text('холодно')
                      : weatherData['main']['temp'] >= 0 &&
                              weatherData['main']['temp'] < 10
                          ? const Text('прохладно')
                          : weatherData['main']['temp'] >= 10 &&
                                  weatherData['main']['temp'] < 20
                              ? const Text('тепло')
                              : weatherData['main']['temp'] >= 25
                                  ? const Text('жара')
                                  : const Text('не предусмотрено')
                ],
              ),
            ),
      floatingActionButton: weatherData['name'].toString().isEmpty
          ? const SizedBox.shrink()
          : FloatingActionButton(
              onPressed: () {},
              tooltip: 'Что надеть?',
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
