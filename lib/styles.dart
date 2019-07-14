import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 18.0;
  static const _textSizeSmall = 16.0;
  static final Color _textColorStrong = Colors.blue;
  static final Color _textColorDefault = _hexToColor('ffffff');
  static final Color _textColorDefaultInverse = _hexToColor('000000');
  static final String _fontNameDefault = 'Roboto';
  static final FontWeight _fontWeightDefault = FontWeight.w500;
  static final FontWeight _fontWeightLight = FontWeight.w300;
  static final textCardTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
    fontWeight: _fontWeightLight,
  );
  static final textCardSubtitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeSmall,
    color: _textColorDefault,
    fontWeight: _fontWeightLight,
  );
  static final textCardOffer = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
    fontWeight: _fontWeightDefault,
  );
  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
    fontWeight: _fontWeightDefault,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}