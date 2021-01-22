import 'package:flutter/material.dart';

class City  {

  final String id;
  final String title;
  final Color color;


   const City({
    @required this.id,
    @required this.title,
    this.color=Colors.orange});
}