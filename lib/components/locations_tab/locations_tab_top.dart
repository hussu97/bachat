import 'package:bachat/components/locations_tab/nearby_rewards_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_permissions/location_permissions.dart';

import '../../styles.dart';

class LocationsTabTop extends StatelessWidget {
  final String _baseUrl;
  final String _api;
  final String _programParams;

  LocationsTabTop(this._baseUrl, this._api, this._programParams);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Find rewards near you',
            textAlign: TextAlign.center,
            style: Styles.textLocationTabTitle,
          ),
        ),
        Row(
          children: [
            RaisedButton(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Icon(
                      FontAwesomeIcons.locationArrow,
                      color: Styles.colorDefault,
                      size: 15.0,
                    ),
                  ),
                  Text(
                    'Check out now',
                    style: Styles.textButton,
                    textAlign: TextAlign.center,
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              color: Styles.colorTertiary,
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NearbyRewards(
                      _baseUrl,
                      _api,
                      _programParams,
                    ),
                  ),
                );
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
        Row(children: <Widget>[
          Expanded(
            child: Divider(
              color: Colors.black,
              height: 36.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 5.0,
              left: 5.0,
              top: 30.0,
              bottom: 30.0,
            ),
            child: Text(
              'OR',
              textAlign: TextAlign.center,
              style: Styles.textLocationTabTitle,
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.black,
              height: 36.0,
            ),
          ),
        ]),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Find rewards based on city',
            textAlign: TextAlign.center,
            style: Styles.textLocationTabTitle,
          ),
        ),
      ],
    );
  }
}
