import 'dart:async';
import 'package:bachat/Http_provider.dart';
import 'package:bachat/constants/program_params.dart';
import 'package:flutter/material.dart';
import './home.dart';
import 'package:shared_preferences/shared_preferences.dart';

void mainDelegate() => {main()};

void main() {
  runApp(
    new MaterialApp(
      title: 'bachat',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String programParams = '';
  List<String> cachedSearches = new List();

  static String base =
      'http://development.2shkuzu3ua.us-east-1.elasticbeanstalk.com';
  // static String base = 'http://192.168.0.185:5000';
  static String latestApiUrl = '/api/v1';
  final String baseUrl = '$base$latestApiUrl';
  HttpProvider http = HttpProvider.http;

  @override
  void initState() {
    super.initState();
    http.initHttp(baseUrl);
    _loadUserData();
  }

  void _loadUserData() async {
    programParams = '';
    final response = await http.get(
      api: http.programsEndpoint,
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
      programParameters.p = programParams;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (builder) => new HomeScreen(
          programParams,
          cachedSearches,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset(
          'assets/images/loading.gif',
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
