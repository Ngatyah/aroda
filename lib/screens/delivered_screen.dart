import 'package:arodaparcel/journey/awaiting_pickup.dart';
import 'package:flutter/material.dart';
class DeliveredScreen extends StatelessWidget {

  static const routeName = '/delivered';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delivered Parcels'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: AwaitingPickUp(4),
            )

          ],
        ),
      ),
    );
  }
}
