import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:progress_indicators/progress_indicators.dart';

import '../../styles.dart';
import './nearby_location_list_item.dart';
import '../../models/reward.dart';

class LocationMapBottom extends StatefulWidget {
  final bool _isLocationAvailable;
  final Function _checkLocationPermission;
  final String _baseUrl;
  final String _api;
  final String _programParams;

  LocationMapBottom(this._baseUrl, this._api, this._programParams,
      this._isLocationAvailable, this._checkLocationPermission);

  @override
  _LocationMapBottomState createState() => _LocationMapBottomState();
}

class _LocationMapBottomState extends State<LocationMapBottom> {
  Geolocator geolocator = Geolocator();
  List nearbyRewards = new List();
  String moreDataUrl;
  Dio dio = new Dio();
  bool isLoading = false;
  bool isSearchingWidgetVisible = true;
  StreamSubscription<Position> subscription;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    dio.options.baseUrl = widget._baseUrl;
    _initLocationStream();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (subscription != null) subscription.cancel();
    super.dispose();
  }

  void _initLocationStream() {
    print('yoooo');
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 40);
    subscription = geolocator.getPositionStream(locationOptions).listen(
        (Position position) {
      if (position != null && !position.mocked) {
        setState(() {
          isSearchingWidgetVisible = false;
        });
        _loadData(position.latitude, position.longitude);
      }
      print(position.latitude.toString() + ' ' + position.longitude.toString());
    }, onDone: () {
      print('we gucci');
    }, onError: (error) {
      print('error occured $error');
    });
  }

  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    final response = await dio.get(moreDataUrl);
    List tempList = new List();
    moreDataUrl = response.data['next'];
    for (int i = 0; i < response.data['data'].length; i++) {
      tempList.add(response.data['data'][i]);
    }

    setState(() {
      isLoading = false;
      nearbyRewards.addAll(tempList);
    });
  }

  void _loadData(lat, lon) {
    moreDataUrl = '${widget._api}/$lat/$lon?program=${widget._programParams}';
    nearbyRewards.clear();
    _getMoreData();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(20.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      //+1 for progressbar
      itemCount: nearbyRewards.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == nearbyRewards.length && moreDataUrl == '') {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'How you doin? 😏',
              style: Styles.textDetailsPageInfo,
              textAlign: TextAlign.center,
            ),
          );
        }
        if (index == nearbyRewards.length) {
          return _buildProgressIndicator();
        } else {
          double distance = nearbyRewards[index]['dist'];
          return new NearbyLocationListItem(
              distance, Reward.fromJson(nearbyRewards[index]));
        }
      },
      controller: _scrollController,
    );
  }

  Widget _loadWidget() {
    if (widget._isLocationAvailable) {
      return _buildList();
    } else {
      return Center(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.locationArrow,
                color: Styles.colorTertiary,
              ),
              onPressed: () async {
                widget._checkLocationPermission();
              },
            ),
            Text(
              'Enable location to view nearby offers',
              style: Styles.textDetailsPageHeading,
              maxLines: 2,
              overflow: TextOverflow.fade,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Visibility(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FadingText(
                'Searching for nearby offers...',
                style: Styles.textScreenTitle,
              ),
              SizedBox(height: 20.0),
              GlowingProgressIndicator(
                child: Icon(
                  Icons.laptop_windows,
                ),
              )
            ],
          ),
        ),
        replacement: Padding(
          padding: EdgeInsets.all(10.0),
          child: _loadWidget(),
        ),
        visible: isSearchingWidgetVisible,
      ),
    );
  }
}
