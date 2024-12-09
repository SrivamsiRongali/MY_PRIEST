import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'pojoclass.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();
  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();
  Future<Database> _initDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'IPSDataBase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE userData(userId INTEGER,
  userToken STRING,
  firstName STRING,
  lastName STRING,
  emailId STRING,
  mobileNumber STRING,
  city STRING,
  state STRING,
  callPreference STRING,
  notificationPreference STRING,
  languagePreference STRING,
  philosophyType STRING,
  address STRING,
  locationCoordinates STRING,
  lastScreen STRING)''');
    print('table created');
    await db.execute('''
CREATE TABLE bookingsData( templeId INTEGER,
  priestId INTEGER,
  serviceId INTEGER,
  serviceDate DATETIME,
  serviceTime DATETIME,
  bookingId INTEGER,
  serviceNotes STRING,
  promoCode STRING)
''');
    await db.execute('''
CREATE TABLE filterData( templeType STRING,
  templeDistanceMin INTEGER,
  templeDistanceMax INTEGER,
  priestType STRING,
  priestSortby STRING,
  priestDistanceMin INTEGER,
  priestDistanceMax INTEGER,
  priestBudgetMin DOUBLE,
  priestBudgetMax DOUBLE,
  priestRatingMin INTEGER,
  priestRatingMax INTEGER,
  templeRatingMin INTEGER,
  templeRatingMax INTEGER,
  templeSortby STRING,)
''');
  }

  // Future<List<Map<String, Object?>>> remove(int roleid) async {
  //   Database db = await instance.database;
  //   print('userdeleted');
  //   return await db.rawQuery(
  //       'DELETE splashVisibility,userid,appToken,userFirstName,userMiddleName,userLastName,userEmailAddress,userMobileNumber,userAddressInfo,userFinstroRegistered,userFinstroInfo,userFinstroAvailableCredit,profileImage,gender,rolename,Addressline1,Addressline2,Town_City,Zip_postalcode,State FROM bookingData WHERE roleid=$roleid');
  // }

  Future<List<Map<String, Object?>>> getuserdata() async {
    Database db = await instance.database;
    var results = await db.query('userData', orderBy: 'userid');
    print('$results');
    return results;
  }

  Future<int> adduserdata(UserData userData) async {
    Database db = await instance.database;
    var results = await db.insert(
      'userData',
      userData.toMap(),
    );
    print("added userdata=$results");
    return results;
  }

  Future<int> removeuserdata() async {
    Database db = await instance.database;
    print('userdeleted');
    return await db.delete('userData');
  }

  Future<int> updateusedata(UserData userData) async {
    Database db = await instance.database;
    var results =
        await db.update('userData', userData.toMap(), where: 'roleid=1');
    return results;
  }

  Future<List<Map>> getbookingsdata() async {
    Database db = await instance.database;
    List<Map> results = await db.query('bookingsData', orderBy: 'bookingId');
    // results.forEach((row) => print(row));
    // print("bookings data $results.");
    return results;
  }

  // Future<List<Map>> getSearchdata(String search) async {
  //   Database db = await instance.database;
  //   String searchstring = "";
  //   List<String> search1 = search.split(' ');
  //   String search_where_clause = '';
  //   search1.forEach((string) {
  //     List<String> stringLetters = string.split("");
  //     stringLetters.forEach((stringLetter) {
  //       searchstring += "%$stringLetter";
  //     });
  //     searchstring += "%";
  //   });
  //   search_where_clause += "LOWER(title) LIKE LOWER('$searchstring')";
  //   // print("search_where_clause = $search_where_clause");
  //   // print("SELECT id,title FROM bookingData WHERE $search_where_clause");
  //   List<Map> results = await db.rawQuery(
  //       '''SELECT id,title FROM bookingData WHERE $search_where_clause''');
  //   results.forEach((row) => print(row));
  //   return results;
  // }

  // Future<List<Map>> selectedSearchdata(int search) async {
  //   Database db = await instance.database;
  //   List<Map> results = await db.rawQuery(
  //       'SELECT id,title,image,price FROM bookingData WHERE id= $search ');
  //   results.forEach((row) => print(row));
  //   // print("bookings data $results.");
  //   return results;
  // }

  Future<int> addbookingsData(BookingData bookingData) async {
    Database db = await instance.database;
    return await db.insert('bookingsData', bookingData.toMap());
  }

  Future<int> removebookingsData() async {
    Database db = await instance.database;
    print('bookings deleted');
    return await db.delete(
      'bookingsData',
    );
  }

  Future<int> updatebookingsData(BookingData bookingData) async {
    Database db = await instance.database;
    return await db.update('bookingsData', bookingData.toMap(), where: 'id');
  }

  Future<List<Map<String, Object?>>> getfilterdata() async {
    Database db = await instance.database;
    var results = await db.query('filterData', orderBy: 'id');
    return results;
  }

  Future<int> addfilterdata(FilterData filterData) async {
    Database db = await instance.database;
    return await db.insert('filterData', filterData.toMap());
  }

  Future<int> removefilterdata() async {
    Database db = await instance.database;
    print('filter deleted');
    return await db.delete(
      'filterData',
    );
  }
}
