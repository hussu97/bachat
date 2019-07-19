import 'package:flutter/material.dart';

import '../styles.dart';

class ColumnWithHeadingAndText extends StatelessWidget {
  final String _heading;
  final String _text;
  final double _padding = 10.0;

  ColumnWithHeadingAndText(this._heading, this._text);

  @override
  Widget build(BuildContext context) {
    if (_text != null && _text.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(_padding),
        child: Column(
          children: <Widget>[
            Text(
              _heading,
              textAlign: TextAlign.center,
              style: Styles.textDetailsPageHeading,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: _padding, right: _padding, top: _padding),
              child: Text(
                _text,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}