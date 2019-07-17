import 'package:bachat/models/reward.dart';
import './reward_list_item_bottom.dart';
import './reward_list_item_top.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../reward_details.dart';


class RewardListItem extends StatelessWidget {

  final Reward reward;

  RewardListItem(this.reward){
    // formatting the cases of certain fields
    this.reward.companyName = new ReCase(this.reward.companyName).titleCase;
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Center(
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RewardDetails(reward),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RewardListItemTop(reward.backgroundImage, reward.companyName),
                RewardListItemBottom(reward.offer, reward.logo, reward.rewardOriginLogo)
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 4.0,
        ),
      ),
      padding: EdgeInsets.all(5.0),
    );
  }
}
