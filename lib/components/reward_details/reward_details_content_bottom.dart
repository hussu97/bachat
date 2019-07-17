import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../column_with_heading_and_text.dart';
import '../two_item_row.dart';
import '../../styles.dart';
import '../../models/reward.dart';
import '../icon_builder.dart';

class RewardDetailsContentBottom extends StatelessWidget {
  final Reward _reward;
  final double _padding = 10.0;

  RewardDetailsContentBottom(this._reward);

List<TextSpan> _buildContactNumber(String contact) {
    List<String> contactsList = contact.split(',');
    contactsList = contact.split('|');
    contactsList = contact.split('/');
    List<TextSpan> contacts = new List<TextSpan>();
    print(contactsList);
    for (var i = 0; i < contactsList.length; i++) {
      String tmp = contactsList[i];
      contacts.add(
        new TextSpan(
          text: tmp,
          style: Styles.textDetailsPageContact,
          recognizer: new TapGestureRecognizer()
            ..onTap = () async {
              if (await canLaunch('tel:$tmp')) {
                await launch('tel:$tmp');
              } else {
                throw 'Could not launch $tmp';
              }
            },
        ),
      );
      if (i != contactsList.length - 1) {
        contacts.add(
          new TextSpan(
            text: ',',
            style: Styles.textDetailsPageInfo,
          ),
        );
      }
    }
    return contacts;
  }

  Widget _buildContactRow(String contact) {
    if (contact != null) {
      return Padding(
        padding: EdgeInsets.all(_padding),
        child: Row(
          children: <Widget>[
            IconBuilder(FontAwesomeIcons.phone),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: _padding, left: _padding),
                child: RichText(
                  text: new TextSpan(
                    children: _buildContactNumber(contact),
                  ),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      );
    } else {
      return new SizedBox.shrink();
    }
  }

  Widget _buildRewardOriginRow(rewardOrigin, rewardOriginLogo) {
    return Padding(
      padding: EdgeInsets.all(_padding),
      child: Row(
        children: <Widget>[
          IconBuilder(FontAwesomeIcons.handshake),
          Text(
            rewardOrigin + ' customers',
            style: Styles.textDetailsPageInfo,
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

  Widget _buildLinkRow(link) {
    if (link != null) {
      return Padding(
        padding: EdgeInsets.all(_padding),
        child: Center(
          child: RaisedButton(
            child: Text(
              'Check out more',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlueAccent,
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

  Widget _buildRatingRow(rating) {
    if (rating != null) {
      rating = double.parse(rating);
      return FlutterRatingBarIndicator(
        rating: rating,
        itemCount: 5,
        itemSize: 20.0,
        emptyColor: Styles.textColorGreen.withAlpha(50),
        fillColor: Styles.textColorGreen,
      );
    } else {
      return SizedBox.shrink();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      _buildRewardOriginRow(
        _reward.rewardOrigin,
        _reward.rewardOriginLogo,
      ),
      ColumnWithHeadingAndText('Offer Description', _reward.offerDescription),
      _buildRatingRow(_reward.rating),
      TwoItemRowWithIcon(_reward.cuisine, FontAwesomeIcons.utensils),
      TwoItemRowWithIcon(_reward.workingHours, FontAwesomeIcons.clock),
      TwoItemRowWithIcon(_reward.location, FontAwesomeIcons.locationArrow),
      TwoItemRowWithIcon(_reward.cost, FontAwesomeIcons.moneyBill),
      TwoItemRowWithIcon(_reward.expiryDate, FontAwesomeIcons.history),
      _buildContactRow(_reward.contact),
      ColumnWithHeadingAndText(
          'Terms & Conditions', _reward.termsAndConditions),
      _buildLinkRow(_reward.link),
      ]
    );
  }
}
