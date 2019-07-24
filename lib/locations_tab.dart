import 'package:flutter/material.dart';

import './styles.dart';
import './components/locations_tab/locations_list.dart';
import './components/locations_tab/locations_tab_top.dart';

class LocationsTab extends StatefulWidget {
  final String _baseUrl;
  final String _citiesApi;
  final String _locationsApi;
  final String _programParams;

  LocationsTab(
    this._baseUrl,
    this._citiesApi,
    this._locationsApi,
    this._programParams,
  );

  @override
  _LocationsTabState createState() => _LocationsTabState();
}

class _LocationsTabState extends State<LocationsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
      child: Column(
        children: <Widget>[
          LocationsTabTop(
            widget._baseUrl,
            widget._locationsApi,
            widget._programParams,
          ),
          Expanded(
            child: LocationsList(
              widget._baseUrl,
              widget._citiesApi,
              widget._programParams,
            ),
          )
        ],
      ),
      color: Styles.colorDefault,
    );
  }
}
