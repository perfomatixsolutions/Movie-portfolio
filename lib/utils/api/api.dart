import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:movie_mock_list/model/MovieDetailsModel.dart';
import 'package:movie_mock_list/model/movieModel.dart';
import 'package:http/http.dart' as http;


class Api {


  Future<MovieModel> fetchPopularList(String data) async {
    try {
      final uri = 'http://www.omdbapi.com/?s=galaxy&page=1&apikey=aedc0d06';
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

  Future<MovieModel> fetchPaginatedPopularList(String index,String e) async {

    final uri = 'http://www.omdbapi.com/?s=galaxy&page=1&apikey=aedc0d06';
    var  url = uri.replaceAll('s=galaxy&page=1', 's=$e&page=$index');
    var response = await http.get(url);
    debugPrint("Responsee :$response");
    MovieModel movieAdded = MovieModel();
    var movie = json.decode(response.body);
    debugPrint("Responsee :$movie");

    movieAdded = MovieModel.fromJson(movie);


    return movieAdded;
  }

  Future<MovieDetailsModel> fetchMovieDetails(String e) async {

    final uri = 'http://www.omdbapi.com/?t=hitman&apikey=aedc0d06';
    var  url = uri.replaceAll('t=hitman','t=$e');
    var response = await http.get(url);
    MovieDetailsModel movieAdded = MovieDetailsModel();
    var movie = json.decode(response.body);
    debugPrint("Response :$movie");

    movieAdded = MovieDetailsModel.fromJson(movie);

    debugPrint("Response :${movieAdded.id}");
    return movieAdded;
  }


}