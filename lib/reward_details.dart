import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import './models/reward.dart';
import './components/reward_origin_logo.dart';
import './components/two_item_row.dart';
import './components/icon_builder.dart';
import './styles.dart';

class RewardDetails extends StatelessWidget {
  final Reward _reward;

  RewardDetails(this._reward) {
    if (this._reward.cost != null)
      this._reward.cost = this._reward.cost.replaceAll("\n", " ");
    if (this._reward.contact != null)
      this._reward.contact = _contactNumberFormatter(this._reward.contact);
  }

  _contactNumberFormatter(String contact) {
    if (contact.startsWith('0800')) {
      contact = contact.replaceFirst('0800', '800');
    }
    return contact;
  }

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
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            IconBuilder(FontAwesomeIcons.phone),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
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
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          IconBuilder(FontAwesomeIcons.handshake),
          Text(
            rewardOrigin + ' customers',
            style: Styles.textDetailsPageInfo,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.0),
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
        padding: EdgeInsets.all(10.0),
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

  Widget _buildOfferDescriptionRow(String offerDescription) {
    if (offerDescription != null) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              'Offer Description',
              textAlign: TextAlign.center,
              style: Styles.textDetailsPageHeading,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Text(
                offerDescription,
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_reward.companyName),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250.0,
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: FadeInImage.memoryNetwork(
                    image: _reward.backgroundImage,
                    placeholder: kTransparentImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  color: Color.fromARGB(0x59, 0, 0, 0),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    _reward.offer,
                    style: Styles.textDetailsPageTitle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          _buildRewardOriginRow(_reward.rewardOrigin, _reward.rewardOriginLogo),
          _buildOfferDescriptionRow(_reward.offerDescription),
          TwoItemRowWithIcon(_reward.cuisine, FontAwesomeIcons.utensils),
          TwoItemRowWithIcon(_reward.workingHours, FontAwesomeIcons.clock),
          TwoItemRowWithIcon(_reward.location, FontAwesomeIcons.locationArrow),
          TwoItemRowWithIcon(_reward.cost, FontAwesomeIcons.moneyBill),
          _buildContactRow(_reward.contact),
          _buildLinkRow(_reward.link)
        ],
      ),
    );
  }
}
