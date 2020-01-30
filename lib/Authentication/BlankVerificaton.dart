import 'package:doctophone/Miscellaneous/AppColors.dart';
import 'package:doctophone/SendFile/SendFile.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';
import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:doctophone/Miscellaneous/AlertDialog.dart';
import 'package:doctophone/Home.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future checkStoragePermissions() async {
   Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler()
      .requestPermissions([PermissionGroup.storage]);

    if(permissions[PermissionGroup.storage] != PermissionStatus.granted) {
      await checkStoragePermissions();
    }
 }

 void initState(){
   super.initState();

   _authorized = 'Not Authorized';

   Future.microtask((){
     checkStoragePermissions();
   });
 }

 Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      if(_authorized == 'Authorized'){
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context)=>
            Home()), 
        (Route<dynamic> route) => false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    getDeviceSize(context);
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
      body: ListView(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: deviceHeight * 0.15,
                ),
                Center(
                  widthFactor: deviceWidth * 0.09,
                  child: RaisedButton(
                    color: foreground,
                    textColor: background,
                    child: Text(
                      'Authenticate'
                    ),
                    onPressed: _authenticate
                  ),
                )
              ],
            ),
    );
  }
}