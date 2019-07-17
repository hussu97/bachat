import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './rewards_search.dart';
import './rewards_list.dart';
import './programs_list.dart';
import './categories_list.dart';
import './styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Search App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String baseUrl = 'http://192.168.1.106:5002';
  final String rewardsApi = '/rewards';
  final String programsApi = '/rewards/programs';
  final String companyNamesApi = '/rewards/companies';
  final String categoriesApi = '/rewards/categories';
  final Dio dio = new Dio();
  final List<String> tabs = [
    'All',
    'Rewards Program',
    'Location',
    'Category',
    'Other'
  ];
  final List<String> companyNames = [];

  List<Widget> _buildTabList() {
    List<Widget> res = new List<Widget>();
    for (var tab in tabs) {
      res.add(
        Tab(
          child: Text(
            tab,
            style: Styles.textTabBar,
          ),
        ),
      );
    }
    return res;
  }

  void addAllRewardsCount(int count) {
    setState(() {
      tabs[0] = 'All ($count)';
    });
  }

  void _loadSearchData() async {
    dio.options.baseUrl = baseUrl;
    final response = await dio.get(companyNamesApi);
    for (int i = 0; i < response.data['data'].length; i++) {
      companyNames.add(response.data['data'][i]);
    }
  }

  @override
  void initState() {
    this._loadSearchData();
    super.initState();
  }

  void _showSearchResultsScreen(String result) {
    String apiLink = '$companyNamesApi?company=$result';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('Search Results'),
          ),
          body: RewardsList(
            baseUrl: baseUrl,
            api: apiLink,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            unselectedLabelColor: Colors.white.withOpacity(0.3),
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: _buildTabList(),
          ),
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Future<String> result = showSearch(
                  context: context,
                  delegate: DataSearch(companyNames),
                );
                result.then((res) {
                  _showSearchResultsScreen(res);
                });
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            RewardsList(
              baseUrl: baseUrl,
              api: rewardsApi,
              addRewardsCount: addAllRewardsCount,
            ),
            ProgramsList(
              baseUrl,
              programsApi,
            ),
            Icon(Icons.access_alarms),
            CategoriesList(
              baseUrl,
              categoriesApi,
            ),
            Icon(Icons.access_alarms),
          ],
        ),
      ),
    );
  }
}
