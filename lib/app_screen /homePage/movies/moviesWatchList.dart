import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/app_screen%20/homePage/movieDetails.dart';
import 'package:movie_mock_list/const/constants.dart';
import 'package:movie_mock_list/model/movieDetailsModel.dart';
import 'package:movie_mock_list/services/database/dbHelper.dart';
import '../discoverMorePage.dart';
import 'package:sqflite/sqflite.dart';

class MoviesWatchList extends StatefulWidget {
  @override
  _MoviesWatchListState createState() => _MoviesWatchListState();
}

class _MoviesWatchListState extends State<MoviesWatchList> with WidgetsBindingObserver {
  AppLifecycleState state1;
  DatabaseHelper databaseHelper = new DatabaseHelper();
  Future<List<MovieDetailsModel>> _movieDetailsList;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
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
                        padding: const EdgeInsets.only(top:10.0,left: 20,right: 20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (itemWidth / itemHeight),
                              crossAxisSpacing:5 , mainAxisSpacing: 5, crossAxisCount: 3),
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
                               var result  =await  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MovieDetails(snapshot.data[index].Title,false,"movies")));
                               if(result == true)
                                 {
                                   updateListView();
                                 }
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(height:1,color: Colors.grey,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.black)),

                            onPressed: () async {
                              final result = await  Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => DiscoverMore(1)));
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
                              child: Text(DISCOVER_MOVIES, style: TextStyle(
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(NO_MOVIES, style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),)),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                          height: 120,
                          child: Image(
                            image: AssetImage('assets/popcorn.png'),))),
                  Padding(
                      padding: EdgeInsets.all(35),
                      child: Text(
                       DISCOVER_MOVIES_TO_WATCH,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        textAlign: TextAlign.center,)),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                        color: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),

                        onPressed: () async {
                          final result = await  Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DiscoverMore(1)));
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
                          child: Text(ADD_MOVIES, style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                        )),
                  ),

                ],
              );
          }


        ));
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    this.state1 = state;
    print('state = $state1');
      setState(() {
        debugPrint("State :$state");
        updateListView();
      });



  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    updateListView();
  }

  @override
  void dispose() {
   WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void updateListView() async {
    Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      setState(() {
        debugPrint("${databaseHelper.getMovieList("movies").toString()}");
        _movieDetailsList = databaseHelper.getMovieList("movies");
      });

    });
  }
}
