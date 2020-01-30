import 'package:flutter/material.dart';
//import 'package:progress_dialog/progress_dialog.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctophone/Miscellaneous/AppColors.dart';
import 'package:doctophone/SendFile/SendFile.dart';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';

import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_recognition_error.dart';

class Recorder extends StatefulWidget {
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> with SingleTickerProviderStateMixin {

  int pressed = 0;
  IconData recordButtonStd = FontAwesomeIcons.microphone;
  IconData stopButtonStd = FontAwesomeIcons.stop;
  IconData repeatButtonStd = FontAwesomeIcons.retweet;
  IconData currentIcon ;

  AnimationController controller;

  List<Widget> sendFileWidget;

  bool _hasSpeech = false;
  String displayText = "";
  String lastWords = "";
  String lastError = "";
  String lastStatus = "";

  final SpeechToText speech = SpeechToText();

  void initState(){
    super.initState();

    currentIcon = recordButtonStd;

    controller = AnimationController(
      duration: Duration(milliseconds: 900),
      animationBehavior: AnimationBehavior.normal,
      vsync: this,

    );

    initSpeechState();

    sendFileWidget = List();

    controller.addListener(() {
      setState(() {
      });
    });

    Future.microtask((){
      cancelListening();
      stopListening();
    });
  }

  Future<void> initSpeechState() async {
    bool hasSpeech = await speech.initialize(onError: errorListener, onStatus: statusListener );

    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  void errorListener(SpeechRecognitionError error ) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }
  void statusListener(String status ) {
    setState(() {
      lastStatus = "$status";
    });
  }

  void startListening() {
    lastWords = "";
    lastError = "";
    speech.listen(onResult: resultListener );
    setState(() {
      sendFileWidget.clear();
    });
  }

  void stopListening() {
    speech.stop( );
    setState(() {
      sendFileWidget.clear();
    });
  }

  void cancelListening() {
    speech.cancel( );
    setState(() {
      sendFileWidget.add(
          Container(
            alignment: Alignment.center,
            //width: 50.0,
            child: RaisedButton(
                color: foreground,
                textColor: background,
                child: Text(
                    'Prescribe'
                ),
                onPressed: () async {
                  await sendTranscipt(context, lastWords);
                }
            ),
          )
      );
    });
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = "${result.recognizedWords}";
    });
  }

  @override
  Widget build(BuildContext context) {
    getDeviceSize(context);
    return _hasSpeech ?
       ListView(
        children: [  
          SizedBox(
            width: double.infinity,
            height: deviceHeight * 0.09,  
          ), 
          Center(
            child: Text(
              'Speech Recognition Available'
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: deviceHeight * 0.15,
          ),
          GestureDetector(
            onTap: () {
              if(pressed == 2){
                //Reset btn pressed
                //-----Redundant code -----
                displayText = "";
                pressed = 0;
                currentIcon = recordButtonStd;
                cancelListening();
              }
              else if(pressed == 0) {
                //Record btn pressed
                pressed = 1;
                currentIcon = stopButtonStd;
                startListening();
              }
              else if(pressed == 1){
                //Stop btn pressed
                pressed = 0;
                currentIcon = recordButtonStd;
                //stopListening();
                cancelListening();
              }
            },
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                //fit: StackFit.expand,
                children: [
                  CustomPaint(painter: CustomCircle(controller.value)),
                  Center(
                    child: Icon(
                      currentIcon,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ], 
              ),
            )
          ),
          SizedBox(
            width: double.infinity,
            height: deviceHeight * 0.09,
          ),
          Column(
            children: <Widget>[
              Center(
                child: Text('Recognised Words'),
              ),
              Center(
                child: Text(lastWords),
              )
            ],
          ),
              // Expanded(
              //   child: Column(
              //     children: <Widget>[
              //       Center(
              //         child: Text('Error'),
              //       ),
              //       Center(
              //         child: Text(lastError),
              //       ),
              //     ],
              //   ),
              // ),
          SizedBox(
            width: double.infinity,
            height: deviceHeight * 0.09,
          ),
          Center(
            child: speech.isListening ? Text("I'm listening...") : Text( 'Not listening' ),
          ),
          SizedBox(
            width: double.infinity,
            height: deviceHeight * 0.03,
          ),
          ...sendFileWidget
        ],
      ):
      Center( 
        child: Text(
          'Speech recognition unavailable', 
          style: TextStyle(
            fontSize: 20.0, 
            fontWeight: FontWeight.bold
            )
          )
        );
  }
}

class CustomCircle extends CustomPainter{
  Paint _paint;
  
  CustomCircle(double opacity1) {
    _paint = Paint()
    ..color = Colors.red.withOpacity(opacity1)
    ..strokeWidth = 6.0
    ..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
     canvas.drawCircle(Offset(-0.85, 2.0), 45.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}