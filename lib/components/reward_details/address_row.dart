import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../styles.dart';
import '../../models/location.dart';

class AddressRow extends StatelessWidget {
  final Location _location;
  final IconData _iconData;
  final String MAP_LINK = 'http://www.google.com/maps/place/';

  AddressRow(this._location, this._iconData);

  @override
  Widget build(BuildContext context) {
    if (_location.address != null && _location.address.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                _iconData,
                color: Styles.colorGreen,
              ),
              onPressed: () async {
                String link = '$MAP_LINK${_location.lat},${_location.lon}';
                if (await canLaunch(link)) {
                  await launch(link);
                }
              },
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: RichText(
                  text: new TextSpan(
                    children: [
                      TextSpan(
                        text: _location.formattedAddress,
                        style: Styles.textDetailsPageInfo,
                      ),
                      TextSpan(
                        text: ', ',
                        style: Styles.textDetailsPageInfo,
                      ),
                      TextSpan(
                        text: _location.city,
                        style: Styles.textDetailsPageSubtitle,
                      )
                    ],
                  ),
                  textAlign: TextAlign.right,
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
