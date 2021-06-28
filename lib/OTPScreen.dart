
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:video_assignment/main.dart';
class OTPScreen extends StatefulWidget
{
  final String phone;
  OTPScreen(this.phone);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OTPScreen_code(phone);
  }
}
class OTPScreen_code extends State<OTPScreen> {
  String verify="";
  final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(43, 46, 66, 1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: const Color.fromRGBO(126, 203, 224, 1),
      ));
  final String phone;
  final GlobalKey<ScaffoldState> _key=GlobalKey<ScaffoldState>();
  OTPScreen_code(this.phone);
  @override
  Widget build(BuildContext context) {
    final _pinPutController = TextEditingController();
    final _pinPutFocusNode = FocusNode();
    // TODO: implement build
    return Scaffold(
      key: _key,
        appBar: AppBar(
          title: Text("OTP Verification"),
        ),
        body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 70),
                child: Center(child: Text("Verify $phone", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),)),),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 6,
                  withCursor: true,
                  textStyle: const TextStyle(
                      fontSize: 25.0, color: Colors.white),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 55.0,
                  onSubmit: (pin)async {
                    try {
                      await FirebaseAuth.instance.signInWithCredential(
                          PhoneAuthProvider.credential(
                              verificationId: verify, smsCode: pin)).then((
                          value) async {
                        if (value.user != null) {
                          print("Logged in");
                        }
                      });
                    }
                    catch(e) {
                      FocusScope.of(context).unfocus();
                      _key.currentState!.showSnackBar(SnackBar(content: Text("Invalid otp")));
                    }
                  },
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                ),
              )
            ]));
  }

  verifyphone(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credentials)async{
          await FirebaseAuth.instance.signInWithCredential( credentials).then((value) async{
            if(value.user!=null)
              {
                print("logged in");
              }
          });
        },
        verificationFailed: (FirebaseAuthException e)
      {
        print(e.message);
      },
        codeSent: (String verificationID, int resendToken) {
          setState(() {
            verify=verificationID;
          });
        },
        codeAutoRetrievalTimeout:(String verificationID)
      {
        setState(() {
          verify=verificationID;
        });
        },
        timeout: Duration(seconds: 60),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    verifyphone(phone);
  }
}