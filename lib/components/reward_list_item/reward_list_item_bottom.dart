import 'package:flutter/material.dart';

import '../../styles.dart';
import '../reward_origin_logo.dart';

class RewardListItemBottom extends StatelessWidget {
  final String _offer;
  final String _logoUrl;
  final String _rewardOriginLogoUrl;
  RewardListItemBottom(this._offer, this._logoUrl, this._rewardOriginLogoUrl);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ListTile(
        leading: RewardOriginLogo(_logoUrl),
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
