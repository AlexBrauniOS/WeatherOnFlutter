import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import 'weater.dart';
import 'details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Weather'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<Day> weatherList = <Day>[];

  @override void initState() {
    super.initState();

    listenForWeather();
  }

  listenForWeather() async {
    var stream = await getWeather();
    stream.listen((day) => 
    setState(() => weatherList = (day as Weather).listOfDays));
    print(weatherList);
  }

  listenData(LocationData data) async {
    var stream = await getWeatherByPosition(data.latitude, data.longitude);
    stream.listen((day) => 
      setState(() => weatherList = (day as Weather).listOfDays));
      print(weatherList);
  }

  listenForWeatherByLocation() async {

    Location location = Location();
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted) {
        location.getLocation().then((data) => listenData(data));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: weatherList.map((day) => WeatherWidget(day)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.gps_fixed),
        onPressed: () {
          listenForWeatherByLocation();
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class WeatherWidget extends StatelessWidget {

  final Day day;

  String getDateInString() {
    return DateFormat('dd.MM.yyyy').format(day.date);
  }

  WeatherWidget(this.day);

  @override 
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${getDateInString()} - ${day.temp}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(                
            builder: (context) => DetailsPage(day: day),
          ),
        );
      },
    );
  }

}
