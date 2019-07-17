import 'package:flutter/material.dart';

class RewardOriginLogo extends StatelessWidget {
  final String _rewardOriginLogoUrl;

  RewardOriginLogo(this._rewardOriginLogoUrl);

  @override
  Widget build(BuildContext context) {
    if (_rewardOriginLogoUrl != null) {
      return Padding(child: ConstrainedBox(
        child: Image.network(
          _rewardOriginLogoUrl,
          fit: BoxFit.scaleDown,
        ),
        constraints: BoxConstraints(
          maxHeight: 30.0,
          maxWidth: 30.0,
          minHeight: 30.0,
          minWidth: 30.0,
        ),
      ),
      padding: EdgeInsets.only(top: 2.0,bottom: 2.0),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}