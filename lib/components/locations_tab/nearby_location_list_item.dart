import 'package:bachat/models/reward.dart';
import 'package:flutter/material.dart';

import '../../styles.dart';
import '../../reward_details.dart';
import '../reward_origin_logo.dart';

class NearbyLocationListItem extends StatefulWidget {
  final double _distance;
  final Reward _reward;

  NearbyLocationListItem(this._distance, this._reward);

  @override
  _NearbyLocationListItemState createState() => _NearbyLocationListItemState();
}

class _NearbyLocationListItemState extends State<NearbyLocationListItem> {
  String _distanceFormatted;
  @override
  void initState() {
    if (widget._distance < 300.00) {
      _distanceFormatted = '< 0.3km';
    } else if (widget._distance > 100000.00) {
      _distanceFormatted = '> 100km';
    } else {
      _distanceFormatted = '${(widget._distance / 1000.0).toStringAsFixed(2)}km';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      margin: EdgeInsets.only(
        top: 8.0,
        right: 5.0,
        left: 5.0,
        bottom: 8.0,
      ),
      elevation: 4.0,
      child: ListTile(
        leading: RewardOriginLogo(widget._reward.rewardOriginLogo),
        title: Text(
          widget._reward.companyName,
          style: Styles.textListItemTitle,
        ),
        subtitle: Text(
          widget._reward.offer,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          children: <Widget>[
            Text(_distanceFormatted),
            Icon(Icons.keyboard_arrow_right),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RewardDetails(widget._reward),
            ),
          );
        },
      ),
    );
  }
}
