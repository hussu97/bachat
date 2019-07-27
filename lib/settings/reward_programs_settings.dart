import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../styles.dart';

class RewardsProgramsSettings extends StatefulWidget {
  final Function _apiUpdateCallback;
  final String _baseUrl;
  final String _programsApi;

  RewardsProgramsSettings(
    this._baseUrl,
    this._programsApi,
    this._apiUpdateCallback,
  );

  @override
  _RewardsProgramsSettingsState createState() =>
      _RewardsProgramsSettingsState();
}

class _RewardsProgramsSettingsState extends State<RewardsProgramsSettings> {
  List programs = new List();
  List isEnabled = new List();
  final Dio dio = new Dio();

  void _loadData() async {
    final response = await dio.get(widget._programsApi);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = new List();
    List<bool> tempList2 = new List();
    response.data['data'].forEach((el) {
      String rewardOrigin = el['reward_origin'];
      tempList.add(rewardOrigin);
      tempList2.add(prefs.getBool(rewardOrigin) ?? true);
    });
    setState(() {
      programs.addAll(tempList);
      isEnabled.addAll(tempList2);
      _updateRewardProgramsList();
    });
  }

  _updateRewardProgramsList() {
    String programParameter = '?program=';
    for (int i = 0; i < programs.length; i++) {
      if (isEnabled[i]) {
        programParameter += '${programs[i]},';
      }
    }
    programParameter = programParameter.substring(0, programParameter.length - 1);
    widget._apiUpdateCallback(programParameter);
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
        return new Card(
          margin: EdgeInsets.only(top: 14.0, right: 5.0, left: 5.0),
          elevation: 4.0,
          child: CheckboxListTile(
            activeColor: Styles.colorTertiary,
            title: Text(
              programs[index],
              style: Styles.textListItemTitle,
            ),
            value: isEnabled[index],
            onChanged: (v) async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setBool(programs[index], v);
                isEnabled[index] = v;
                _updateRewardProgramsList();
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5.0, right: 5.0, top: 10.0, bottom: 12.0),
      child: _buildList(),
      color: Styles.colorDefault,
    );
  }
}
