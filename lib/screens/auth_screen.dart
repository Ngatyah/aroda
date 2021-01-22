import 'package:arodaparcel/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {

  static const routeName = '/Auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(String userName, String userPhone, String userCode,
      String shopLocation) {

    _auth.verifyPhoneNumber(
        phoneNumber: userPhone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            await Firestore.instance
                .collection('users')
                .document(result.user.uid)
                .setData({
              'userName': userName,
              'userPhone': userPhone,
              'shopLocation': shopLocation,
              'userId': result.user.uid,
               'role': 'user'
            });
          }
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) async {
          AuthCredential credential = PhoneAuthProvider.getCredential(
              verificationId: verificationId, smsCode: userCode);
          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            await Firestore.instance
                .collection('users')
                .document(result.user.uid)
                .setData({
              'userName': userName,
              'userPhone': userPhone,
              'shopLocation': shopLocation,
              'userId': result.user.uid,
              'role': 'user'
            });
          }
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print("codeAutoRetrievalTimeout");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      AuthForm(_submitAuthForm,),
    );
  }
}

