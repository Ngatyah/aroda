import 'package:arodaparcel/journey/awaiting_pickup.dart';
import 'package:flutter/material.dart';
class InDestinationScreen extends StatelessWidget {

  static const routeName = '/In_destination';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcel in Destination'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: AwaitingPickUp(3),
            )

          ],
        ),
      ),
    );
  }
}
