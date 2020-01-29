import 'package:doctophone/Miscellaneous/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';
import 'package:doctophone/PrescriptionHistory.dart';
import 'package:doctophone/Settings.dart';
import 'AudioRecorder/Recorder.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int _currentPage = 1;

  List<Widget> _pages = [
    //All pages for Bottom Nav Bar
    PrescriptionHistory(),
    Recorder(),
    Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: foreground,
        title: Text(
          'DoctoPhone',
          style: TextStyle(
            color: background
          ),
        ),
        centerTitle: true,
      ),

      body: _pages[_currentPage],

      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25.0,
        backgroundColor: foreground,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: background,
        selectedFontSize: 12,
        unselectedFontSize: 0,
        currentIndex: _currentPage,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon:  Icon(
              Icons.library_books,
              color: bottomNavBarOptionColor,
              ),
            title:  Text('Library'),
          ),
          BottomNavigationBarItem(
            icon:  Icon(
              Icons.mic,
              color: background,
            ),
            title:  Text('Prescribe'),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: bottomNavBarOptionColor,
                ),
              title: Text('Settings')
          )
        ]
      ),
      
    );
  }

  void onTabTapped(int index) {
   setState(() {
     _currentPage = index;
   });
 }
}