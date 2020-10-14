import 'package:flutter/material.dart';
import 'package:movie_mock_list/app_screen%20/homePage/discover/discoverShows.dart';
import 'package:movie_mock_list/app_screen%20/homePage/discover/discovermMovies.dart';
import 'package:movie_mock_list/const/constants.dart';
import 'package:movie_mock_list/utils/utils.dart';



class DiscoverMore extends StatefulWidget {
  int index;
  DiscoverMore(int index)
  {
    this.index = index;
  }
  @override
  _DiscoverMoreState createState() => _DiscoverMoreState(index);
}

class _DiscoverMoreState extends State<DiscoverMore> {
  int index2=0;
  _DiscoverMoreState(index)
  {
    this.index2 = index;
  }
  final List<Widget> _children = [DiscoverShows(),DiscoverMovies()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(icon :Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 30,),onPressed: (){
            moveToLastScreen(context);
          },),
          backgroundColor: Colors.white,
          title: Text(DISCOVER_MORE,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.more_vert,color: Colors.black,size: 20,),onPressed: (){

            },)
          ],
        ),
        body: WillPopScope(
          child: DefaultTabController(
            initialIndex: index2,
          length: 2,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
                appBar: PreferredSize(
                  preferredSize: Size(double.infinity, 60),
                  child: TabBar(
                    indicatorColor: Colors.yellow,
                    indicatorWeight: 5,
                    unselectedLabelStyle: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                    labelColor: Colors.yellow,//
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                    tabs:
                    [
                      Tab(child:Text(SHOWS,)),
                      Tab(child:Text(MOVIES))
                    ],

                  ),
                ),
                body: TabBarView(
                  children: [
                    _children[0],
                    _children[1],
                  ],
                )
            ),
          ),
    ),
          onWillPop: (){
        return  moveToLastScreen(context);
          },
        ));



  }
}
