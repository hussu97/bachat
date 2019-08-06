// import 'dart:async';
// import 'dart:io';

// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// import './models/reward.dart';
// import './models/location.dart';
// // import './models/reward_and_location.dart';
// import './models/program.dart';

// class DBProvider {
//   DBProvider._();

//   static final DBProvider db = DBProvider._();

//   Database _database;

//   Future<Database> get database async {
//     if (_database != null) return _database;
//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     print('heyoo');
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "reward.db");
//     return await openDatabase(path, version: 1, onOpen: (db) {},
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE IF NOT EXISTS rewards ("
//           "reward_origin	text NOT NULL,"
//           "reward_origin_logo	text NOT NULL,"
//           "background_image	text NOT NULL,"
//           "logo	text,"
//           "offer	text NOT NULL,"
//           "offer_description	text,"
//           "offer_type	text,"
//           "company_name	text NOT NULL,"
//           "cost	text,"
//           "terms_and_conditions	text,"
//           "expiry_date	text,"
//           "link	text,"
//           "contact	TEXT,"
//           "rating	TEXT,"
//           "cuisine	TEXT,"
//           "working_hours	TEXT,"
//           "website	TEXT,"
//           "slug	TEXT NOT NULL,"
//           "id	TEXT NOT NULL"
//           ")");
//       await db.execute("CREATE TABLE IF NOT EXISTS locations ("
//           "id	TEXT NOT NULL UNIQUE,"
//           "formatted_address	TEXT NOT NULL,"
//           "address	TEXT NOT NULL,"
//           "lon	REAL NOT NULL,"
//           "lat	REAL NOT NULL,"
//           "city	TEXT NOT NULL,"
//           "place_id	TEXT NOT NULL"
//           ")");
//       await db.execute("CREATE TABLE IF NOT EXISTS rewards_and_locations ("
//           "location_id	TEXT NOT NULL,"
//           "reward_id	TEXT NOT NULL,"
//           "PRIMARY KEY('reward_id','location_id')"
//           ")");
//       await db.execute("CREATE TABLE IF NOT EXISTS reward_origins ("
//           "name TEXT NOT NULL,"
//           "description TEXT NOT NULL,"
//           "reward_origin_link TEXT,"
//           "app_store_link TEXT,"
//           "play_store_link TEXT"
//           ")");
//     });
//   }

//   addAllRewards(List<dynamic> rewards) async {
//     await deleteAllRewards();
//     final db = await database;
//     Batch batch = db.batch();
//     await Future.forEach(rewards, (r) async => await db.insert('rewards', r));
//     // for (var i = 0; i <= rewards.length ~/ 1000; i++) {
//     //   for (var j = 0; j < 1000; j++) {
//     //     try {
//     //       batch.insert('rewards', rewards[i * 1000 + j]);
//     //     } catch (e) {
//     //       print(e);
//     //       break;
//     //     }
//     //   }
//     //   await batch
//     //       .commit(noResult: true)
//     //       .catchError((onError) => print(onError));
//     // }
//     // rewards.forEach((r) => batch.insert('rewards', r));
//     // await batch.commit(noResult: true).catchError((onError) => print(onError));
//     print('hey');
//   }

//   addAllLocations(List<dynamic> locations) async {
//     await deleteAllLocations();
//     final db = await database;
//     Batch batch = db.batch();
//     locations.forEach((location) => batch.insert('locations', location));
//     await batch.commit(noResult: true).catchError((onError) => print(onError));
//   }

//   addAllRewardsAndLocations(List<dynamic> rewardsAndLocations) async {
//     await deleteAllRewards();
//     final db = await database;
//     Batch batch = db.batch();
//     rewardsAndLocations.forEach((rewardAndLocation) =>
//         batch.insert('rewards_and_locations', rewardAndLocation));
//     await batch
//         .commit(noResult: true, continueOnError: true)
//         .catchError((onError) => print(onError));
//   }

//   addAllRewardOrigins(List<dynamic> rewardOrigins) async {
//     await deleteAllRewards();
//     final db = await database;
//     Batch batch = db.batch();
//     rewardOrigins.forEach(
//         (rewardOrigin) => batch.insert('reward_origins', rewardOrigin));
//     await batch.commit(noResult: true).catchError((onError) => print(onError));
//   }

//   Future<List<Reward>> getRewards(List<String> rewardOrigins) async {
//     final db = await database;
//     List<Map<String, dynamic>> res = await db.query('rewards');
//     List<Reward> res2 =
//         res.isNotEmpty ? res.map((r) => Reward.fromJson(r)).toList() : [];
//     Future.forEach(res2, (r) async {
//       r.locations = await getLocations(r.id);
//     });
//     return res2;
//   }

//   Future<List<Location>> getLocations(String rewardId) async {
//     final db = await database;
//     List<Map<String, dynamic>> res = await db.rawQuery(
//         "SELECT * FROM locations,rewards_and_locations WHERE locations.id=rewards_and_locations.location_id AND reward_id=$rewardId");
//     return res.isNotEmpty ? res.map((l) => Location.fromJson(l)).toList() : [];
//   }

//   deleteAllRewards() async {
//     final db = await database;
//     await db.rawDelete("Delete from rewards");
//   }

//   deleteAllLocations() async {
//     final db = await database;
//     await db.rawDelete("Delete from locations");
//   }

//   deleteAllRewardsAndLocations() async {
//     final db = await database;
//     await db.rawDelete("Delete from rewards_and_locations");
//   }

//   deleteAllRewardOrigins() async {
//     final db = await database;
//     await db.rawDelete("Delete from reward_origins");
//   }
// }
