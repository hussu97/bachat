import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'package:location_permissions/location_permissions.dart';

import '../../styles.dart';
import './location_map_gmaps.dart';
import '../../rewards_list.dart';
import './location_map_bottom.dart';

class NearbyRewards extends StatefulWidget {
  final String _baseUrl;
  final String _api;
  final String _programParams;
  NearbyRewards(
    this._baseUrl,
    this._api,
    this._programParams,
  );

  @override
  _NearbyRewardsState createState() => _NearbyRewardsState();
}

class _NearbyRewardsState extends State<NearbyRewards> {
  final Dio dio = new Dio();
  Map<MarkerId, Marker> markers = {};
  Map<MarkerId, Marker> tempMarkers = {};
  Function loadLocationData;
  bool _isLocationAvailable = true;

  void _addMarker(markerData, markerList) {
    final MarkerId markerId =
        MarkerId('id_${markerData['lat']}_${markerData['lon']}');
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        markerData['lat'],
        markerData['lon'],
      ),
      infoWindow: InfoWindow(
        title: markerData['formatted_address'],
        snippet: '${markerData['count']} offer(s)',
        onTap: () {
          String api =
              '${widget._api}/${markerData['lat']}/${markerData['lon']}';
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Styles.colorDefaultInverse,
                  ),
                  backgroundColor: Styles.colorDefault,
                  title: Text(
                    markerData['formatted_address'],
                    style: Styles.textScreenTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                body: RewardsList(
                  baseUrl: widget._baseUrl,
                  api: api,
                  programParams: widget._programParams,
                ),
              ),
            ),
          );
        },
      ),
    );
    markerList[markerId] = marker;
  }

  Future _loadLocationData(LatLngBounds visibleRegion) async {
    Map<MarkerId, Marker> tempMarkers = {};
    if (visibleRegion != null) {
      double lat2 = visibleRegion.northeast.latitude;
      double lon2 = visibleRegion.northeast.longitude;
      double lat1 = visibleRegion.southwest.latitude;
      double lon1 = visibleRegion.southwest.longitude;
      final response = await dio.get(
          '${widget._api}?program=${widget._programParams}&coordinates=$lat1,$lon1,$lat2,$lon2&type=marker');
      for (var i in response.data['data']) {
        _addMarker(i, tempMarkers);
      }
      return tempMarkers;
    }
  }

  void _checkLocationPermission() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();
    print(permission);
    bool isLocationAvailable;
    if (permission != PermissionStatus.granted) {
      isLocationAvailable = await LocationPermissions().requestPermissions(
            permissionLevel: LocationPermissionLevel.locationWhenInUse,
          ) ==
          PermissionStatus.granted;
    } else {
      isLocationAvailable = true;
    }
    setState(() {
      _isLocationAvailable = isLocationAvailable;
    });
  }

  @override
  void initState() {
    dio.options.baseUrl = widget._baseUrl;
    loadLocationData = _loadLocationData;
    _checkLocationPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Styles.colorDefaultInverse,
        ),
        backgroundColor: Styles.colorDefault,
        title: Text(
          'Location map',
          style: Styles.textScreenTitle,
        ),
      ),
      body: Column(
        children: <Widget>[
          GMapsWidget(
            widget._baseUrl,
            widget._api,
            widget._programParams,
            _isLocationAvailable,
            loadLocationData,
            markers,
          ),
          LocationMapBottom(
            widget._baseUrl,
            '/coordinates',
            widget._programParams,
            _isLocationAvailable,
            _checkLocationPermission,
          )
        ],
      ),
    );
  }
}
