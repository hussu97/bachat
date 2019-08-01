import 'package:bachat/constants/program_params.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../styles.dart';
import '../Http_provider.dart';

class RewardsProgramsSettings extends StatefulWidget {
  final Function _apiUpdateCallback;
  final String _programsApi;

  RewardsProgramsSettings(
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
  final HttpProvider http = HttpProvider.http;
  final CancelToken token = new CancelToken();

  void _loadData() async {
    print('heyoo');
    final response = await http.get(
      api: widget._programsApi,
      token: token,
    );
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tempList = new List();
    List<bool> tempList2 = new List();
    response.data['data'].forEach((el) {
      String rewardOrigin = el['reward_origin'];
      tempList.add(rewardOrigin);
      tempList2.add(prefs.getBool(rewardOrigin) ?? true);
    });
    print('size of tempList ${tempList.length}');
    setState(() {
      programs.addAll(tempList);
      isEnabled.addAll(tempList2);
      _updateRewardProgramsList();
    });
  }

  _updateRewardProgramsList() {
    String programParameter = '';
    for (int i = 0; i < programs.length; i++) {
      if (isEnabled[i]) {
        programParameter += '${programs[i]},';
      }
    }

    setState(() {
      programParameter =
          programParameter.substring(0, programParameter.length - 1);
      programParameters.p = programParameter;
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
