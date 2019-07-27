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
  static String base = 'http://development.2shkuzu3ua.us-east-1.elasticbeanstalk.com';
  static String latestApiUrl = '/api/v1';
  final String baseUrl = '$base$latestApiUrl';
  final String rewardsEndpoint = '/rewards';
  final String programsEndpoint = '/programs';
  final String companyNamesEndpoint = '/companies';
  final String categoriesEndpoint = '/categories';
  final String citiesEndpoint = '/cities';
  final String locationsEndpoint = '/locations';
  String programParams = '';
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
    return res;
  }

  void addAllRewardsCount(int count) {
    setState(() {
      tabs[0] = 'All ($count)';
    });
  }

  void updateProgramParams(String programParam) {
    setState(() {
      this.programParams = programParam;
      this.initState();
    });
  }

  Future _loadProgramFilterData() async {
    programParams = '';
    final response = await dio.get(programsEndpoint);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    response.data['data'].forEach((el) {
      if (prefs.getBool(el['reward_origin']) ?? true) {
        programParams += el['reward_origin'];
        programParams += ',';
      }
    });
    programParams = programParams.substring(0, programParams.length - 1);
  }

  Future _loadSearchData() async {
    await this._loadProgramFilterData();
    companyNames.clear();
    final response =
        await dio.get('$companyNamesEndpoint?program=$programParams');
    response.data['data'].forEach((el) => companyNames.add(el));
  }

  @override
  void initState() {
    dio.options.baseUrl = baseUrl;
    this._loadSearchData().then((v) => super.initState());
  }

  void _showSearchResultsScreen(String result) {
    String apiLink = '$companyNamesEndpoint/$result';
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
            api: apiLink,
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
                  delegate: DataSearch(companyNames),
                );
                result.then((res) {
                  if (res != null) _showSearchResultsScreen(res);
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
            RewardsList(
              baseUrl: baseUrl,
              api: rewardsEndpoint,
              programParams: programParams,
              addRewardsCount: addAllRewardsCount,
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
