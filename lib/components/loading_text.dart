import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../styles.dart';

class LoadingText extends StatelessWidget {
  final String _text;
  final IconData _icon;

  LoadingText(this._text, this._icon);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FadingText(
            _text,
            style: Styles.textScreenTitle,
          ),
          SizedBox(height: 20.0),
          GlowingProgressIndicator(
            child: Icon(
              _icon,
            ),
          )
        ],
      ),
    );
  }
}
