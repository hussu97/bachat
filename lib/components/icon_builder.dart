import 'package:flutter/material.dart';

class IconBuilder extends StatelessWidget {
  final IconData iconData;

  IconBuilder(this.iconData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Icon(
        iconData,
        color: Color.fromARGB(0xB3, 0, 0, 0),
      ),
    );
  }
}