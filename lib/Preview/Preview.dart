import 'package:flutter/material.dart';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';
import 'package:doctophone/Miscellaneous/AppColors.dart';
import 'package:flutter/rendering.dart';
import 'package:doctophone/Preview/SendPatient.dart';
import 'dart:convert';

Map<String, dynamic> initialResponse ;

class Preview extends StatelessWidget {

  Preview(var response){
    var jsonStr = response;
    initialResponse = jsonDecode(jsonStr);
    //print("HERE --> ${initialResponse['generated_labels']['Advice']}");
  }

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
      body: PreviewPage(),      
    );
  }
}

class PreviewPage extends StatefulWidget {
  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  TextEditingController _nameController;
  TextEditingController _ageController;
  TextEditingController _genderController;
  TextEditingController _symptomController;
  TextEditingController _diagnosisController;
  TextEditingController _medicineController;
  TextEditingController _adviceController;

  TextEditingController _emailController;
  TextEditingController _mobileController;

  String _patientEmail,_patientMobile;

  void initState(){
    super.initState();
    _nameController = TextEditingController(text: (initialResponse['generated_labels']['Name'] != null)? initialResponse['generated_labels']['Name'] : "-");
    _ageController = TextEditingController(text: (initialResponse['generated_labels']['Age'] != null)? initialResponse['generated_labels']['Age'] : "-");
    _genderController = TextEditingController(text: (initialResponse['generated_labels']['Gender'] != null)? initialResponse['generated_labels']['Gender'] : "-");
    _symptomController = TextEditingController(text: (initialResponse['generated_labels']['Symptoms'] != null)? initialResponse['generated_labels']['Symptoms'] : "-");
    _diagnosisController = TextEditingController(text: (initialResponse['generated_labels']['Diagnosis'] != null)? initialResponse['generated_labels']['Diagnosis'] : "-");
    _medicineController = TextEditingController(text: (initialResponse['generated_labels']['Medicines'] != null)? initialResponse['generated_labels']['Medicines'] : "-");
    _adviceController = TextEditingController(text: (initialResponse['generated_labels']['Advice'] != null)? initialResponse['generated_labels']['Advice'] : "-");
  }

  Future<String> createEmailDialog(BuildContext context) async {
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Patient's Email"),
        content:TextField(
          controller: _emailController,
          ),
        actions: <Widget>[
           RaisedButton(
              color: foreground,
              textColor: background,
              child: Text(
                  'Proceed'
              ),
              onPressed:(){
                Navigator.of(context).pop(_emailController.text.toString());
              }
           )
          ],
        );
    });
  }

  Future<String> createMobileDialog(BuildContext context) async {
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Patient's Mobile no. "),
        content:TextField(
          controller: _mobileController,
        ),
        actions: <Widget>[
          RaisedButton(
              color: foreground,
              textColor: background,
              child: Text(
                  'Send Prescription'
              ),
              onPressed:(){
                Navigator.of(context).pop(_mobileController.text.toString());
              }
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    getDeviceSize(context);
    return ListView(
      children: <Widget>[
        //Name Box
        SizedBox(
          width: double.infinity,
          height: deviceHeight * 0.04,  
        ), 
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
        ),
        //Gender
        SizedBox(
          width: double.infinity,
          height: deviceHeight * 0.04,  
        ), 
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _genderController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Gender',
            ),
          ),
        ),
        //Age
        SizedBox(
          width: double.infinity,
          height: deviceHeight * 0.04,  
        ), 
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _ageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Age',
            ),
          ),
        ),
        //Symptoms
        SizedBox(
          width: double.infinity,
          height: deviceHeight * 0.04,  
        ), 
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _symptomController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Symptoms',
            ),
          ),
        ),
        //Diagnosis
        SizedBox(
          width: double.infinity,
          height: deviceHeight * 0.04,  
        ), 
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _diagnosisController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Diagnosis',
            ),
          ),
        ),
        //Medicines
        SizedBox(
          width: double.infinity,
          height: deviceHeight * 0.04,  
        ), 
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _medicineController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Medicines',
            ),
          ),
        ), 
        //Advice
        SizedBox(
          width: double.infinity,
          height: deviceHeight * 0.04,  
        ), 
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _adviceController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Advice',
            ),
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.03,
          width: double.infinity,
        ),
        Center(
          widthFactor: deviceWidth * 0.09,
          child: RaisedButton(
              color: foreground,
              textColor: background,
              child: Text(
                  'Send Prescription'
              ),
              onPressed: () async {
                //_patientEmail =  await createEmailDialog(context);
                //_patientMobile =  await createMobileDialog(context);
                print(_patientEmail);
                print(_patientMobile);
                await sendPatient(context,_nameController.text, _ageController.text,
                _genderController.text, _symptomController.text,
                _diagnosisController.text, _medicineController.text, _adviceController.text);
              }
          ),
        ),
        SizedBox(
          height: deviceHeight * 0.03,
          width: double.infinity,
        )
      ],
      
    );
  }
}
