import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';

import '../../styles.dart';
import './google_maps.dart';
import '../../rewards_list.dart';

class NearbyRewards extends StatefulWidget {
  final String _baseUrl;
  final String _api;
  final String _programParams;
  final bool _isLocationAvailable;

  NearbyRewards(
    this._baseUrl,
    this._api,
    this._programParams,
    this._isLocationAvailable,
  );

  @override
  _NearbyRewardsState createState() => _NearbyRewardsState();
}

class _NearbyRewardsState extends State<NearbyRewards> {
  final Dio dio = new Dio();
  Map<MarkerId, Marker> markers = {};
  Map<MarkerId, Marker> tempMarkers = {};
  Function loadLocationData;

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
    print('in gud function');
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

  @override
  void initState() {
    dio.options.baseUrl = widget._baseUrl;
    loadLocationData = _loadLocationData;
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
            widget._isLocationAvailable,
            loadLocationData,
            markers,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Bottom half work in progress',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
