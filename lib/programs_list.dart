import 'package:bachat/components/reward_origin_logo.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './rewards_list.dart';
import './styles.dart';
import './components/loading_text.dart';

class ProgramsList extends StatefulWidget {
  final String _baseUrl;
  final String _api;
  final String _programParams;

  ProgramsList(this._baseUrl, this._api, this._programParams);

  @override
  _ProgramsListState createState() => _ProgramsListState();
}

class _ProgramsListState extends State<ProgramsList> {
  List programs = new List();
  final Dio dio = new Dio();

  void _loadData() async {
    final response =
        await dio.get('${widget._api}?program=${widget._programParams}');
    List tempList = new List();
    response.data['data'].forEach((el) => tempList.add(el));
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
        if (programName != '') {
          return new Card(
            margin: EdgeInsets.only(
              top: 8.0,
              right: 5.0,
              left: 5.0,
              bottom: 8.0,
            ),
            elevation: 4.0,
            child: ListTile(
              leading: RewardOriginLogo(logoUrl),
              title: Text(
                title,
                style: Styles.textListItemTitle,
              ),
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                String api = '${widget._api}/$programName';
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
          return SizedBox.shrink();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = LoadingText('Loading programs...', Icons.landscape);
    if (programs.isNotEmpty) child = _buildList();
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0),
      child: child,
      color: Styles.colorDefault,
    );
  }
}
