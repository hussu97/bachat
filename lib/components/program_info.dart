import 'package:bachat/components/text_line_limiter.dart';
import 'package:bachat/models/program.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styles.dart';

class ProgramInfo extends StatelessWidget {
  final RewardsProgram _program;
  final String _programLogoUrl;
  final String _programName;
  final double _height = 100.0;

  ProgramInfo(
    this._programName,
    this._program,
    this._programLogoUrl,
  );

  Widget _buildProgramLogo(BuildContext context, String _imageUrl) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        width: (MediaQuery.of(context).size.width / 1.5),
        height: _height,
        child: GestureDetector(
          onTap: () async{
            if (await canLaunch(_program.webLink))
              await launch(_program.webLink);
          },
          child: Image.network(
            _imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildStoreLinksRow(context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width / 2.5),
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunch(_program.appStoreLink))
                    await launch(_program.appStoreLink);
                },
                child: Image.asset(
                  'assets/images/appstorebadge.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width / 2.5),
            child: Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunch(_program.playStoreLink))
                    await launch(_program.playStoreLink);
                },
                child: Image.asset(
                  'assets/images/playstorebadge.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              _buildProgramLogo(context, _programLogoUrl),
              (_program.appStoreLink != null && _program.appStoreLink != '')
                  ? _buildStoreLinksRow(context)
                  : SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: (_program.description != null)
                    ? TextLinesLimiter(
                        _program.description, Styles.textProgramInfo, 5)
                    : SizedBox.shrink(),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 4.0,
        ),
      ),
      padding: EdgeInsets.only(
        top: 15.0,
        left: 5.0,
        right: 5.0,
        bottom: 20.0,
      ),
    );
  }
}
