import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 18.0;
  static const _textSizeSmall = 16.0;
  static const _textSizeXSmall = 14.0;
  static final Color textColorDefault = _hexToColor('ffffff');
  static final Color _textColorSecondary = _hexToColor('7f8185');
  static final Color textColorTertiary = Colors.blue;
  static final Color textColorDefaultInverse = _hexToColor('000000');
  static final Color textColorGreen = _hexToColor('0b9620');
  static final String _fontNameTitle = 'Montserrat';
  static final String _fontNameText = 'Roboto';
  static final FontWeight _fontWeightBold = FontWeight.w700;
  static final FontWeight _fontWeightDefault = FontWeight.w500;
  static final FontWeight _fontWeightLight = FontWeight.w300;
  static final textScreenTitle = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeDefault,
    color: textColorDefaultInverse,
    fontWeight: _fontWeightBold,
  );
  static final textCardTitle = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeDefault,
    color: textColorDefault,
    fontWeight: _fontWeightLight,
  );
  static final textCardSubtitle = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeSmall,
    color: textColorDefault,
    fontWeight: _fontWeightLight,
  );
  static final textCardOffer = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeDefault,
    color: textColorDefaultInverse,
    fontWeight: _fontWeightDefault,
  );
  static final textDetailsPageTitle = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeLarge,
    color: textColorDefault,
    fontWeight: _fontWeightDefault,
  );
  static final textDetailsPageSubtitle = TextStyle(
    fontFamily: _fontNameText,
    fontSize: _textSizeXSmall,
    color: textColorDefaultInverse,
    fontWeight: _fontWeightBold,
  );
  static final textDetailsPageInfo = TextStyle(
    fontFamily: _fontNameText,
    fontSize: _textSizeXSmall,
    color: textColorDefaultInverse,
    fontWeight: _fontWeightLight,
  );
  static final textDetailsPageHeading = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeXSmall,
    color: _textColorSecondary,
    fontWeight: _fontWeightDefault,
  );
  static final textDetailsPageContact = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeXSmall,
    color: textColorGreen,
    fontWeight: _fontWeightLight,
    decoration: TextDecoration.underline,
  );
  static final textListItemTitle = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeXSmall,
    color: textColorDefaultInverse,
    fontWeight: _fontWeightDefault,
  );
  static final textTabBar = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeSmall,
    fontWeight: _fontWeightLight,
  );
  static final textTabBarSelected = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeSmall,
    fontWeight: _fontWeightDefault,
  );
  static final textButton = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeSmall,
    fontWeight: _fontWeightDefault,
    color: textColorDefault
  );
  static final textSearchUnfocus = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeXSmall,
    color: _textColorSecondary,
    fontWeight: _fontWeightDefault,
  );
  static final textSearchFocus = TextStyle(
    fontFamily: _fontNameTitle,
    fontSize: _textSizeXSmall,
    color: textColorDefaultInverse,
    fontWeight: _fontWeightBold,
  );
  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
