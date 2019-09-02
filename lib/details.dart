import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'weater.dart';

class DetailsPage extends StatefulWidget {

  final Day day;

  DetailsPage({Key key, @required this.day}) : super(key: key); 

  @override
  DetailsState createState() => DetailsState();
}

class DetailsState extends State<DetailsPage> {

  String getDateInString() {
    return DateFormat('dd.MM.yyyy').format(widget.day.date);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(getDateInString()),
      ),
      body: Center(
        child: Text(widget.day.description),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}