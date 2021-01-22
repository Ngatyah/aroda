import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class CounterModel extends StatefulWidget {
  @override
  _CounterModelState createState() => _CounterModelState();
}

class _CounterModelState extends State<CounterModel> {


  FirebaseUser user;


  getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print('This is the goal ${userData.uid}');
    });
  }

  counter(int status){
   var count = Firestore.instance
        .collection('parcels')
        .where('userId',isEqualTo: user.uid)
        .where('status',isEqualTo: status)
        .orderBy('time', descending: true)
        .snapshots().length;
   return count;

  }

  @override
  void initState() {
    getUserData();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(counter(1)),
    );
  }
}


