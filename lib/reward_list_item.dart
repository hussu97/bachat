import 'package:flutter/material.dart';

import 'package:demo_project_2/reward_details.dart';
import './styles.dart';

class RewardListItem extends StatelessWidget {
  final List<Map<String,Object>> rewards = [
    {'url': 'https://picsum.photos/250?image=9','title': 'Mcdonald\'s','distance': '1.2km','offer': 'Buy 1 get 1 free'}
  ];
  final String url = 'https://picsum.photos/250?image=9';
  final String title = 'McDonald\'s';
  final String subtitle = '1.2km';
  final String offer = 'Buy 1 get 1 free';
  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Center(
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RewardDetails(rewards[0]['title']),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image:
                              NetworkImage(rewards[0]['url']),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 150.0,
                      child: Align(
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 5.0, left: 10.0),
                              child: Text(
                                rewards[0]['title'],
                                style: Styles.textCardTitle,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 5.0, right: 10.0),
                              child: Text(
                                rewards[0]['distance'],
                                style: Styles.textCardSubtitle,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    rewards[0]['offer'],
                    style: Styles.textCardOffer,
                  ),
                ),
              ],
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
      ),
      padding: EdgeInsets.all(5.0),
    );
  }
}
