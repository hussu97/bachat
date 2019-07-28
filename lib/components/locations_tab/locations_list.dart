import 'package:bachat/components/icon_builder_color.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../rewards_list.dart';
import '../../styles.dart';
import '../loading_text.dart';
import '../../constants/icons.dart';

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
  final Map<String, List<dynamic>> citiesIconsConstants = IconConstants.cityIcons;

  void _loadData() async {
    final response =
        await dio.get('${widget._api}?program=${widget._programParams}');
    List tempList = new List();
    response.data['data'].forEach((el) => tempList.add(el));
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

  List<Widget> _buildList() {
    List<Widget> widgets = new List();
    for (var city in cities) {
      String cityName = city['city'];
      String cityCount = city['count'].toString();
      String title = '$cityName ($cityCount)';
      IconData icon;
      Color color;
      try {
          List info = citiesIconsConstants[cityName];
          icon = info[0];
          color = info[1];
        } catch (e) {
          icon = Icons.location_city;
          color = Styles.colorTertiary;
        }
      if (cityName != '') {
        widgets.add(
          new Card(
            margin: EdgeInsets.only(
              top: 8.0,
              right: 5.0,
              left: 5.0,
              bottom: 8.0,
            ),
            elevation: 4.0,
            child: ListTile(
              leading: IconBuilderColor(icon, color),
              title: Text(
                title,
                style: Styles.textListItemTitle,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                String api = '${widget._api}/$cityName';
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
          ),
        );
      } else {
        widgets.add(SizedBox.shrink());
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> child = [LoadingText('Loading cities...', Icons.landscape)];
    if (cities.isNotEmpty) child = _buildList();
    return Column(children: child);
  }
}
