import 'package:doctophone/SendFile/SendFile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:doctophone/Miscellaneous/AlertDialog.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:flutter_sms/flutter_sms.dart';

Future sendPatient(BuildContext context, String name, String age , String gender, String symptom, String diagnosis, String medicine , String advice) async{

  print(name);
  print(age);
  print(gender);
  print(symptom);
  print(diagnosis);
  print(medicine);
  print(advice);

  ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Download,
      isDismissible: false,
      showLogs: false
  );

  pr.show();

  Response response;

  var dio = Dio();
  var data = FormData.fromMap({
    "Name": name,
    "Age": age,
    "Gender": gender,
    "Symptoms": symptom,
    "Diagonis": diagnosis,
    "Medicines": medicine,
    "Advice": advice
  });


  try{
    response = await dio.post(
    //'https://test-flask-api-244617.appspot.com/pdf',
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
  print("PRAVAR PAREKH");
  var responseString = json.encode(response.data);
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

  //Send on WhatsApp
  FlutterOpenWhatsapp.sendSingleMessage("918097806372", responseString.toString());

  //SMS
  void _sendSMS(String message, List<String> recipents) async {
    String _result = await FlutterSms
            .sendSMS(message: message, recipients: recipents)
            .catchError((onError) {
          print(onError);
        });
    print(_result);
  }

  String message = responseString.toString();
  List<String> recipents = ["918097806372"];

  _sendSMS(message, recipents);

}