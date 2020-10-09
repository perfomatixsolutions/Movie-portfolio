import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:movie_mock_list/model/MovieDetailsModel.dart';
import 'package:movie_mock_list/model/ProfileDetailsModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper ,
  // DatabaseHelper will be initialized only once throughout the application

  DatabaseHelper._createInstance(); // named constructor to create instance of Database helper

  static Database _database; //Singleton Database

  String movieDetails = 'movie_details';

  String profileDetails = 'profile_details';

  String id = 'id';

  String Title = 'Title';

  String plot = 'plot';

  String year = 'year';

  String poster = 'poster';

  String watched = 'watched';

  String category = 'category';

  String imgPath  = 'imgpath';


  /// fun to initialize the  Database Constructor

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  ///  fun getter for database in flutter

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  /// Initialize Database

  Future<Database> initializeDatabase() async {
    //get the directory path for android and ios to store  database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'movies3.db';

    //open/create the database at a given path
    var noteDatabase =
    await openDatabase(path, version: 6, onCreate: _createDb);
    return noteDatabase;
  }

  /// create Database

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $profileDetails($imgPath TEXT)');
    await db.execute(
        'CREATE TABLE $movieDetails($id INTEGER PRIMARY KEY AUTOINCREMENT,$Title TEXT,$plot TEXT,$poster TEXT ,$year TEXT,$watched INTEGER DEFAULT 0,$category TEXT DEFAULT shows)');
  }

  /// CRUD Operation

  /// Fetch operation : Get all movieDetails  objects from Database according to category(movies)

  Future<List<Map<String, dynamic>>> getMovieMapList(String name) async {
    Database db = await this.database;
    if(name.isNotEmpty) {
      var result = await db.rawQuery(
          'SELECT *  from $movieDetails where $category = "$name"');
      return result;
    }
    else
      {
        var result = await db.rawQuery(
            'SELECT *  from $movieDetails');
        return result;
      }
  }

  /// fun  to  insert  operation : Insert a Note  objects from Database

  Future<int> insertMovie(MovieDetailsModel movie,String category) async {
    Database db = await this.database;
    debugPrint("movie aa: ${movie.toMap()},:$movieDetails}");
    movie.category = category;
    var result = db.insert(movieDetails, movie.toMap());
    return result;
  }

  /// fun to update  operation : Update a movieDetails  objects from Database

  Future<int> updateNote(MovieDetailsModel movie) async {
    Database db = await this.database;
    var result = db.update(movieDetails, movie.toMap(),
        where: '$id  = ?', whereArgs: [movie.id]);
    return result;
  }

  /// fun to  delete a movieDetails  objects from Database using Id

  Future<int> deleteMovie(int id1) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE  from $movieDetails where $id =$id1');
    return result;
  }

  /// fun to  delete a movieDetails  objects from Database using Title

  Future<int> deleteMovieUsingName(String movie) async {
    Database db = await this.database;
    var result = db.rawDelete('DELETE  from $movieDetails where  $Title = "$movie"');
    return result;
  }

  /// fun to  update the watchList

  Future<int> updateWatchList(int watchlist1,String title1 ) async {
    Database db = await this.database;
    String sql = "UPDATE $movieDetails SET $watched =${watchlist1} WHERE $Title = $title1";
    var result = db.rawUpdate(sql);
    return result;
  }

  /// fun to get Number of Movie Object in Database

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
    await db.rawQuery('SELECT COUNT (*) from $movieDetails');
    var result = Sqflite.firstIntValue(x);
    return result;
  }

  /// fun to get all movie list from database

  Future<MovieDetailsModel> getDetails(String  movie) async {
    Database db = await this.database;
    //var result = await db.rawQuery('SELECT  * from $movieDetails');
    var result = await db.rawQuery('SELECT *  from $movieDetails where $Title = "$movie"');
    MovieDetailsModel movieList = MovieDetailsModel();
    debugPrint("movies list :$result");
        movieList =MovieDetailsModel.fromMapObject(result[0]);
    return movieList;
  }

  ///  fun to get the 'Map List' [List<Map>] and convert it to 'MovieDetails' [List<MovieDetails>]

  Future<List<MovieDetailsModel>> getMovieList(String category) async {
    var movieMapList = await getMovieMapList(category);

    int count = movieMapList.length;
    List<MovieDetailsModel> movieList = List<MovieDetailsModel>();

    for (int i = 0; i < count; i++) {
      debugPrint("data :${movieMapList.toList()}");
      movieList.add(MovieDetailsModel.fromMapObject(movieMapList[i]));

    }

    return movieList;
  }

  /// fun to get movie name from movieList

  Future<List<String>> getMovieName(String category) async{
    var movieMapList = await getMovieMapList(category);

    int count = movieMapList.length;
    List<String> movieList = List<String>();
    for (int i = 0; i < count; i++) {
      movieList.add(MovieDetailsModel.fromMapObject(movieMapList[i]).Title);
    }
     return movieList;
    }


    /// fun to  get ImgPath from  db

  Future<ProfileDetailsModel> getProfileImagePath() async{
    Database db = await this.database;
    var result = await db.rawQuery('SELECT *  from $profileDetails');
    var   movieList =  new ProfileDetailsModel();
    debugPrint("details :${result.toList()} ");
      movieList = ProfileDetailsModel.fromMapObject(result[0]);
    debugPrint("details :${movieList.imgPath} ");
    return movieList;
    }

  /// fun to  insert ImgPath from  db

  Future<int> insertImagePath(ProfileDetailsModel imagePath) async {
    Database db = await this.database;
    var result =  await db.rawDelete('DELETE  from $profileDetails where  $imgPath != "$imagePath"');
    var result2 =  await db.insert(profileDetails, imagePath.toMap());
    debugPrint("inserted :${result2.toString()} ");
    return result2;
  }
  }

