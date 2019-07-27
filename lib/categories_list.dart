import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './rewards_list.dart';
import './styles.dart';
import './components/loading_text.dart';

class CategoriesList extends StatefulWidget {
  final String _baseUrl;
  final String _api;
  final String _programParams;

  CategoriesList(this._baseUrl, this._api, this._programParams);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List categories = new List();
  final Dio dio = new Dio();

  void _loadData() async {
    final response =
        await dio.get('${widget._api}?program=${widget._programParams}');
    List tempList = new List();
    response.data['data'].forEach((el) => tempList.add(el));
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
                    '${widget._api}/$categoryName?program=${widget._programParams}';
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

  @override
  Widget build(BuildContext context) {
    Widget child = LoadingText('Loading categories...', Icons.landscape);
    if (categories.isNotEmpty) child = _buildList();
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 12.0),
      child: child,
      color: Styles.colorDefault,
    );
  }
}
