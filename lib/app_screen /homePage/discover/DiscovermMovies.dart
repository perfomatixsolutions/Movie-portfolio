
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_mock_list/app_screen%20/homePage/moviedetails.dart';
import 'package:movie_mock_list/model/MovieDetailsModel.dart';
import 'package:movie_mock_list/model/movieModel.dart';
import 'package:movie_mock_list/utils/api/api.dart';
import 'package:movie_mock_list/utils/dbHelper.dart';



class DiscoverMovies extends StatefulWidget {
  @override
  _DiscoverMoviesState createState() => _DiscoverMoviesState();
}

class _DiscoverMoviesState extends State<DiscoverMovies> {
  List<Search> _moviePopularList = List<Search>();
  List<String> _movieNameList = List<String>();
  ScrollController controller;
  int pageNum = 1;
  bool isPageLoading = false;
  var fetchMovieList = new Api();
  int _moviePopularListIndex = 0;
  int totalRecord = 0;

  @override
  Widget build(BuildContext context) {
    final constListView = ListView.builder(
        controller: controller,
        itemCount: _moviePopularList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Visibility(
                visible: (index == _moviePopularListIndex &&
                    isPageLoading == true) ? false : true,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Dismissible(
                    background: Container(color: Colors.red,
                      child: Align(alignment: Alignment.centerRight,
                          child: Icon(Icons.remove_red_eye, color: Colors.white,
                            size: 100,)),),
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      if (direction == DismissDirection.endToStart) {
                        setState(() {
                          _moviePopularList.removeAt(index);
                        });
                        /*  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc){
                      return Container(
                        child: new Wrap(
                          children: <Widget>[
                            new ListTile(
                                leading: new Icon(Icons.keyboard_hide),
                                title: new Text('Hide',style: TextStyle(color: Colors.black),),
                                onTap: () => {
                                setState(() {
          _moviePopularList.removeAt(index);
          Navigator.pop(context);
          }),
                                }
                            ),
                            new ListTile(
                              leading: new Icon(Icons.exit_to_app),
                              title: new Text('Exit',style:TextStyle(color: Colors.black)),
                              onTap: () => {
                                setState(() {
                                  Navigator.pop(context);
                                }),
                              },
                            ),
                          ],
                        ),
                      );
                    }
                );*/

                      }
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(
                            color: Colors.black12.withOpacity(0.5),
                            blurRadius: 5.0,
                          ),
                          ]),
                      child: Stack(
                        children: [
                          GestureDetector(
                            child: Container(

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(

                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${_moviePopularList[index].poster}')
                                  )
                              ),
                            ),
                            onTap: () async
                            {
                              var result = await Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    if (_checkMovieName(
                                        _moviePopularList[index].Title)) {
                                      return MovieDetails(
                                          _moviePopularList[index].Title,
                                          false,"movies");
                                    }
                                    else {
                                      return MovieDetails(
                                          _moviePopularList[index].Title, true,"movies");
                                    }
                                  }));

                              if (result == true) {
                                _getMovieName();
                              }
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Align(
                              child: IconButton(icon: _checkMovieName(
                                  _moviePopularList[index].Title) ? Icon(
                                  Icons.check_box, size: 30) : Icon(
                                  Icons.add_box_outlined, size: 30),
                                color: Colors
                                    .yellow,
                                onPressed: () {
                                  DatabaseHelper db = new DatabaseHelper();
                                  if (_checkMovieName(
                                      _moviePopularList[index].Title)) {
                                    db.deleteMovieUsingName(
                                        _moviePopularList[index].Title);
                                    _getMovieName();
                                    print ("deleted :${_moviePopularList[index].Title}");
                                  }
                                  else  {
                                    fetchMovieList.fetchMovieDetails(_moviePopularList[index].Title)
                                        .then((value) {
                                      db.insertMovie(value,"movies");
                                      _getMovieName();
                                    });

                                    print ("inserted :${_moviePopularList[index].Title}");

                                  }

                                },),
                              alignment: Alignment.topRight,),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              child: Text(
                                _moviePopularList[index].Title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),),
                              alignment: Alignment.bottomLeft,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: (index == _moviePopularListIndex &&
                      isPageLoading == true) ? 50 : 0,
                  width: 50,
                  child: CircularProgressIndicator(
                  ),
                ),
              )
            ],
          );
        });
    return Scaffold(
        body: constListView
    );
  }


  @override
  void initState() {
    super.initState();
    _getMovieName();
    _updateList();
    controller = new ScrollController()
      ..addListener(_scrollListener);
    setState(() {});
  }

  _scrollListener() {
    if (totalRecord == _moviePopularListIndex) {
      return;
    }
    print(controller.position.extentAfter);
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      setState(() {
        isPageLoading = true;
        _updateList();
      });
    }
  }

  ///fun to check whether  movie list in watchList

  bool _checkMovieName(String movie) {
    if (_movieNameList.contains(movie)){
      return true;
    }
    else {
      return false;
    }
  }

  /// fun to get movie name

  _getMovieName() {
    DatabaseHelper db = new DatabaseHelper();
    db.getMovieName("movies").then((value) {
      setState(() {
        _movieNameList = value;
        debugPrint(" movie name :${value.toList()}");
      });
    });
  }

  ///  fun to update movie list

  _updateList() {
    fetchMovieList.fetchPaginatedPopularList(pageNum.toString(), "twilight")
        .then((value) {
      setState(() {
        if (_moviePopularList.length == 0) {
          _moviePopularList = value.search;
        }
        else {
          isPageLoading = false;
          for (var movie in value.search) {
            _moviePopularList.add(movie);
          }
        }
        _moviePopularListIndex = _moviePopularList.length - 1;
      });
    });
  }

  }

