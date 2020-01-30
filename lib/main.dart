import 'package:flutter/material.dart';
import 'package:doctophone/Miscellaneous/AppColors.dart';
import 'Authentication/BlankVerificaton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login In',
      theme: ThemeData(
          accentColor: background,
          appBarTheme: AppBarTheme(
            color: background,
            elevation: 0.0,
            textTheme: Theme.of(context).textTheme.copyWith(
              title: Theme.of(context).textTheme.title.copyWith(
                color: foreground,
              )
            )
          ),
      ), 
      home: Login(),      
    );
  }
}

