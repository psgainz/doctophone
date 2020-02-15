// import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:doctophone/Miscellaneous/AlertDialog.dart';
import 'package:doctophone/Home.dart';
import 'package:doctophone/Preview/Preview.dart';

var responseString;

Future<FormData> formData(String text) async {
  return FormData.fromMap({
    "transcript": text,
  });
}

Future sendTranscipt(BuildContext context, String transcript) async {
  ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      isDismissible: false,
      showLogs: false
  );

  pr.show();

  Response response;

  var dio = Dio();
  var data = await formData(transcript);


  try{
    response = await dio.post(
    //'https://test-flask-api-244617.appspot.com/',
    'https://8080-e4901d2e-80d6-4643-ace7-ef71be9018e0.ws-ap01.gitpod.io/',
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
  print("PRAVAR PAREKH");
  responseString = json.encode(response.data);
  print("<><><<<<<<<<<>>>>>>>>>>>>>>>>>>");
  print(responseString);
  print("MARVINDSKJDKJSNNS");
  //print(responseString);
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

  pr.hide().whenComplete(() async {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context)=>
          Home()), 
      (Route<dynamic> route) => false);
    
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return Preview(responseString);
            }
        )
    );
  });
}