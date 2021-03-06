import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:movie_mock_list/const/constants.dart';
import 'package:movie_mock_list/model/movieDetailsModel.dart';
import 'package:movie_mock_list/model/movieModel.dart';
import 'package:http/http.dart' as http;


class Api {


  /// fun to  populate  movie List
  Future<MovieModel> fetchPopularList(String data) async {
    try {
      final uri = MOVIE_LIST_API;
      final url = uri.replaceAll('galaxy', data);
      var response = await http.get(url);

      MovieModel movieAdded = MovieModel();
      var movie = json.decode(response.body);
      debugPrint("Response :$movie");

      movieAdded = MovieModel.fromJson(movie);
      if(movieAdded.response == 'True')
        {
          return movieAdded;
        }


    }
    catch(Exception ){
    debugPrint("error from api :$Exception");

    }
  }

  /// fun to  populate paginated list of  movieList
  Future<MovieModel> fetchPaginatedPopularList(String index,String e) async {

    try {
      final uri = MOVIE_LIST_API;
      var url = uri.replaceAll('s=galaxy&page=1', 's=$e&page=$index');
      var response = await http.get(url);
      MovieModel movieAdded = MovieModel();
      var movie = json.decode(response.body);
      debugPrint("Response :$movie");
      movieAdded = MovieModel.fromJson(movie);
      return movieAdded;
    }

    catch(Exception ){
      debugPrint("error from api :$Exception");

    }

  }

  /// fun to fetch  movie details
  Future<MovieDetailsModel> fetchMovieDetails(String e) async {

    try {
      final uri = MOVIE_DETAILS_API;
      var url = uri.replaceAll('t=hitman', 't=$e');
      var response = await http.get(url);
      MovieDetailsModel movieAdded = MovieDetailsModel();
      var movie = json.decode(response.body);
      debugPrint("Response :$movie");

      movieAdded = MovieDetailsModel.fromJson(movie);

      debugPrint("Response :${movieAdded.id}");
      return movieAdded;
    }
    catch(Exception ){
      debugPrint("error from api :$Exception");

    }

  }


}