import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../rewards_list.dart';
import '../../styles.dart';

class LocationsList extends StatefulWidget {
  final String _baseUrl;
  final String _api;
  final String _programParams;

  LocationsList(this._baseUrl, this._api, this._programParams);

  @override
  _LocationsListState createState() => _LocationsListState();
}

class _LocationsListState extends State<LocationsList> {
  List cities = new List();
  final Dio dio = new Dio();

  void _loadData() async {
    final response =
        await dio.get('${widget._api}?program=${widget._programParams}');
    print('${widget._api}?program=${widget._programParams}');
    List tempList = new List();
    for (int i = 0; i < response.data['data'].length; i++) {
      tempList.add(response.data['data'][i]);
    }
    setState(() {
      cities.addAll(tempList);
    });
  }

  @override
  void initState() {
    dio.options.baseUrl = widget._baseUrl;
    this._loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (BuildContext context, int index) {
        String cityName = cities[index]['city'];
        String cityCount = cities[index]['count'].toString();
        String title = '$cityName ($cityCount)';
        if (cityName != '') {
          return new Card(
            margin: EdgeInsets.only(
              top: 8.0,
              right: 5.0,
              left: 5.0,
              bottom: 8.0,
            ),
            elevation: 4.0,
            child: ListTile(
              title: Text(
                title,
                style: Styles.textListItemTitle,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                String api =
                    '${widget._api}/$cityName?program=${widget._programParams}';
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
                          title,
                          style: Styles.textScreenTitle,
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
        } else {
          return new SizedBox.shrink();
        }
      },
    );
  }
}
