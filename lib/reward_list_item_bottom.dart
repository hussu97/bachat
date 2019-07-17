import 'package:bachat/reward_origin_logo.dart';
import 'package:flutter/material.dart';

import './styles.dart';

class RewardListItemBottom extends StatelessWidget {
  final String _offer;
  final String _logoUrl;
  final String _rewardOriginLogoUrl;
  RewardListItemBottom(this._offer, this._logoUrl, this._rewardOriginLogoUrl);

  Widget _buildLogoWidget() {
    if (_logoUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(
          _logoUrl,
        ),
        backgroundColor: Colors.white,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ListTile(
        leading: _buildLogoWidget(),
        title: Text(
          _offer,
          style: Styles.textCardOffer,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: RewardOriginLogo(_rewardOriginLogoUrl),
      ),
    );
  }
}
