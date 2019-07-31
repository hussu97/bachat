import 'package:bachat/Http_provider.dart';
import 'package:bachat/styles.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './models/reward.dart';
import './components/reward_list_item/reward_list_item.dart';

class RewardsList extends StatefulWidget {
  final String api;
  final String baseUrl;
  String programParams;
  final ScrollController scrollController;
  final Function addRewardsCount;
  RewardsList({
    this.baseUrl,
    this.api,
    this.programParams,
    this.addRewardsCount,
    this.scrollController,
  });

  @override
  _RewardsListState createState() => _RewardsListState();
}

class _RewardsListState extends State<RewardsList> {
  ScrollController _scrollController = new ScrollController();
  String moreDataUrl;
  bool isLoading = false;
  List rewards = new List();
  final HttpProvider http = HttpProvider.http;
  final CancelToken token = new CancelToken();

  void _getMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }
    final response = await http
        .get(
      api: moreDataUrl,
      token: token,
    )
        .catchError((e) {
      setState(() {
        moreDataUrl = '';
      });
    });
    List tempList = new List();
    try {
      moreDataUrl = response.data['next'];
      response.data['data'].forEach((el) => tempList.add(el));
      setState(() {
        isLoading = false;
        rewards.addAll(tempList);
        if (widget.addRewardsCount != null)
          widget.addRewardsCount(response.data['count']);
      });
    } catch (e) {}
  }

  @override
  void initState() {
    moreDataUrl = '${widget.api}?program=${widget.programParams}';
    this._getMoreData();
    super.initState();
    if (widget.scrollController == null) {
      _scrollController.addListener(
        () {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            _getMoreData();
          }
        },
      );
    } else {
      widget.scrollController.addListener(
        () {
          if (widget.scrollController.position.pixels ==
              widget.scrollController.position.maxScrollExtent) {
            _getMoreData();
          }
        },
      );
    }
  }

  @override
  void dispose() {
    if (_scrollController != null) _scrollController.dispose();
    http.cancel(token);
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(20.0),
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
        if (index == rewards.length && moreDataUrl == '') {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'How you doin? 😏',
              style: Styles.textDetailsPageInfo,
              textAlign: TextAlign.center,
            ),
          );
        }
        if (index == rewards.length) {
          return _buildProgressIndicator();
        } else {
          return new RewardListItem(Reward.fromJson(rewards[index]));
        }
      },
      controller: _scrollController,
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}
