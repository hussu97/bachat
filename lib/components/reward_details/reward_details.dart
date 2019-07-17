import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/reward.dart';
import '../reward_origin_logo.dart';
import '../../styles.dart';

class RewardDetails extends StatelessWidget {
  final Reward _reward;

  RewardDetails(this._reward) {
    this._reward.cost = this._reward.cost.replaceAll("\n", " ");
    this._reward.contact = _contactNumberFormatter(this._reward.contact);
  }

  _contactNumberFormatter(String contact) {
    if (contact.startsWith('0800')) {
      contact = contact.replaceFirst('0800', '800');
    }
    return contact;
  }

  Widget _buildIcon(iconData) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0),
      child: Icon(
        iconData,
        color: Color.fromARGB(0xB3, 0, 0, 0),
      ),
    );
  }

  Widget _buildCostRow(cost) {
    if (cost != null) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            _buildIcon(FontAwesomeIcons.moneyBill),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                cost,
                style: Styles.textDetailsPageInfo,
              ),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      );
    } else {
      return new SizedBox.shrink();
    }
  }

  List<TextSpan> _buildContactNumber(String contact) {
    List<String> contactsList = contact.split(',');
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
            text: ' , ',
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
            _buildIcon(FontAwesomeIcons.phone),
            Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: RichText(
                text: new TextSpan(
                  children: _buildContactNumber(contact),
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
          _buildIcon(FontAwesomeIcons.handshake),
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
          _buildCostRow(_reward.cost),
          _buildContactRow(_reward.contact),
          _buildLinkRow(_reward.link)
        ],
      ),
    );
  }
}
