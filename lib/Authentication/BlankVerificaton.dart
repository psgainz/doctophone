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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _emailController;
  TextEditingController _passwordController;

  ProgressDialog pr;

  Future checkStoragePermissions() async {
   Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler()
      .requestPermissions([PermissionGroup.storage]);

    if(permissions[PermissionGroup.storage] != PermissionStatus.granted) {
      await checkStoragePermissions();
    }
 }

 void initState(){
   super.initState();

   initialiseProgressBar();

   _emailController = TextEditingController();
   _passwordController = TextEditingController();

   Future.microtask((){
     checkStoragePermissions();
   });
 }

 void initialiseProgressBar(){
    pr = ProgressDialog(
     context,
     type: ProgressDialogType.Download,
     isDismissible: false,
     showLogs: false
   );
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
                  height: deviceHeight * 0.09,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Email',
                      labelText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: deviceHeight * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: deviceHeight * 0.09,
                ),
                Center(
                  widthFactor: deviceWidth * 0.09,
                  child: RaisedButton(
                    color: foreground,
                    textColor: background,
                    child: Text(
                      'Log In '
                    ),
                    onPressed: () async {
                      await signInWithEmailPassword(_emailController.text,_passwordController.text);
                    }
                  ),
                )
              ],
            ),
    );
  }

  Future<FormData> formLoginData(String text1 ,String text2) async {
    return FormData.fromMap({
      "email": text1,
      "password" : text2
    });
  }

  Future<void> signInWithEmailPassword(String emailStr , String passwordStr) async {

    var dio = Dio();

    Response response;
    var data = formLoginData(emailStr,passwordStr);

    //var responseString = true;

    try{
    response = await dio.post(
    //'https://test-flask-api-244617.appspot.com/login',
    'https://8080-b8f85618-7482-44a5-a5d3-00259d889406.ws-ap01.gitpod.io/',
    data: data,
    //Send data with "application/x-www-form-urlencoded" format
    options: Options(
      contentType: Headers.formUrlEncodedContentType,
    ),
    onSendProgress: (sent , total){
      if (total != -1) {
        pr.update(
          progress: (sent / total * 100).roundToDouble(),
          message: 'Sending File : ' + ((sent / total * 100).toInt()).toStringAsFixed(0) + "%",
        );
        if(sent == total) print('Sent');
      }
    },
    onReceiveProgress: (received , total){
       if(total != -1) {
          pr.update(
            progress: (received / total * 100).roundToDouble(),
            message: 'Receiving Data : ' + ((received / total * 100).toInt()).toStringAsFixed(0) + "%",
          );
          if(received == total) print('Received');
        }
    },
  );
  var responseString = json.encode(response.data);
  print(responseString);
  }
  on DioError catch(e) {
      print(e.response.data);
      print(e.response.headers);
      print(e.response.request);
      await showAlertDialog(context,
          alertTitle: 'Internet Connection Error',
          alertText: 'Please check you internet connection & try again',
          numberButtons: 1
      );
  }

  if(responseString){
      email = _emailController.text;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context)=>
            Home()), 
        (Route<dynamic> route) => false);
    }
  }
}