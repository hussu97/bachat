import 'package:bachat/components/reward_details/reward_details_content_bottom.dart';
import 'package:bachat/components/reward_details/reward_details_content_top.dart';
import 'package:flutter/material.dart';

import '../../models/reward.dart';

class RewardDetailsContent extends StatelessWidget {
  final Reward _reward;

  RewardDetailsContent(this._reward);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewPortConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewPortConstraints.maxHeight,
            ),
            child: Column(
              children: <Widget>[
                RewardDetailsContentTop(_reward.backgroundImage, _reward.offer),
                RewardDetailsContentBottom(_reward),
              ],
            ),
          ),
        );
      },
    );
  }
}
