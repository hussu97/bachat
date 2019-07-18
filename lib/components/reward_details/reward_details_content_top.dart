import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../styles.dart';

class RewardDetailsContentTop extends StatelessWidget {
  final String _backgroundImage;
  final String _offer;
  final double _height = 250.0;
  final Color _opacityOverlay = Color.fromARGB(0x59, 0, 0, 0);

  RewardDetailsContentTop(this._backgroundImage, this._offer);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment(0.0, 0.0),
            child: FadeInImage.memoryNetwork(
              image: _backgroundImage,
              placeholder: kTransparentImage,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            color: _opacityOverlay,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              _offer,
              style: Styles.textDetailsPageTitle,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
