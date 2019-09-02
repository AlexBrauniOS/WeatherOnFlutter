
import 'dart:convert';
import 'package:http/http.dart' as http;

main() {
  getWeather();
}

class Weather {

  String city;
  List<Day> listOfDays;

  Weather.fromJson(Map jsonMap) {
    city = (jsonMap['city'] as Map)['name'];
    listOfDays = (jsonMap['list'] as List).map((day) => Day.fromJson(day as Map)).toList();
  }

}

class Day {
  DateTime date;
  double temp;
  double tempMin;
  double tempMax;
  double pressure;
  String main;
  String description;
  double speed;

  Day.fromJson(Map jsonMap) {


    date = DateTime.fromMillisecondsSinceEpoch((jsonMap['dt'] as int) * 1000);
    temp = jsonMap['temp']['day'];
    tempMin = jsonMap['temp']['min'];
    tempMax = jsonMap['temp']['max'];
    pressure = jsonMap['pressure'];
    main = jsonMap['weather'][0]['main'];
    description = jsonMap['weather'][0]['description'];
    speed = jsonMap['speed'];
  }
}

getWeather() async {
  var url = 'https://api.openweathermap.org/data/2.5/forecast/daily?q=Donetsk,UA&units=metric&appid=ebbe02980ce0c118e66712234c304217';

  var client = http.Client();
  var streamedRes = await client.send(
    new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .map((jsonWeather) => Weather.fromJson(jsonWeather));

}

getWeatherByPosition(double lat, double lon) async {
  var url = 'https://api.openweathermap.org/data/2.5/forecast/daily?lat=$lat&lon=$lon&units=metric&appid=ebbe02980ce0c118e66712234c304217';

  var client = http.Client();
  var streamedRes = await client.send(
    new http.Request('get', Uri.parse(url))
  );

  return streamedRes.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .map((jsonWeather) => Weather.fromJson(jsonWeather));
}