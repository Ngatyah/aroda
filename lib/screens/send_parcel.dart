import 'package:arodaparcel/widgets/parcel_form.dart';
import 'package:flutter/material.dart';

class SendParcel extends StatefulWidget {
  static const routeName = '/Send-parcels';

  @override
  _SendParcelState createState() => _SendParcelState();
}

class _SendParcelState extends State<SendParcel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aroda Parcels'),
      ),
      body: ParcelForm(),
    );
  }
}
