import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const textSizeDefault = 18.0;
  static const _textSizeSmall = 16.0;
  static const _textSizeXSmall = 14.0;
  static final Color _textColorStrong = Colors.blue;
  static final Color _textColorDefault = _hexToColor('ffffff');
  static final Color _textColorSecondary = _hexToColor('7f8185');
  static final Color _textColorDefaultInverse = _hexToColor('000000');
  static final Color _textColorContactNumber = _hexToColor('0b9620');
  static final String _fontNameDefault = 'Roboto';
  static final FontWeight _fontWeightDefault = FontWeight.w500;
  static final FontWeight _fontWeightLight = FontWeight.w300;
  static final textCardTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: textSizeDefault,
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
    fontSize: textSizeDefault,
    color: _textColorStrong,
    fontWeight: _fontWeightDefault,
  );
  static final textDetailsPageTitle = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorDefault,
    fontWeight: _fontWeightDefault,
  );
  static final textDetailsPageInfo = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeXSmall,
    color: _textColorDefaultInverse,
    fontWeight: _fontWeightLight,
  );
  static final textDetailsPageHeading = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeXSmall,
    color: _textColorSecondary,
    fontWeight: _fontWeightDefault,
  );
  static final textDetailsPageContact = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeXSmall,
    color: _textColorContactNumber,
    fontWeight: _fontWeightLight,
    decoration: TextDecoration.underline
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}