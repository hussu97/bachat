import 'package:bachat/components/reward_origin_logo.dart';
import 'package:bachat/models/program.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './rewards_list.dart';
import './styles.dart';
import './components/loading_text.dart';
import './components/program_info.dart';
import './Http_provider.dart';

class ProgramsList extends StatefulWidget {
  final String _baseUrl;
  final String _api;
  String _programParams;

  ProgramsList(this._baseUrl, this._api, this._programParams);

  @override
  _ProgramsListState createState() => _ProgramsListState();
}

class _ProgramsListState extends State<ProgramsList> {
  List programs = new List();
  final HttpProvider http = HttpProvider.http;
  final CancelToken token = new CancelToken();
  final ScrollController _scrollController = new ScrollController();

  void _loadData() async {
    final response =
        await http.get(api: '${widget._api}?program=${widget._programParams}',token: token);
    List tempList = new List();
    response.data['data'].forEach((el) => tempList.add(el));
    setState(() {
      programs.addAll(tempList);
    });
  }

  @override
  void initState() {
    this._loadData();
    super.initState();
  }

  @override
  void dispose() {
    if(_scrollController != null) _scrollController.dispose();
    http.cancel(token);
    super.dispose();
  }

  Widget _programListScaffold(
    String title,
    String api,
    String logoUrl,
    dynamic json,
  ) {
    return Scaffold(
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
      body: ListView(
        children: <Widget>[
          ProgramInfo(
            RewardsProgram.fromJson(json),
            logoUrl,
          ),
          RewardsList(
            baseUrl: widget._baseUrl,
            api: api,
            programParams: widget._programParams,
            scrollController: _scrollController,
          ),
          
        ],
        controller: _scrollController,
      ),
    );
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
                    builder: (context) => _programListScaffold(
                      title,
                      api,
                      logoUrl,
                      programs[index],
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
