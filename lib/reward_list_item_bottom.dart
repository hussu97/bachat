import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import './styles.dart';

class RewardListItemBottom extends StatelessWidget {
  final String offer;
  final String logoUrl;
  final String rewardOriginLogoUrl;
  RewardListItemBottom(this.offer, this.logoUrl, this.rewardOriginLogoUrl);

  Widget _buildLogoWidget() {
    if (logoUrl != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(
          logoUrl,
        ),
        backgroundColor: Colors.white,
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildRewardOriginWidget(context) {
    if (logoUrl != null) {
      return Padding(child: ConstrainedBox(
        child: Image.network(
          rewardOriginLogoUrl,
          fit: BoxFit.fitWidth,
        ),
        constraints: BoxConstraints(
          maxHeight: (MediaQuery.of(context).size.height),
          maxWidth: 20.0,
          minHeight: (MediaQuery.of(context).size.height),
          minWidth: 20.0,
        ),
      ),
      padding: EdgeInsets.only(top: 2.0,bottom: 2.0),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: ListTile(
        leading: _buildLogoWidget(),
        title: AutoSizeText(
          offer,
          style: Styles.textCardOffer,
          maxLines: 1,
          minFontSize: 18.0,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: _buildRewardOriginWidget(context),
      ),
    );
  }
}
