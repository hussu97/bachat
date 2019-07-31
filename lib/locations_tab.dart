import 'package:flutter/material.dart';

import './styles.dart';
import './components/locations_tab/locations_list.dart';
import './components/locations_tab/locations_tab_top.dart';

class LocationsTab extends StatefulWidget {
  final String _citiesApi;
  final String _locationsApi;
  

  LocationsTab(
    this._citiesApi,
    this._locationsApi,
    
  );

  @override
  _LocationsTabState createState() => _LocationsTabState();
}

class _LocationsTabState extends State<LocationsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
        child: ListView(
          children: <Widget>[
            LocationsTabTop(
              widget._locationsApi,
            ),
            LocationsList(
              widget._citiesApi,
            ),
          ],
        ),
      color: Styles.colorDefault,
    );
  }
}
