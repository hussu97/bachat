import 'package:flutter/material.dart';

import '../styles.dart';

class TextLinesLimiter extends StatefulWidget {
  final String _text;
  final TextStyle _style;
  final int _maxLines;

  TextLinesLimiter(this._text, this._style, this._maxLines);
  @override
  _TextLinesLimiterState createState() => _TextLinesLimiterState();
}

class _TextLinesLimiterState extends State<TextLinesLimiter> {
  bool _isMoreShown = false;
  bool _textBig = false;
  String _showMore = 'see more';
  int _currentLines;

  @override
  void initState() {
    _currentLines = widget._maxLines;
    super.initState();
  }

  Widget _buildShowMoreText() {
    return GestureDetector(
      onTap: () {
        if (_isMoreShown) {
          setState(() {
            _currentLines = widget._maxLines;
            _showMore = 'see more';
            _isMoreShown = !_isMoreShown;
          });
        } else {
          setState(() {
            _currentLines = 1000000000;
            _showMore = 'see less';
            _isMoreShown = !_isMoreShown;
          });
        }
      },
      child: Text(
        _showMore,
        style: TextStyle(
          height: widget._style.height,
          color: Styles.colorTertiary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (widget._text != null && widget._text != '')
        ? LayoutBuilder(builder: (context, size) {
            final span = TextSpan(
              text: widget._text,
              style: widget._style,
            );
            final tp = TextPainter(
              text: span,
              maxLines: _currentLines,
              textDirection: TextDirection.ltr,
            );
            tp.layout(maxWidth: size.maxWidth);
            Widget showMore = _buildShowMoreText();
            if (tp.didExceedMaxLines) {
              _textBig = true;
              return Column(
                children: <Widget>[
                  Text(
                    widget._text,
                    style: widget._style,
                    maxLines: _currentLines,
                  ),
                  showMore
                ],
              );
            } else {
              return Column(
                children: <Widget>[
                  Text(
                    widget._text,
                    style: widget._style,
                  ),
                  _textBig ? showMore : new SizedBox.shrink()
                ],
              );
            }
          })
        : SizedBox.shrink();
  }
}
