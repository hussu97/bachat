import 'package:flutter/material.dart';

class IconBuilderColor extends StatelessWidget {
  final IconData _iconData;
  final Color _color;

  IconBuilderColor(this._iconData, this._color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Icon(
        _iconData,
        color: _color,
      ),
    );
  }
}
