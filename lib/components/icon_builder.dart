import 'package:flutter/material.dart';

import './icon_builder_color.dart';

class IconBuilder extends StatelessWidget {
  final IconData _iconData;

  IconBuilder(this._iconData);

  @override
  Widget build(BuildContext context) {
    return IconBuilderColor(_iconData, Color.fromARGB(0xB3, 0, 0, 0));
  }
}
