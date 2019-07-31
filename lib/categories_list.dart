import 'package:bachat/constants/program_params.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './rewards_list.dart';
import './styles.dart';
import './components/loading_text.dart';
import './components/icon_builder_color.dart';
import './constants/icons.dart';
import './Http_provider.dart';

class CategoriesList extends StatefulWidget {
  final String _api;
  

  CategoriesList(this._api);

  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List categories = new List();
  final HttpProvider http = HttpProvider.http;
  final Map<String, List<dynamic>> categoriesIconsConstants =
      IconConstants.categoryIcons;
  final CancelToken token = new CancelToken();

  void _loadData() async {
    final response =
        await http.get(api: '${widget._api}?program=${programParameters.p}', token: token);
    List tempList = new List();
    response.data['data'].forEach((el) => tempList.add(el));
    setState(() {
      categories.addAll(tempList);
    });
  }

  @override
  void initState() {
    this._loadData();
    super.initState();
  }

  @override
  void dispose() {
    http.cancel(token);
    super.dispose();
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        String categoryName = categories[index]['offer_type'];
        String categoryCount = categories[index]['count'].toString();
        String title = '$categoryName ($categoryCount)';
        IconData icon;
        Color color;
        try {
          List info = categoriesIconsConstants[categoryName];
          icon = info[0];
          color = info[1];
        } catch (e) {
          icon = Icons.location_city;
          color = Styles.colorTertiary;
        }
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
              leading: IconBuilderColor(icon, color),
              title: Text(
                title,
                style: Styles.textListItemTitle,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                String api = '${widget._api}/$categoryName';
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
                      body: Container(
                        child: RewardsList(
                          api: api,
                        ),
                        color: Styles.colorDefault,
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
