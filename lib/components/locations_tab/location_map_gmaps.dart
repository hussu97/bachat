import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GMapsWidget extends StatefulWidget {
  bool _isLocationAvailable;
  final Function loadLocationData;
  Map<MarkerId, Marker> markers;

  GMapsWidget(this._isLocationAvailable, this.loadLocationData, this.markers);

  @override
  _GMapsWidgetState createState() => _GMapsWidgetState();
}

class _GMapsWidgetState extends State<GMapsWidget> {
  GoogleMapController controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId selectedMarker;
  final double _initialLat = 25.3150587;
  final double _initialLon = 55.3696635;
  LatLng _initialPos;
  LatLngBounds _visibleRegion;
  Geolocator geolocator = Geolocator();

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    _loadInitialPosition();
  }

  void _loadRegion() async {
    LatLngBounds visibleRegion = await this.controller.getVisibleRegion();
    setState(() {
      _visibleRegion = visibleRegion;
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
      Position position = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      _initialPos = new LatLng(position.latitude, position.longitude);
    } else {
      _initialPos = new LatLng(_initialLat, _initialLon);
    }
    await this.controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: _initialPos, zoom: 17.0)));
    _loadRegion();
  }

  @override
  void initState() {
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
            indoorViewEnabled: true,
            compassEnabled: true,
            myLocationButtonEnabled: widget._isLocationAvailable,
            myLocationEnabled: widget._isLocationAvailable,
            markers: Set<Marker>.of(markers.values),
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            zoomGesturesEnabled: true,
          ),
        ],
      ),
    );
  }
}
