import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './rewards_list.dart';
import './styles.dart';

class ProgramsList extends StatefulWidget {
  final String _baseUrl;
  final String _api;

  ProgramsList(this._baseUrl, this._api);

  @override
  _ProgramsListState createState() => _ProgramsListState();
}

class _ProgramsListState extends State<ProgramsList> {
  List programs = new List();
  final Dio dio = new Dio();

  void _loadData() async {
    final response = await dio.get(widget._api);
    List tempList = new List();
    for (int i = 0; i < response.data['data'].length; i++) {
      tempList.add(response.data['data'][i]);
    }

    setState(() {
      programs.addAll(tempList);
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
      itemCount: programs.length,
      itemBuilder: (BuildContext context, int index) {
        String logoUrl = programs[index]['reward_origin_logo'];
        String programName = programs[index]['reward_origin'];
        String programCount = programs[index]['count'].toString();
        String title = '$programName ($programCount)';
        return new Card(
          margin: EdgeInsets.only(top: 14.0, right: 5.0, left: 5.0),
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(logoUrl),
              backgroundColor: Colors.white,
            ),
            title: Text(
              title,
              style: Styles.textListItemTitle,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              String api = '${widget._api}?program=$programName';
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
                        title,
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
