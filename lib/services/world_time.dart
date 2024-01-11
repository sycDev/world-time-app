import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // the time in that location
  String url; // location url for api endpoint
  late bool isDaytime; // true or false if it's day time or not

  WorldTime({ required this.location, required this.url });

  Future<void> getTime() async {
    try {
      // Make the request
      Response response = await get(Uri.parse('https://timeapi.io/api/TimeZone/zone?timeZone=$url'));
      Map data = jsonDecode(response.body);
      // Get properties from data
      String datetime = data['currentLocalTime'];
      // Create DateTime object
      DateTime now = DateTime.parse(datetime);
      // Set the time property
      isDaytime = now.hour > 6 && now.hour < 18 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('Caught error: $e');
      time = 'Could not get time data';
    }
  }
}
