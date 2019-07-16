import 'package:flutter/material.dart';

import './styles.dart';

class RewardListItemTop extends StatelessWidget {
  final String _backgroundImageUrl;
  final String _companyName;
  final double _widgetHeight = 150.0;

  RewardListItemTop(this._backgroundImageUrl, this._companyName);

  Widget _buildBackgroundImage(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: _widgetHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: NetworkImage(_backgroundImageUrl),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildCompanyNameText(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: _widgetHeight,
      child: Align(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0, left: 10.0),
          child: Text(
            _companyName,
            style: Styles.textCardTitle,
          ),
        ),
        alignment: Alignment.bottomLeft,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackgroundImage(context),
        _buildCompanyNameText(context),
      ],
    );
  }
}
