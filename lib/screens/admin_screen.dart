import 'package:arodaparcel/screens/admin_pick_up.dart';
import 'package:arodaparcel/screens/auth_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/admin-screen';

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  String tokenId1 = '';

  Future<int> counter(int status) async {
    return await Firestore.instance
        .collection('parcels')
        .where('status', isEqualTo: 1)
        .getDocuments()
        .then((value) {
      var data = value.documents.length;
      return data;
    });
  }

  Future<void> count() async {
    setState(() async {
      var waitPickUp = await counter(1);
      tokenId1 = waitPickUp.toString();
    });
  }


  Future<void> _refreshProducts() async {
    setState(() {
      count();
    });
  }

  Future getPost() async {
    var fireStore = Firestore.instance;
    QuerySnapshot qn = await fireStore.collection('parcels').
    getDocuments();
    return qn.documents;
    //.where('status', isEqualTo: 1)
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aroda Parcel'),
        actions: [
          FlatButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushReplacementNamed(AuthScreen.routeName);
              },
              icon: Icon(Icons.power_settings_new),
              label: Text('Log Out'))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: Container(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AdminPickUp.routeName);
                },
                child: Container(
                  height: 100,
                  child: Card(
                    margin: EdgeInsets.all(15),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.watch,
                              size: 50,
                            ),
                            Text('Parcels Awaiting Pick UP',
                                style: TextStyle(fontSize: 18)),
                            Column(
                              children: [
                                Text(
                                  'Parcels',
                                  style: TextStyle(fontSize: 8),
                                ),
                                Text(
                                  tokenId1,
                                  style:
                                      TextStyle(fontSize: 30, color: Colors.red),
                                )
                              ],
                            )
                          ],
                        )),
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                    future: getPost(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }else {
                        print(
                            'this is my Data ${snapshot.data['destination']}');

                        return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (_, index) {
                            print(snapshot.data.data['destination']);
                            return Card(
                              child: Text(
                                  snapshot.data[index].data['destination']),

                            );
                          },
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Send Parcel',
        child: Icon(Icons.add),
      ),
    );
  }
}
