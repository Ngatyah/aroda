import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class AwaitingPickUp extends StatefulWidget {
   final int status;
AwaitingPickUp(this.status) ;
  @override
  _AwaitingPickUpState createState() => _AwaitingPickUpState();
}

class _AwaitingPickUpState extends State<AwaitingPickUp> {

  FirebaseUser user;


  getUserData() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();
    setState(() {
      user = userData;
      print('This is the goal ${userData.uid}');

    });
  }

  @override
  void initState() {
    getUserData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _ago(Timestamp t) {
      return timeago.format(t.toDate());
    }


    return StreamBuilder(
        stream: Firestore.instance
            .collection('parcels')
            .where('userId',isEqualTo: user.uid)
        .where('status',isEqualTo: widget.status)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> parcelsSpanShot) {
          if (parcelsSpanShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          return ListView(
            children: parcelsSpanShot.data.documents
                .map((e) => Center(
                        child: Container(
                      color: Colors.grey[400],
                      width: MediaQuery.of(context).size.width,

                      child: Card(
                        margin: EdgeInsets.all(8),
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('Name:'+
                                           e['customerName'],
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Route: ' + e['routes']),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Phone: ' + e['customerPhone']),
                                    SizedBox(height: 20,),
                                    Text('Let me see how far this can go ${e['address']}')
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Item Name',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Text(e['parcelName']),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      e['weight'],
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Text(
                                      _ago(e['time']),
                                    )
                                  ],
                                ),

                              ],

                            )),
                      ),
                    )))
                .toList(),
          );

        });
  }

}







