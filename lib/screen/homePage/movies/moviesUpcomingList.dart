import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/const/constants.dart';
import '../discoverMorePage.dart';

class MoviesUpcomingList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<MoviesUpcomingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(NO_MOVIES,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
            Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                    height: 120,
                    child: Image(image: AssetImage('assets/popcorn.png'),))),
            Padding(
                padding: EdgeInsets.all(35),
                child: Text(DISCOVER_MOVIES_TO_WATCH,style: TextStyle(color: Colors.black,fontSize: 15),textAlign: TextAlign.center)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                  color: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),

                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(

                        pageBuilder: (_, __, ___) => DiscoverMore(1)));
                    //Navigator.push(context, MaterialPageRoute(builder:(context) =>DiscoverMore(1)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(ADD_MOVIES,style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}