import 'package:bachat/models/reward.dart';
import 'package:bachat/reward_list_item.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RewardsList extends StatefulWidget {
  final String api;
  final String baseUrl;
  RewardsList(this.baseUrl, this.api);

  @override
  _RewardsListState createState() => _RewardsListState();
}

class _RewardsListState extends State<RewardsList> {
  ScrollController _scrollController = new ScrollController();
  String moreDataUrl;
  bool isLoading = false;
  List rewards = new List();
  final Dio dio = new Dio();

  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    final response = await dio.get(moreDataUrl);
    List tempList = new List();
    moreDataUrl = response.data['next'];
    for (int i = 0; i < response.data['data'].length; i++) {
      tempList.add(response.data['data'][i]);
    }

    setState(() {
      isLoading = false;
      rewards.addAll(tempList);
    });
  }

  @override
  void initState() {
    dio.options.baseUrl = widget.baseUrl;
    moreDataUrl = widget.api;
    print(moreDataUrl);
    this._getMoreData();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      //+1 for progressbar
      itemCount: rewards.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == rewards.length) {
          return _buildProgressIndicator();
        } else {
          return new RewardListItem(Reward.fromJson(rewards[index]));
        }
      },
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildList(),
    );
  }
}
