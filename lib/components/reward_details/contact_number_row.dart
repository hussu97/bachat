import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

import '../icon_builder.dart';
import '../../styles.dart';

class ContactNumberRow extends StatelessWidget {
  final String _contact;
  final double _padding;

  ContactNumberRow(this._contact, this._padding);

  List<TextSpan> _buildContactNumber(String contact) {
    List<String> contactsList = contact.split(',');
    contactsList = contact.split('|');
    contactsList = contact.split('/');
    List<TextSpan> contacts = new List<TextSpan>();
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

  @override
  Widget build(BuildContext context) {
    if (_contact != null && _contact.isNotEmpty) {
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
                    children: _buildContactNumber(_contact),
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
}
