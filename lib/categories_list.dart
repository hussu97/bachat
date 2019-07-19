import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:recase/recase.dart';

import './rewards_list.dart';
import './styles.dart';

class CategoriesList extends StatefulWidget {
  final String _baseUrl;
  final String _api;

  CategoriesList(this._baseUrl, this._api);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List categories = new List();
  final Dio dio = new Dio();

  void _loadData() async {
    final response = await dio.get(widget._api);
    List tempList = new List();
    for (int i = 0; i < response.data['data'].length; i++) {
      tempList.add(response.data['data'][i]);
    }
    tempList.sort((a, b) => a['offer_type'].compareTo(b['offer_type']));
    setState(() {
      categories.addAll(tempList);
    });
  }

  @override
  void initState() {
    dio.options.baseUrl = widget._baseUrl;
    this._loadData();
    super.initState();
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        String categoryName = categories[index]['offer_type'];
        String categoryCount = categories[index]['count'].toString();
        String title = '$categoryName ($categoryCount)';
        if (categoryName != '') {
          return new Card(
            margin:
                EdgeInsets.only(top: 12.0, right: 5.0, left: 5.0, bottom: 5.0),
            elevation: 4.0,
            child: ListTile(
              title: Text(
                new ReCase(title).sentenceCase,
                style: Styles.textListItemTitle,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                String api = '${widget._api}?category=$categoryName';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        iconTheme: IconThemeData(
                          color: Styles.textColorDefaultInverse,
                        ),
                        backgroundColor: Styles.textColorDefault,
                        title: Text(
                          new ReCase(title).sentenceCase,
                          style: Styles.textScreenTitle,
                        ),
                      ),
                      body: RewardsList(
                        baseUrl: widget._baseUrl,
                        api: api,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      child: _buildList(),
      color: Styles.textColorDefault,
    );
  }
}
