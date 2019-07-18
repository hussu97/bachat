import 'package:flutter/material.dart';

import '../styles.dart';
import './icon_builder.dart';

class TwoItemRowWithIcon extends StatelessWidget {
  final IconData iconData;
  final String text;

  TwoItemRowWithIcon(this.text, this.iconData);

  @override
  Widget build(BuildContext context) {
    if (text != null && text.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            IconBuilder(iconData),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Text(
                  text,
                  style: Styles.textDetailsPageInfo,
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      );
    } else {
      return new SizedBox.shrink();
    }
  }
}
