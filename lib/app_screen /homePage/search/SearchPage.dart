
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_mock_list/model/movieModel.dart';
import 'package:movie_mock_list/utils/Utils.dart';
import 'package:movie_mock_list/utils/api/api.dart';
import 'package:movie_mock_list/utils/dbHelper.dart';

import '../moviedetails.dart';



class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Search> _moviePopularList=List<Search>();
  List<String>_movieNameList = List<String>();
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
                  visible:(index ==_moviePopularListIndex && isPageLoading == true)?false:true,

                  child: Column(
                    children: [
                      GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image(image: NetworkImage(

                              '${_moviePopularList[index].poster}',),  width:50,
                              height:100,
                            ),

                            Container(
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(_moviePopularList[index].Title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),maxLines: 1, overflow: TextOverflow.ellipsis),
                                  Text(_moviePopularList[index].Title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),maxLines: 1, overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            IconButton(icon: Icon(_checkMovieName(_moviePopularList[index].Title)?Icons.check_box:Icons.add_box_outlined,color: Colors.yellow,size: 30,), onPressed: (){
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
                                  if(value.Title != null) {
                                    db.insertMovie(value,"movies");
                                    _getMovieName();
                                  }
                                });

                                print ("inserted :${_moviePopularList[index].Title}");

                              }

                            })

                          ],
                        ),

                        onTap: () async {
                            var result =  await Navigator.push(context, MaterialPageRoute(builder: (context)
                            {
                              if(_checkMovieName(_moviePopularList[index].Title)) {
                                return MovieDetails(
                                    _moviePopularList[index].Title, false,"movies");
                              }
                              else
                                {
                                  return MovieDetails(
                                      _moviePopularList[index].Title, true,"movie");
                                }
                            }));
                            if(result == true)
                              {
                                _getMovieName();
                              }
                          },

                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 0.5,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: (index ==_moviePopularListIndex && isPageLoading == true)? 50 : 0,
                    width: 50,
                    child:CircularProgressIndicator(
                    ),
                  ),
                )
              ],
            );

        });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.arrow_back,color: Colors.black,size: 25,),
        title: Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: TextFormField(
          autofocus: true,
          cursorColor: Colors.yellow,
          validator: (String value) {
            if (value.isEmpty) {
              return "Search";
            }
            else {
              return value;
            }
          },
          onChanged: (String value){
            setState(() {
              if (value.length > 2) {
                _updateListBySearch(value);
              }
              else
                {
                  _updateList();
                }
            });
          },
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Search'),
    ),
      ),
      actions: [
        IconButton(icon:Icon( Icons.mic,color: Colors.black,size: 25), onPressed: ()
        {
          showAlertDialogBox(context);
        })
      ],

      ),
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
        isPageLoading =true;
        _updateList();
      });
    }
  }

  _updateList() {
    fetchMovieList.fetchPopularList("era")
        .then((value) {
      setState(() {
        if(_moviePopularList.length ==0)
        {
          _moviePopularList =value.search;
        }
        else {
          isPageLoading =false;
          for (var movie in value.search) {
            _moviePopularList.add(movie);
          }
        }
        _moviePopularListIndex = _moviePopularList.length-1;
      });
    });
  }

  _updateListBySearch(String value) {
    fetchMovieList.fetchPopularList(value)
        .then((value) {
      setState(() {
        if(_moviePopularList.length ==0)
        {
          _moviePopularList =value.search;
          _moviePopularListIndex = _moviePopularList.length;
        }
        else {
          isPageLoading =false;
            _moviePopularList = value.search;
          _moviePopularListIndex = _moviePopularList.length-1;
        }
        _getMovieName();
      });
    });
  }

  ///fun to check whether  movie list in watchList
  bool _checkMovieName(String movie){
    if (_movieNameList.firstWhere((element) => element == movie,orElse: () => null)!= null)
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  /// fun to get movie name

  _getMovieName(){

    DatabaseHelper db = new DatabaseHelper();
    db.getMovieName("").then((value){
      setState(() {
        _movieNameList = value;
        debugPrint(" movie name :${value.toList()}");
      });
    });
  }
}