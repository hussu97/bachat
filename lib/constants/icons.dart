import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class IconConstants {
  static Map<String, List<dynamic>> cityIcons = {
    'Abu Dhabi': [MdiIcons.homeCityOutline, Colors.red],
    'Dubai': [MdiIcons.homeCityOutline, Colors.blue],
    'Sharjah': [MdiIcons.homeCityOutline, Colors.brown],
    'Ajman': [MdiIcons.homeCityOutline, Colors.green],
    'Fujairah': [MdiIcons.homeCityOutline, Colors.amber],
    'Ras Al Khaimah': [MdiIcons.homeCityOutline, Colors.purple],
    'Umm Al Quwain': [MdiIcons.homeCityOutline, Colors.cyan],
  };
  static Map<String, List<dynamic>> categoryIcons = {
    'Dining': [MdiIcons.foodAppleOutline, Colors.red],
    'Food and Drinks': [MdiIcons.foodAppleOutline, Colors.red],
    'Banking': [MdiIcons.cashMultiple, Colors.brown],
    'Health': [MdiIcons.heartOutline, Colors.green],
    'Education': [MdiIcons.school, Colors.amber],
    'Retail': [MdiIcons.bagPersonalOutline, Colors.purple],
    'Services': [MdiIcons.roomServiceOutline, Colors.cyan],
    'Travel' : [MdiIcons.airplaneTakeoff, Colors.black],
    'Entertainment' : [MdiIcons.cameraOutline, Colors.blue]
  };
}
