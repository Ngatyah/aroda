import 'package:arodaparcel/journey/awaiting_pickup.dart';
import 'package:flutter/material.dart';
class InTransitScreen extends StatelessWidget {

  static const routeName = '/In-transit-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcel In Transit'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: AwaitingPickUp(2),
            )

          ],
        ),
      ),
    );
  }
}
