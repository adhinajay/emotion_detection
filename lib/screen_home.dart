import 'package:emotion_detection/screen_dashboard.dart';
import 'package:emotion_detection/screen_person.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final pages=[
    ScreenDashboard(),
    ScreenAccount(),
  ];

  int _currentIndexSelector=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndexSelector,
        onTap: (value){
          setState((){
            _currentIndexSelector=value;
          });
          print(value);
        },
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Account'),
        ]),
      body: pages[_currentIndexSelector],
    );
  }
}