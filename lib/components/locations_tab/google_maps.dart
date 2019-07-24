import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:location_permissions/location_permissions.dart';

import '../../styles.dart';

class GMapsWidget extends StatefulWidget {
  final String _baseUrl;
  final String _api;
  final String _programParams;
  bool _isLocationAvailable;
  final Function loadLocationData;
  Map<MarkerId, Marker> markers;

  GMapsWidget(this._baseUrl, this._api, this._programParams,
      this._isLocationAvailable, this.loadLocationData, this.markers);

  @override
  _GMapsWidgetState createState() => _GMapsWidgetState();
}

class _GMapsWidgetState extends State<GMapsWidget> {
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Dio dio = new Dio();
  MarkerId selectedMarker;
  final double _initialLat = 25.3150587;
  final double _initialLon = 55.3696635;
  LatLng _initialPos;
  LatLngBounds _visibleRegion;

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    _loadInitialPosition();
  }

  void _loadRegion() async {
    LatLngBounds visibleRegion = await this.controller.getVisibleRegion();
    setState(() {
      _visibleRegion = visibleRegion;
      print('gonna go to function now');
      widget.loadLocationData(_visibleRegion).then((val) {
        setState(() {
          markers.clear();
          markers.addAll(val);
        });
      });
    });
  }

  void _updateCameraPosition() {
    _loadRegion();
  }

  void _loadInitialPosition() async {
    if (widget._isLocationAvailable) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      _initialPos = new LatLng(position.latitude, position.longitude);
    } else {
      _initialPos = new LatLng(_initialLat, _initialLon);
    }
    await this.controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPos, zoom: 14.0)));
    _loadRegion();
  }

  @override
  void initState() {
    dio.options.baseUrl = widget._baseUrl;
    _loadInitialPosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: ((MediaQuery.of(context).size.height - kToolbarHeight) / 2.0),
      child: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            onCameraIdle: _updateCameraPosition,
            initialCameraPosition: const CameraPosition(
              target: LatLng(25.3150587, 55.3696635),
              zoom: 14.0,
            ),
            markers: Set<Marker>.of(markers.values),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
            child: GestureDetector(
              child: CircleAvatar(
                child: Icon(
                  Icons.location_on,
                  color: Styles.colorTertiary,
                  size: 25.0,
                ),
                backgroundColor: Styles.colorDefault,
              ),
              onTap: () async {
                PermissionStatus permission =
                    await LocationPermissions().checkPermissionStatus();
                if (permission != PermissionStatus.granted) {
                  widget._isLocationAvailable =
                      await LocationPermissions().requestPermissions(
                            permissionLevel:
                                LocationPermissionLevel.locationWhenInUse,
                          ) ==
                          PermissionStatus.granted;
                } else {
                  widget._isLocationAvailable = true;
                }
                setState(() {
                  _loadInitialPosition();
                });
              },
            ),
          ),
        ],
        alignment: Alignment(-1.0, 1.0),
      ),
    );
  }
}
