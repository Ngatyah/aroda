import 'package:arodaparcel/widgets/admin_auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminAuthScreen extends StatefulWidget {

  static const routeName = '/admin-auth-screen';

  @override
  _AdminAuthScreenState createState() => _AdminAuthScreenState();
}

class _AdminAuthScreenState extends State<AdminAuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitForm(String email, String password, BuildContext context) async{
    try {
      setState(() {
        _isLoading = true;
      });
      AuthResult _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = _authResult.user;

      if (user != null) {
        await Firestore.instance
            .collection('users')
            .document(_authResult.user.uid)
            .setData({
          'userName': email,
          'userId': _authResult.user.uid,
          'role': 'Admin'
        });
      }

    }on PlatformException catch(e){
      var message = 'An error occurred, Check your credentials';

      if(e.message != null ){
        message = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ),);
      setState(() {
        _isLoading = false;
      });

    } catch (error){
      print(error);
    }

    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AdminAuthForm(_submitForm,_isLoading)
    );
  }
}
