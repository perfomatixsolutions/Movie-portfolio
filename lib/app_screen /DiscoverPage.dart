import 'package:flutter/material.dart';
import 'package:movie_mock_list/app_screen%20/discoverMorePage.dart';
import 'package:movie_mock_list/model/movieModel.dart';
import 'package:movie_mock_list/utils/Utils.dart';
import 'package:movie_mock_list/utils/api/api.dart';
import 'package:movie_mock_list/utils/dbHelper.dart';

import 'homePage/moviedetails.dart';
import 'homePage/search/SearchPage.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  MovieModel _trendingMovieList = MovieModel();
  MovieModel _trendingShowPopularList = MovieModel();
  var _trendingMovieListApi = new Api();
  var _trendingShowListApi = new Api();
  int _moviePopularListIndex = 0;
  int _trendingShowListIndex = 0;

  List<AssetImage> _images = [
    AssetImage('assets/facebook_logo.png'),
    AssetImage('assets/twitter_logo.png'),
    AssetImage('assets/contact.png')
  ];
  List<String> _recentActivityData = [
    'Find Facebook Friends',
    'Find Twitter friends',
    'Find contacts'
  ];
  List<String> _movieNameList = List<String>();

  @override
  void initState() {
    super.initState();
    _getMovieName();
    _updateMoveList();
    _updateShowList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10, left: 10, right: 10),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey.shade700,
                            size: 17,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () async {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => SearchPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var begin = Offset(1.5, 0.0);
                          var end = Offset.zero;
                          var tween = Tween(begin: begin, end: end);
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        }));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 0.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending  Movies',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiscoverMore(1)));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(color: Colors.indigo),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _moviePopularListIndex,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 120,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '${_trendingMovieList.search[index].poster}'))),
                                    ),
                                    onTap: () async {
                                      var result = await Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        if (_checkMovieName(_trendingMovieList
                                            .search[index].Title)) {
                                          return MovieDetails(
                                              _trendingMovieList
                                                  .search[index].Title,
                                              false,"movies");
                                        } else {
                                          return MovieDetails(
                                              _trendingMovieList
                                                  .search[index].Title,
                                              true,"movies");
                                        }
                                      }));
                                      if (result == true) {
                                        _getMovieName();
                                      }
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      child: IconButton(
                                          icon: _checkMovieName(
                                                  _trendingMovieList
                                                      .search[index].Title)
                                              ? Icon(Icons.check_box, size: 30)
                                              : Icon(Icons.add_box_outlined,
                                                  size: 30),
                                          color: Colors.yellow,
                                          onPressed: () {
                                            DatabaseHelper db =
                                                new DatabaseHelper();
                                            if (_checkMovieName(
                                                _trendingMovieList
                                                    .search[index].Title)) {
                                              db.deleteMovieUsingName(
                                                  _trendingMovieList
                                                      .search[index].Title);
                                              _getMovieName();
                                              print(
                                                  "deleted :${_trendingMovieList.search[index].Title}");
                                            } else {
                                              _trendingMovieListApi
                                                  .fetchMovieDetails(
                                                      _trendingMovieList
                                                          .search[index].Title)
                                                  .then((value) {
                                                if (value.Title != null) {
                                                  db.insertMovie(value,"movies");
                                                  _getMovieName();
                                                }
                                              });

                                              print(
                                                  "inserted :${_trendingMovieList.search[index].Title}");
                                            }
                                          }),
                                      alignment: Alignment.topRight,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 0.0, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending  Shows',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DiscoverMore(0)));
                        },
                        child: Text(
                          "See All",
                          style: TextStyle(color: Colors.indigo),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _trendingShowListIndex,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              width: 120,
                              child: Stack(
                                children: [
                                  GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    '${_trendingShowPopularList.search[index].poster}'))),
                                      ),
                                      onTap: () async {
                                        var result = await Navigator.push(
                                            context, MaterialPageRoute(
                                                builder: (context) {
                                          if (_checkMovieName(
                                              _trendingShowPopularList
                                                  .search[index].Title)) {
                                            return MovieDetails(
                                                _trendingShowPopularList
                                                    .search[index].Title,
                                                false,"shows");
                                          } else {
                                            return MovieDetails(
                                                _trendingShowPopularList
                                                    .search[index].Title,
                                                true,"shows");
                                          }
                                        }));
                                        if (result == true) {
                                          _getMovieName();
                                        }
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      child: IconButton(icon:
                                        _checkMovieName(_trendingShowPopularList
                                                .search[index].Title)
                                            ? Icon(Icons.check_box, size: 30)
                                            : Icon(Icons.add_box_outlined, size: 30),
                                        color: Colors.yellow,  onPressed: () {
                                          DatabaseHelper db =
                                          new DatabaseHelper();
                                          if (_checkMovieName(
                                              _trendingShowPopularList
                                                  .search[index].Title)) {
                                            db.deleteMovieUsingName(
                                                _trendingShowPopularList
                                                    .search[index].Title);
                                            _getMovieName();
                                            print(
                                                "deleted :${_trendingShowPopularList.search[index].Title}");
                                          } else {
                                            _trendingShowListApi
                                                .fetchMovieDetails(
                                                _trendingShowPopularList
                                                    .search[index].Title)
                                                .then((value) {
                                              if (value.Title != null) {
                                                db.insertMovie(value,"shows");
                                                _getMovieName();
                                              }
                                            });

                                            print(
                                                "inserted :${_trendingShowPopularList.search[index].Title}");
                                          }
                                        },

                                      ),
                                      alignment: Alignment.topRight,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10, top: 20, bottom: 10),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 1000,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _moviePopularListIndex == 0 ? 0 : 5,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Opacity(
                                    opacity: 0.7,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  '${_trendingMovieList.search[index].poster}'))),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, bottom: 6.0, right: 4.0, top: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Discover More",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "New shows and movies are waiting for you",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return DiscoverMore(0);
                      },
                      ));
                }
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                child: Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20.0, bottom: 0.0, left: 10, right: 10),
                child: Align(
                  child: Text(
                    'Recent  Activity',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.topLeft,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10, top: 20, bottom: 10),
                child: Container(
                  height: 335,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage('assets/recent_activity.png'))),
                      ),
                      Expanded(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _recentActivityData.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                    child: ListTile(
                                      leading: Image(
                                        image: _images[index],
                                        height: 30,
                                        width: 25,
                                      ),
                                      title: Text(
                                        _recentActivityData[index],
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    onTap: () {
                                      showAlertDialogBox(context);
                                    },
                                  ),
                                  Opacity(
                                    opacity:
                                        index == _recentActivityData.length - 1
                                            ? 0.0
                                            : 1.0,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      child: Container(
                                        height: 0.5,
                                        width: double.infinity,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _updateMoveList() {
    _trendingMovieListApi.fetchPopularList("joy").then((value) {
      setState(() {
        _trendingMovieList = value;
        _moviePopularListIndex = value.search.length;
      });
    });
  }

  _updateShowList() {
    _trendingShowListApi.fetchPopularList("witcher").then((value) {
      setState(() {
        _trendingShowPopularList = value;
        _trendingShowListIndex = value.search.length;
      });
    });
  }

  ///fun to check whether  movie list in watchList
  bool _checkMovieName(String movie) {
    if (_movieNameList.contains(movie)){

      return true;
    } else {
      return false;
    }
  }

  /// fun to get movie name

  _getMovieName() {
    DatabaseHelper db = new DatabaseHelper();
    db.getMovieName("").then((value) {
      setState(() {
        _movieNameList = value;
        debugPrint(" movie name :${value.toList()}");
      });
    });
  }
}
