import 'package:bachat/components/reward_details/reward_details_content.dart';
import 'package:bachat/styles.dart';
import 'package:flutter/material.dart';

import './models/reward.dart';

class RewardDetails extends StatelessWidget {
  final Reward _reward;

  RewardDetails(this._reward) {
    // Format reward fields if available
    if (this._reward.cost != null)
      this._reward.cost = this._reward.cost.replaceAll("\n", " ");
    if (this._reward.contact != null)
      this._reward.contact = _contactNumberFormatter(this._reward.contact);
  }

  _contactNumberFormatter(String contact) {
    if (contact.startsWith('0800')) {
      contact = contact.replaceFirst('0800', '800');
    }
    if (contact.contains(new RegExp('[a-zA-Z]+'))){
      print('contact before $contact');
      contact = contact.replaceAll(new RegExp(r'[a-zA-Z]+'), '');
      print('contact after $contact');
    }
    contact = contact.replaceAll(new RegExp(r' '), '');
    return contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Styles.textColorDefaultInverse,
        ),
        backgroundColor: Styles.textColorDefault,
        title: Text(
          _reward.companyName,
          style: Styles.textScreenTitle,
        ),
      ),
      body: RewardDetailsContent(_reward),
    );
  }
}
