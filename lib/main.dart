import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:video_assignment/OTPScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sfwidget(),
    );
  }
}

class sfwidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return firstdemo();
  }
}

class firstdemo extends State<sfwidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController phone_number=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication"),
      ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child:Center(
            child:Container(
              padding: EdgeInsets.only(top:130),
            child:Column(
              children:[
                Container(
                  child:Text("Enter your mobile Number:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                ),
                Container(child:
                  TextField(
                    controller: phone_number,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                  ),),
                Container(
                  child:RaisedButton(
                    color: Colors.blue,
                    onPressed:(){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OTPScreen(phone_number.text)));
                    },
                    child:Text("Next"),
                  )
                ),
              ]
            )
          )
        ))
    );
    }
}