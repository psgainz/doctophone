import 'package:flutter/material.dart';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    getDeviceSize(context);
    return Container(
      color: Colors.blueAccent,
    );
  }
}