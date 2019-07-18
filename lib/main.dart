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
      title: 'bachat',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'bachat'),
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
  // TODO add final keyword to url
  String baseUrl = 'http://192.168.1.106:5002';
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
  ];
  final List<String> companyNames = [];

  List<Widget> _buildTabList() {
    List<Widget> res = new List<Widget>();
    tabs.forEach((tab) => res.add(Tab(child: Text(tab))));
    print(res.length);
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
            iconTheme: IconThemeData(
              color: Styles.textColorDefaultInverse,
            ),
            backgroundColor: Styles.textColorDefault,
            title: Text(
              'Search Results',
              style: Styles.textScreenTitle,
            ),
          ),
          body: RewardsList(
            baseUrl: baseUrl,
            api: apiLink,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarBottom() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight+50.0),
      // TODO remove TextField widget in release
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              )),
            ),
          ),
          TextField(
            onSubmitted: (text) {
              setState(() {
                baseUrl = text;
                print(baseUrl);
              });
            },
          ),
          TabBar(
            unselectedLabelColor:
                Styles.textColorDefaultInverse.withOpacity(0.4),
            unselectedLabelStyle: Styles.textTabBar,
            indicatorColor: Styles.textColorTertiary,
            labelColor: Styles.textColorTertiary,
            labelStyle: Styles.textTabBarSelected,
            isScrollable: true,
            tabs: _buildTabList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styles.textColorDefault,
          bottom: _buildAppBarBottom(),
          title: Text(
            widget.title,
            style: Styles.textScreenTitle,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: Styles.textColorDefaultInverse,
              onPressed: () {
                Future<String> result = showSearch(
                  context: context,
                  delegate: DataSearch(companyNames),
                );
                result.then((res) {
                  if (res != null) _showSearchResultsScreen(res);
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
          ],
        ),
      ),
    );
  }
}
