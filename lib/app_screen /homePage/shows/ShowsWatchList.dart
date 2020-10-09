import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/model/MovieDetailsModel.dart';
import 'package:movie_mock_list/utils/dbHelper.dart';
import '../../discoverMorePage.dart';
import 'package:sqflite/sqflite.dart';

import '../moviedetails.dart';

class ShowsWatchList extends StatefulWidget {


  @override
  _ShowsWatchListState createState() => _ShowsWatchListState();
}

class _ShowsWatchListState extends State<ShowsWatchList> {
  DatabaseHelper databaseHelper = new DatabaseHelper();
  Future<List<MovieDetailsModel>> _movieDetailsList;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<List<MovieDetailsModel>>(
            future: _movieDetailsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length != 0) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20, right: 20),
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: (itemWidth / itemHeight),
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 3),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  height: 1000,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          0),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              '${snapshot.data[index]
                                                  .poster}')
                                      )
                                  ),
                                ),
                                onTap: () async {
                                  var result = await Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetails(
                                              snapshot.data[index].Title,false,"Shows")));
                                  if (result == true) {
                                    updateListView();
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(height: 1, color: Colors.grey,),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black)),

                              onPressed: () async {
                                final result = await Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) => DiscoverMore(0)));
                                print("result :$result");
                                if (result == true) {
                                  setState(() {
                                    updateListView();
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text("DISCOVER SHOWS", style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),),
                              )),
                        )
                      ],
                    ),
                  );
                }
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("You have no shows to watch!",
                          style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),)),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                            height: 120,
                            child: Image(image: AssetImage('assets/tv.png'),))),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Discover shows to watch",
                          style: TextStyle(color: Colors.black, fontSize: 15),)),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: RaisedButton(
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),

                          onPressed: () async {
                            final result = await  Navigator.push(context, MaterialPageRoute(
                                builder: (context) => DiscoverMore(0)));
                            print("result :$result");
                            if(result == true )
                            {
                              setState(() {
                                updateListView();
                              });

                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("DISCOVER SHOWS", style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),),
                          )),
                    ),

                  ],
                ),
              );
            }


        ));
  }

  void updateListView() async {
    Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      setState(() {

        _movieDetailsList = databaseHelper.getMovieList("shows");
      });
    });
  }
  @override
  void initState() {
    super.initState();
    updateListView();
  }
}


