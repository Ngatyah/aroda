import 'package:arodaparcel/widgets/admin_pickup_form.dart';
import 'package:flutter/material.dart';
class AdminPickUp extends StatelessWidget {
  static const routeName = '/admin-pickUp';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Ups'),
      ),
      body: Center(
        child: AdminPickUpForm(),
      ),
    );
  }
}
