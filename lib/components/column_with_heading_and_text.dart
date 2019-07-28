import 'package:bachat/components/text_line_limiter.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class ColumnWithHeadingAndText extends StatefulWidget {
  final String _heading;
  final String _text;
  final double _padding = 10.0;
  final double _height = 1.1;

  ColumnWithHeadingAndText(this._heading, this._text);

  @override
  _ColumnWithHeadingAndTextState createState() =>
      _ColumnWithHeadingAndTextState();
}

class _ColumnWithHeadingAndTextState extends State<ColumnWithHeadingAndText> {
  @override
  Widget build(BuildContext context) {
    if (widget._text != null && widget._text.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(widget._padding),
        child: Column(
          children: <Widget>[
            Text(
              widget._heading,
              textAlign: TextAlign.center,
              style: Styles.textDetailsPageHeading,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: widget._padding,
                  right: widget._padding,
                  top: widget._padding),
              child: TextLinesLimiter(
                  widget._text, TextStyle(height: widget._height), 5),
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
