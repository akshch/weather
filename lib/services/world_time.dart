import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String? location; // location name for the UI
  String? time; // time in that location
  String? flag; // url to an assets flag icon
  String? url; // location url endpoint 'http://worldtimeapi.org/api/timezone/Asia/Kolkata';
  bool? isDaytime; // true or false if daytime or not
  WorldTime({  this.location, this.flag, this.url });

  Future<void> getTime() async {
    // var url = Uri.https('jsonplaceholder.typicode.com', 'todos/1');
    // var response = await http.get(url);
    // Map data = jsonDecode(response.body);
    // print('response done');
    // print(data);
    // print(data['title']);

    try {
      var endpoint = Uri.https('worldtimeapi.org', '/api/timezone/$url');
      var response = await http.get(endpoint);
      Map data = jsonDecode(response.body);


      // get properties from datatime
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time =  DateFormat.jm().format(now);
      print(time);
    }
    catch (e) {
      print('caught error $e');
      time = 'could not get time data';
    }


  }

}

