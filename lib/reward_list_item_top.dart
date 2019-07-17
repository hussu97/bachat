import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
      child: ClipRRect(
        child: FadeInImage.memoryNetwork(
          image: _backgroundImageUrl,
          placeholder: kTransparentImage,
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
    );
  }

  Widget _buildCompanyNameText() {
    return Container(
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: _widgetHeight,
      child: Stack(
        children: <Widget>[
          _buildBackgroundImage(context),
          Container(
            decoration: new BoxDecoration(
              color: Color.fromARGB(0x26, 0, 0, 0),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
          ),
          _buildCompanyNameText(),
        ],
      ),
    );
  }
}
