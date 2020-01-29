import 'package:doctophone/Miscellaneous/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:doctophone/Home.dart';

class Blank extends StatefulWidget {
  @override
  _BlankState createState() => _BlankState();
}

class _BlankState extends State<Blank> {

 void initState(){
   super.initState();

   Future.microtask((){
     checkStoragePermissions();
   });

   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
     builder: (context) => 
     Home()
   ),
   (Route<dynamic> route) => false);
 }

 Future checkStoragePermissions() async {
   Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler()
      .requestPermissions([PermissionGroup.storage]);

    if(permissions[PermissionGroup.storage] != PermissionStatus.granted) {
      await checkStoragePermissions();
    }
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
    );
  }
}