import 'package:bachat/Http_provider.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './rewards_search.dart';
import './rewards_list.dart';
import './programs_list.dart';
import './categories_list.dart';
import './locations_tab.dart';
import './styles.dart';
import './settings/settings.dart';

// void mainDelegate() => runApp(MyApp());
void main() => runApp(MyApp());
void mainDelegate() {}

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
  static String base =
      'http://development.2shkuzu3ua.us-east-1.elasticbeanstalk.com';
  // static String base = 'http://192.168.0.185:5000';
  static String latestApiUrl = '/api/v1';
  final String baseUrl = '$base$latestApiUrl';
  final String rewardsEndpoint = '/rewards';
  final String programsEndpoint = '/programs';
  final String companyNamesEndpoint = '/companies';
  final String categoriesEndpoint = '/categories';
  final String citiesEndpoint = '/cities';
  final String locationsEndpoint = '/locations';
  final CancelToken token = new CancelToken();
  String programParams = '';
  final HttpProvider http = HttpProvider.http;
  final List<String> tabs = [
    'All',
    'Rewards Program',
    'Location',
    'Category',
  ];
  final List<String> companyNames = [];
  final Set<String> cachedSearches = new Set();

  List<Widget> _buildTabList() {
    List<Widget> res = new List<Widget>();
    tabs.forEach((tab) => res.add(Tab(child: Text(tab))));
    return res;
  }

  void addAllRewardsCount(int count) {
    setState(() {
      tabs[0] = 'All ($count)';
    });
  }

  void updateProgramParams(String programParam) {
    setState(() {
      programParams = programParam;
      this.initState();
    });
  }

  Future _loadUserData() async {
    programParams = '';
    final response = await http.get(
      api: programsEndpoint,
      token: token,
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    response.data['data'].forEach((el) {
      if (prefs.getBool(el['reward_origin']) ?? true) {
        programParams += el['reward_origin'];
        programParams += ',';
      }
    });
    cachedSearches.clear();
    cachedSearches.addAll(prefs.getStringList("search") == null
        ? []
        : prefs.getStringList("search"));
    setState(() {
      programParams = programParams.substring(0, programParams.length - 1);
    });
  }

  Future _loadSearchData() async {
    await this._loadUserData();
    companyNames.clear();
    final response = await http.get(
      api: '$companyNamesEndpoint?program=$programParams',
      token: token,
    );
    print('data size is ${response.data['data'].length}');
    response.data['data'].forEach((el) => companyNames.add(el));
  }

  @override
  void initState() {
    http.initHttp(baseUrl);
    this._loadSearchData().then((v) => super.initState());
  }

  @override
  void dispose() {
    http.cancel(token);
    super.dispose();
  }

  void _showSearchResultsScreen(String result) {
    String api = '$companyNamesEndpoint/$result';
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
              'Search Results',
              style: Styles.textScreenTitle,
            ),
          ),
          body: RewardsList(
            baseUrl: baseUrl,
            api: api,
            programParams: programParams,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarBottom() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
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
          TabBar(
            unselectedLabelColor: Styles.colorDefaultInverse.withOpacity(0.4),
            unselectedLabelStyle: Styles.textTabBar,
            indicatorColor: Styles.colorTertiary,
            labelColor: Styles.colorTertiary,
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
          backgroundColor: Styles.colorDefault,
          bottom: _buildAppBarBottom(),
          title: Text(
            widget.title,
            style: Styles.textScreenTitle,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              color: Styles.colorDefaultInverse,
              onPressed: () {
                Future<String> result = showSearch(
                  context: context,
                  delegate: DataSearch(
                    companyNames,
                    cachedSearches.toList(),
                  ),
                );
                result.then((res) {
                  if (res != null) {
                    _showSearchResultsScreen(res);
                    cachedSearches.add(res);
                    SharedPreferences.getInstance().then((prefs) {
                      prefs
                          .setStringList("search", cachedSearches.toList())
                          .catchError((onError) => print('Error $onError'));
                    });
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              color: Styles.colorDefaultInverse,
              onPressed: () {
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
                          'Settings',
                          style: Styles.textScreenTitle,
                        ),
                      ),
                      body: Settings(
                          baseUrl, programsEndpoint, updateProgramParams),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            Container(
              child: RewardsList(
                    baseUrl: baseUrl,
                    api: rewardsEndpoint,
                    programParams: programParams,
                    addRewardsCount: addAllRewardsCount,
                  ),
              color: Styles.colorDefault,
            ),
            ProgramsList(
              baseUrl,
              programsEndpoint,
              programParams,
            ),
            LocationsTab(
              baseUrl,
              citiesEndpoint,
              locationsEndpoint,
              programParams,
            ),
            CategoriesList(
              baseUrl,
              categoriesEndpoint,
              programParams,
            ),
          ],
        ),
      ),
    );
  }
}
