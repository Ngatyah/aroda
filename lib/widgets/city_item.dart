import 'package:flutter/material.dart';
class CityItem extends StatelessWidget {

  final String title;


  CityItem(this.title);



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.headline6,
              ),
              Text('5')
            ]),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withOpacity(0.5), Colors.white],

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0)
        ),

      ),
    );
  }
}
