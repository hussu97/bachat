import 'package:flutter/material.dart';

class RewardDetails extends StatelessWidget {
  final String title;

  RewardDetails(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
        ),
    );
  }
}