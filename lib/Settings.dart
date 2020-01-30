import 'package:flutter/material.dart';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';
import 'package:doctophone/Miscellaneous/AppColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doctophone/Authentication/BlankVerificaton.dart';
import 'package:doctophone/Authentication/SignOut.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  bool c1 = true,c2 = true, c3 = false;

  @override
  Widget build(BuildContext context) {
    getDeviceSize(context);
    return Container(
      width: deviceWidth,
      color: background,
      child: ListView(
        children: <Widget>[
          Container(
            width: deviceWidth,
            color: Colors.grey[100],
            child: Row(
              children: <Widget>[
                Container(
                  width: deviceWidth * 0.15,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Icon(
                      FontAwesomeIcons.userAlt,
                      color: enabled,
                    ),
                  ),
                ),
                Text(
                  '  '
                ),
                Flexible(
                  child: Text(
                    '(' + email.toString() + ')',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: enabled,
                    ),
                  ),
                ),
              ],
            ),
          ),
          CheckboxListTile(
            title: Text(
              'Setting 1',
              style: TextStyle(
                color: enabled
              ),
            ),
            value: c1,
            onChanged: (bool value) {
              setState(() {
                c1 = value;
              });
            },
            secondary: Icon(
              Icons.headset,
              color: enabled
            ),
          ),
          CheckboxListTile(
            title: Text(
              'Setting 2',
              style: TextStyle(
                color: enabled
              ),
            ),
            value: c2,
            onChanged: (bool value) {
              setState(() {
                c2 = value;
              });
            },
            secondary: Icon(
              Icons.headset,
              color: enabled
            ),
          ),
          SwitchListTile(
            title: Text(
              'Setting 3',
              style: TextStyle(
                color: enabled
              ),
            ),
            value: c3,
            onChanged: (bool value) {
              setState(() {
                c3 = value;
              });
            },
            secondary: Icon(
              Icons.mic,
              color: enabled
            ),
          ),
          Center(
            child: Container(
              child: RaisedButton(
                child: Text(
                  'SIGN OUT'
                ),
                
                onPressed: () async {
                  await signOut();
                  setState(() {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) =>
                          Login()
                      ), 
                      (Route<dynamic> route) => false
                    );
                  });                  
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}