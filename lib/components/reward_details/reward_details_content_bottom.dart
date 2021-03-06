import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../column_with_heading_and_text.dart';
import '../two_item_row.dart';
import '../../styles.dart';
import '../../models/reward.dart';
import '../../models/location.dart';
import '../icon_builder.dart';
import '../reward_origin_logo.dart';
import './contact_number_row.dart';
import './address_row.dart';

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
          color: Styles.colorTertiary,
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
            'Company site',
            style: Styles.textButton,
          ),
          color: Styles.colorTertiary,
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
          emptyColor: Styles.colorGreen.withAlpha(50),
          fillColor: Styles.colorGreen,
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

  Widget _buildAddressRows(List<Location> locations) {
    if (locations.length == 1) {
      return AddressRow(locations[0], FontAwesomeIcons.locationArrow);
    } else if (locations.length > 1) {
      List<Widget> l = new List();
      locations.forEach(
          (loc) => l.add(AddressRow(loc, FontAwesomeIcons.locationArrow)));
      return ExpansionTile(
        title: Text(
          'Locations (${locations.length})',
          style: Styles.textDetailsPageSubtitle,
          textAlign: TextAlign.center,
        ),
        children: l,
      );
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
      TwoItemRowWithIcon(_reward.cost, FontAwesomeIcons.moneyBill),
      TwoItemRowWithIcon(_reward.expiryDate, FontAwesomeIcons.history),
      ContactNumberRow(_reward.contact, _padding),
      ColumnWithHeadingAndText(
          'Terms & Conditions', _reward.termsAndConditions),
      _buildLinksRow(_reward.link, _reward.website),
      _buildAddressRows(_reward.locations),
    ]);
  }
}
