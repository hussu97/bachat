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
          Flexible(
            child: Text(
              '$rewardOrigin customers',
              style: Styles.textDetailsPageSubtitle,
              textAlign: TextAlign.center,
            ),
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

  Widget _buildLinksRow(String link, String website) {
    if (link.isEmpty && website.isEmpty) return new SizedBox.shrink();
    List<Widget> buttons = new List<Widget>();
    if (link != null && link.isNotEmpty) {
      buttons.add(
        RaisedButton(
          child: Text(
            'Offer details',
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
      );
    }
    if (website != null && website.isNotEmpty) {
      buttons.add(
        RaisedButton(
          child: Text(
            'Offer site',
            style: Styles.textButton,
          ),
          color: Styles.textColorTertiary,
          onPressed: () async {
            if (await canLaunch('$website')) {
              await launch('$website');
            } else {
              throw 'Could not launch $website';
            }
          },
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(_padding),
      child: Row(
        children: buttons,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
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

  Widget _buildAddressOrLocationRow(String address, String location) {
    if (address != null && address.isNotEmpty) {
      return TwoItemRowWithIcon(address, FontAwesomeIcons.locationArrow);
    } else {
      return TwoItemRowWithIcon(location, FontAwesomeIcons.locationArrow);
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
      _buildAddressOrLocationRow(_reward.address, _reward.location),
      TwoItemRowWithIcon(_reward.cost, FontAwesomeIcons.moneyBill),
      TwoItemRowWithIcon(_reward.expiryDate, FontAwesomeIcons.history),
      ContactNumberRow(_reward.contact, _padding),
      ColumnWithHeadingAndText(
          'Terms & Conditions', _reward.termsAndConditions),
      _buildLinksRow(_reward.link, _reward.website),
    ]);
  }
}
