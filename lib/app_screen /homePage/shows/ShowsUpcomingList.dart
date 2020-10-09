import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../discoverMorePage.dart';
class ShowsUpcomingList extends StatefulWidget {
  @override
  _WatchListState createState() => _WatchListState();
}

class _WatchListState extends State<ShowsUpcomingList> {
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
                child: Text("You have no upcoming shows!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
            Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                    height: 120,
                    child: Image(image: AssetImage('assets/tv.png'),))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text("Discover shows to watch",style: TextStyle(color: Colors.black,fontSize: 15),)),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: RaisedButton(
                  color: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),

                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context) =>DiscoverMore(0)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text("DISCOVER SHOWS",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
                  )),
            ),

          ],
        ),
      ),
    );
  }
}