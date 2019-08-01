import 'package:bachat/Http_provider.dart';
import 'package:bachat/constants/program_params.dart';
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

class HomeScreen extends StatelessWidget {
  final String programParams;
  final List<String> cachedList;

  HomeScreen(this.programParams, this.cachedList);

  @override
  Widget build(BuildContext context) {
    return MyHomeScreen(
      title: 'bachat',
      programParams: programParams,
      cachedList: cachedList,
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  MyHomeScreen({
    Key key,
    this.title,
    this.programParams,
    this.cachedList,
  }) : super(key: key);
  final String title;
  final String programParams;
  final List<String> cachedList;
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final String rewardsEndpoint = '/rewards';
  final String programsEndpoint = '/programs';
  final String companyNamesEndpoint = '/companies';
  final String categoriesEndpoint = '/categories';
  final String citiesEndpoint = '/cities';
  final String locationsEndpoint = '/locations';
  final CancelToken token = new CancelToken();
  
  final HttpProvider http = HttpProvider.http;
  final List<String> tabs = [
    'All',
    'Rewards Program',
    'Location',
    'Category',
  ];
  final List<String> companyNames = [];
  Set<String> cachedSearches;
  String programParams;

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
      programParameters.p = programParam;
      this.initState();
    });
  }

  Future _loadSearchData() async {
    // await this._loadUserData();
    companyNames.clear();
    final response = await http.get(
      api: '$companyNamesEndpoint?program=${programParameters.p}',
      token: token,
    );
    response.data['data'].forEach((el) => companyNames.add(el));
  }

  @override
  void initState() {
    setState(() {
      programParams = widget.programParams;
      cachedSearches = widget.cachedList.toSet();
    });
    this._loadSearchData();
    super.initState();
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
            api: api,
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
                    setState(() {
                      cachedSearches.add(res);
                    });
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
                        programsEndpoint,
                        updateProgramParams,
                      ),
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
                api: rewardsEndpoint,
                addRewardsCount: addAllRewardsCount,
              ),
              color: Styles.colorDefault,
            ),
            ProgramsList(
              programsEndpoint,
            ),
            LocationsTab(
              citiesEndpoint,
              locationsEndpoint,
            ),
            CategoriesList(
              categoriesEndpoint,
            ),
          ],
        ),
      ),
    );
  }
}
