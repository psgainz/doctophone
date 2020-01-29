import 'package:flutter/material.dart';
import 'package:doctophone/Miscellaneous/GlobalVariables.dart';

List<String> dummyList ;

class PrescriptionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child : SwipeList()),      
    );
  }
}

class SwipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<SwipeList> {

  void initState(){
    super.initState();
    buildDummyList();
    for(var i=0;i<dummyList.length;i++){
      print(dummyList[i]);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: _buildList(),      
    );
  }

  void buildDummyList(){
    dummyList = new List<String>();

    for(var i=0;i<10;i++){
      dummyList.add('Patient Name : XYZ');
    }
  }

  Widget _buildList(){

    return ListView.builder(
        itemCount: dummyList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                dummyList.removeAt(index);
              });
            },
            direction: DismissDirection.endToStart,
            child: Card(
              elevation: 5,
              child: Container(
                height: 80.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 80.0,
                      width: deviceWidth * 0.83,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              dummyList[index].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Container(
                                width: deviceWidth * 0.72,
                                child: Text(
                                  'Mobile : 8888871113',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 48, 48, 54)
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80.0,
                      child: IconButton(
                        iconSize: 20,
                        icon: Icon(Icons.arrow_forward_ios),
                        tooltip: 'Get anaysis',
                        onPressed: (){
                          //Button Code
                        }
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );
  }
}