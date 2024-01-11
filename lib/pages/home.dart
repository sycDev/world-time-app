import 'dart:ui';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;

    // Set background image and color
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDaytime'] ? Colors.blueAccent : Color(0xff00225A);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover,
              )
            ),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
                  child: Column(
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: () async {
                          dynamic result = await Navigator.pushNamed(context, '/location');
                          setState(() {
                            data = {
                              'location': result['location'],
                              'time': result['time'],
                              'isDaytime': result['isDaytime'],
                            };
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[300],
                        ),
                        icon: Icon(Icons.edit_location),
                        label: Text('Edit Location'),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            data['location'],
                            style: TextStyle(
                              fontSize: 28.0,
                              letterSpacing: 2.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 60.0),
                      Text(
                        data['time'],
                        style: TextStyle(
                          fontSize: 66.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
              ),
          ),
        ),
      ),
    );
  }
}
