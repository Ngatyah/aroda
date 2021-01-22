import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:timeago/timeago.dart' as timeago;

class AdminPickUpForm extends StatefulWidget {
  @override
  _AdminPickUpFormState createState() => _AdminPickUpFormState();
}

class _AdminPickUpFormState extends State<AdminPickUpForm> {
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
            .where('status', isEqualTo: 1)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> parcelsSpanShot) {
          if (parcelsSpanShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GroupedListView<dynamic, String>(
            elements: parcelsSpanShot.data.documents,
            groupBy: (e) => e['userId'],
            groupHeaderBuilder: (g) => Padding(
                padding: EdgeInsets.all(8),

                    child: Container(
                      height: 70,
                      child: Card(
                        elevation: 0,
                        child: Column(
                          children: [
                            Row(
                              children:[ Container(
                                margin: EdgeInsets.only(left: 8, right: 8),
                                child: Text(g['shopName'],


                                  style: TextStyle(color: Colors.red,
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                                SizedBox(width: 10,),
                                Text(g['shopPhone'],  style: TextStyle(color: Colors.black,))
                            ]),
                            SizedBox(height: 20,),
                            Text(g['shopLocation'], style: TextStyle(color: Colors.cyan,)),
                        ]),
                      ),
                    ),
                ),
            itemBuilder: (context, e) {
              return Card(
                color: Colors.orange[50],
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8, left: 8),
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                children: [
                                  Row(children:[
                                    Icon(Icons.person, color: Colors.blueGrey, size: 30,),
                                    SizedBox(width: 5,),
                                    Text(e['customerName']),
                                  ] ),
                                  SizedBox(width: 20,),

                                  Row(children:[
                                    Icon(Icons.all_inbox_sharp, color: Colors.blueGrey,size: 30,),
                                    Text(e['parcelName'])]),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children:[
                                  Icon(Icons.add_road, color: Colors.green, size: 20,),
                                  SizedBox(width: 10,),
                                  Text(e['routes'],textAlign: TextAlign.start ),
                                  SizedBox(width: 20,),
                                  Text(e['town'])
                                ]),

                            SizedBox(height: 20,),
                            Row(children:[
                              Icon(Icons.home_work_outlined, color: Colors.blue,),
                              SizedBox(width: 10),
                              Text(e['address'])]),
                            FlatButton.icon(
                              label: Text('Pick'),
                              onPressed: (){
                                setState(() {
                                  Firestore.instance.collection('parcels').document(e.documentID).
                                  updateData({'status': 2});


                                });

                                },
                              icon: Icon(Icons.check, color: Colors.green,size: 20,),
                            )
                          ],
                        )
                      )
                    ],
                  ));
            },
            groupComparator: (group1, group2) => group1.compareTo(group2),
            itemComparator: (item1, item2) =>
                item1['address'].compareTo(item2['address']),
            useStickyGroupSeparators: true,
            floatingHeader: true,
            order: GroupedListOrder.ASC,
          );
        });
  }
}
