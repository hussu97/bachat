import 'package:bachat/settings/reward_programs_settings.dart';
import 'package:bachat/styles.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final Function _apiUpdateCallback;
  final String _baseUrl;
  final String _programsApi;

  Settings(
    this._baseUrl,
    this._programsApi,
    this._apiUpdateCallback,
  );

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<String> settingsOptions = ['Rewards Programs'];

  Widget _buildList() {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Padding(
            padding: EdgeInsets.only(left: 10.0, top: 5.0),
            child: Text(
              settingsOptions[0],
              style: Styles.textSettingsListItemTitle,
            ),
          ),
          leading: Icon(
            Icons.lightbulb_outline,
            color: Styles.colorDefaultInverse,
          ),
          onTap: () {
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
                      settingsOptions[0],
                      style: Styles.textScreenTitle,
                    ),
                  ),
                  body: RewardsProgramsSettings(
                    widget._baseUrl,
                    widget._programsApi,
                    widget._apiUpdateCallback,
                  ),
                ),
              ),
            );
          },
        ),
        Divider(
          height: 2.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: _buildList(),
      color: Styles.colorDefault,
    );
  }
}
