import 'package:arodaparcel/journey/awaiting_pickup.dart';
import 'package:flutter/material.dart';
class AwaitingPickUpScreen extends StatelessWidget {

  static const routeName = '/Awaiting-pickup-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcel Awaiting PickUp'),
          ),
      body: Container(
        child: Column(
          children: [
           Expanded(
             child: AwaitingPickUp(1),
           )

          ],
        ),
      ),
    );
  }
}
