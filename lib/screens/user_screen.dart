import 'dart:async';
import 'package:arodaparcel/screens/auth_screen.dart';
import 'package:arodaparcel/screens/awaiting_pickup_screen.dart';
import 'package:arodaparcel/screens/delivered_screen.dart';
import 'package:arodaparcel/screens/in_destination.dart';
import 'package:arodaparcel/screens/in_transit_screen.dart';
import 'package:arodaparcel/screens/send_parcel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/User-Screen';



  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override

  void initState() {
    getUserData();
    Timer.periodic(Duration(seconds: 1000),(t){

      _refreshProducts();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    initState();
    // TODO: implement dispose
    super.dispose();
  }


  String tokenId1 ='';
  String tokenId2 ='';
  String tokenId3 ='';
  String tokenId4 ='';

  FirebaseUser user;

  getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      count();

      final fbm = FirebaseMessaging();
      fbm.requestNotificationPermissions();
      fbm.configure(onMessage: (msg){
        print(msg);
        return;
      });
    });
  }


  Future<int> counter(int status) async {
    return  await Firestore.instance
        .collection('parcels')
        .where('userId',isEqualTo: user.uid)
        .where('status',isEqualTo: status)
        .getDocuments().then((value) {
         var  data =value.documents.length;
         return data;
        });

    
  }

  Future<void> count() async {
    setState(() async{
      var waitPickUp = await counter(1);
      tokenId1 = waitPickUp.toString();
      var transit = await counter(2);
      tokenId2 =transit.toString();
      var destination = await counter(3);
      tokenId3 = destination.toString();
      var deliver = await counter(4);
      tokenId4 = deliver.toString();

    });

  }
  Future <void> _refreshProducts () async{


    setState(() {
       count();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Aroda Parcels'),
          actions: [
            FlatButton.icon(
                onPressed: () {
                  setState(() {

                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
                    dispose();


                  });
                },
                icon: Icon(Icons.power_settings_new),
                label: Text('Log Out'))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refreshProducts,
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AwaitingPickUpScreen.routeName);
                },
                child: Container(
                  height: MediaQuery. of(context). size. height/5,
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.watch,
                              size: MediaQuery. of(context). size. height/12,
                            ),
                            Text(
                              'Parcels Awaiting Pick-UP',
                              style: TextStyle(fontSize: MediaQuery. of(context). size. height/40),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Parcels',
                                  style: TextStyle(fontSize: MediaQuery. of(context). size. height/60),
                                ),

                                Text(tokenId1,


                                  style:
                                      TextStyle(fontSize: MediaQuery. of(context). size. height/18, color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(InTransitScreen.routeName);
                },
                child: Container(
                  height:MediaQuery. of(context). size. height/5 ,
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.directions_car,
                              size:MediaQuery. of(context). size. height/12,
                              color: Colors.blue,
                            ),
                            Text('Parcels In  Transit',
                                style: TextStyle(fontSize: MediaQuery. of(context). size. height/40)),
                            Column(
                              children: [
                                Text(
                                  'Parcels',
                                  style: TextStyle(fontSize: MediaQuery. of(context). size. height/60),
                                ),
                                Text(
                                  tokenId2,
                                  style:
                                      TextStyle(fontSize: MediaQuery. of(context). size. height/18, color: Colors.blue),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(InDestinationScreen.routeName);
                },
                child: Container(
                  height: MediaQuery. of(context). size. height/5,
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size:MediaQuery. of(context). size. height/12,
                              color: Colors.deepOrange,
                            ),
                            Text('Parcels in Destination',
                                style: TextStyle(fontSize: MediaQuery. of(context). size. height/40)),
                            Column(
                              children: [
                                Text(
                                  'Parcels',
                                  style: TextStyle(fontSize: MediaQuery. of(context). size. height/60),
                                ),
                                Text(
                                  tokenId3,
                                  style: TextStyle(
                                      fontSize: MediaQuery. of(context). size. height/18, color: Colors.deepOrange),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(DeliveredScreen.routeName);
                },
                child: Container(
                  height: MediaQuery. of(context). size. height/4,
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.save_alt,
                              size: MediaQuery. of(context). size. height/12,
                              color: Colors.green,
                            ),
                            Text('Parcels Delivered',
                                style: TextStyle(fontSize: MediaQuery. of(context). size. height/36)),
                            Column(
                              children: [
                                Text(
                                  'Parcels',
                                  style: TextStyle(fontSize: MediaQuery. of(context). size. height/60),
                                ),
                                Text(
                                  tokenId4,
                                  style:
                                      TextStyle(fontSize: MediaQuery. of(context). size. height/18, color: Colors.green),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  'Refund',
                                  style: TextStyle(fontSize: MediaQuery. of(context). size. height/60),
                                ),
                                Text(
                                  '5',
                                  style: TextStyle(fontSize:MediaQuery. of(context). size. height/20,color: Colors.red),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SendParcel.routeName);
          },
          tooltip: 'Send Parcel',
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat);
  }
}
