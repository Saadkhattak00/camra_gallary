import 'package:camra_gallary/selecttype.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:camra_gallary/listview.dart';

class direction extends StatefulWidget {
  static String id = 'direction';
  @override
  _directionState createState() => _directionState();
}

class _directionState extends State<direction> {
  int _page = 0;
  final _pageOption = [
    MyHomePage(),
    selecttype(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: MediaQuery.of(context).size.height / 14,
        backgroundColor: Colors.lightBlueAccent,
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            size: 40,
          ),
          Icon(Icons.add_a_photo_outlined, size: 40),
        ],
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pageOption[_page],
    );
  }
}
