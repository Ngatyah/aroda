import 'package:arodaparcel/screens/Admin_auth_Screen.dart';
import 'package:arodaparcel/screens/admin_pick_up.dart';
import 'package:arodaparcel/screens/admin_screen.dart';
import 'package:arodaparcel/screens/auth_screen.dart';
import 'package:arodaparcel/screens/awaiting_pickup_screen.dart';
import 'package:arodaparcel/screens/delivered_screen.dart';
import 'package:arodaparcel/screens/in_destination.dart';
import 'package:arodaparcel/screens/in_transit_screen.dart';
import 'package:arodaparcel/screens/send_parcel.dart';
import 'package:arodaparcel/screens/user_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('What is this Data ${snapshot.data}');
              FirebaseAuth.instance.currentUser().then((user) {
                Firestore.instance.collection('users').where('userId', isEqualTo: user.uid)
                    .getDocuments().then((docs){
                      if(docs.documents[0].exists){
                        print('Are we Getting to this Point ${docs.documents[0].data}');
                        if(docs.documents[0].data['role']=='Admin'){
                          Navigator.of(context).pushReplacementNamed(AdminScreen.routeName);
                        }else {
                          Navigator.of(context).pushReplacementNamed(
                              UserScreen.routeName);
                        }

                      }
                });
              });

            }


            return AuthScreen();
          }),
      routes: {
        UserScreen.routeName: (context) => UserScreen(),
        AdminScreen.routeName: (context)=> AdminScreen(),
        SendParcel.routeName: (context) => SendParcel(),
        AwaitingPickUpScreen.routeName: (context) => AwaitingPickUpScreen(),
        InTransitScreen.routeName: (context) => InTransitScreen(),
        InDestinationScreen.routeName: (context) => InDestinationScreen(),
        DeliveredScreen.routeName: (context) => DeliveredScreen(),
        AdminAuthScreen.routeName: (context) => AdminAuthScreen(),
        AuthScreen.routeName: (context)=> AuthScreen(),
        AdminPickUp.routeName: (context)=> AdminPickUp(),
      },
    );
  }
}
