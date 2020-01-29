import 'dart:io';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';
import 'Miscellaneous/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:doctophone/BottomNavBar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Function to create directory in user's device
  void createStorageDirectory() async {
    String directory = "/DoctoPhone/";
    Directory deviceDirectory;

    if(Platform.isIOS){
      deviceDirectory = await getApplicationDocumentsDirectory();
    }
    else{
      deviceDirectory = await getExternalStorageDirectory();
    }

    directoryPath = deviceDirectory.path + directory;

    try{
      Directory(directoryPath).create();
      print(directoryPath);
    }
    catch(e){}
  }

  void initState(){
    super.initState();

    //Call function to create directory in users device
    Future.microtask(() {
      createStorageDirectory();
    });

  }

  @override
  Widget build(BuildContext context) {

    //Get current device width and height 
    getDeviceSize(context);
    return MaterialApp(
      title: 'DoctoPhone',
      theme: ThemeData(
        //accentColor working for colors of settings
        accentColor: enabled,
        //appBarTheme working for appBar
        appBarTheme: AppBarTheme(
          color: background,
          elevation: 0.0,
          textTheme: Theme.of(context).textTheme.copyWith(
            title: Theme.of(context).textTheme.title.copyWith(
              color: foreground,
            )
          )
        ),

        //size working properly
        iconTheme: IconThemeData(
          color: foreground,
          size: 30.0,
        ),
      ),
      home: BottomNavBar(),      
    );
  }
}