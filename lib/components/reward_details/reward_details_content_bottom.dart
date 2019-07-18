import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../column_with_heading_and_text.dart';
import '../two_item_row.dart';
import '../../styles.dart';
import '../../models/reward.dart';
import '../icon_builder.dart';
import '../reward_origin_logo.dart';
import './contact_number_row.dart';

class RewardDetailsContentBottom extends StatelessWidget {
  final Reward _reward;
  final double _padding = 10.0;

  RewardDetailsContentBottom(this._reward);

  Widget _buildRewardOriginRow(rewardOrigin, rewardOriginLogo) {
    return Padding(
      padding: EdgeInsets.all(_padding),
      child: Row(
        children: <Widget>[
          IconBuilder(FontAwesomeIcons.handshake),
          Text(
            '$rewardOrigin customers',
            style: Styles.textDetailsPageSubtitle,
          ),
          Padding(
            padding: EdgeInsets.only(right: _padding),
            child: RewardOriginLogo(rewardOriginLogo),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  Widget _buildLinkRow(String link) {
    if (link != null && link.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(_padding),
        child: Center(
          child: RaisedButton(
            child: Text(
              'Check out more',
              style: Styles.textButton,
            ),
            color: Styles.textColorTertiary,
            onPressed: () async {
              if (await canLaunch('$link')) {
                await launch('$link');
              } else {
                throw 'Could not launch $link';
              }
            },
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildRatingRow(String rating) {
    if (rating != null && rating.isNotEmpty) {
      double ratingDouble = double.tryParse(rating);
      if (ratingDouble != null) {
        return FlutterRatingBarIndicator(
          rating: ratingDouble,
          itemCount: 5,
          itemSize: 20.0,
          emptyColor: Styles.textColorGreen.withAlpha(50),
          fillColor: Styles.textColorGreen,
        );
      } else {
        return Text(
          'Rating : $rating',
          style: Styles.textDetailsPageInfo,
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildRewardOriginRow(_reward.rewardOrigin, _reward.rewardOriginLogo),
      ColumnWithHeadingAndText('Offer Description', _reward.offerDescription),
      _buildRatingRow(_reward.rating),
      TwoItemRowWithIcon(_reward.cuisine, FontAwesomeIcons.utensils),
      TwoItemRowWithIcon(_reward.workingHours, FontAwesomeIcons.clock),
      TwoItemRowWithIcon(_reward.location, FontAwesomeIcons.locationArrow),
      TwoItemRowWithIcon(_reward.cost, FontAwesomeIcons.moneyBill),
      TwoItemRowWithIcon(_reward.expiryDate, FontAwesomeIcons.history),
      ContactNumberRow(_reward.contact, _padding),
      ColumnWithHeadingAndText(
          'Terms & Conditions', _reward.termsAndConditions),
      _buildLinkRow(_reward.link),
    ]);
  }
}
