import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: 'London', url: 'Europe/London'),
    WorldTime(location: 'Berlin', url: 'Europe/Berlin'),
    WorldTime(location: 'Cairo', url: 'Africa/Cairo'),
    WorldTime(location: 'Nairobi', url: 'Africa/Nairobi'),
    WorldTime(location: 'Chicago', url: 'America/Chicago'),
    WorldTime(location: 'New York', url: 'America/New_York'),
    WorldTime(location: 'Kuala Lumpur', url: 'Asia/Kuala_Lumpur'),
    WorldTime(location: 'Seoul', url: 'Asia/Seoul'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();
    // Navigate to Home screen
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
              ),
            );
          }
      ),
    );
  }
}
