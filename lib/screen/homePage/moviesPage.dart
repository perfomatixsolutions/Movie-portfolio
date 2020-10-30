import 'package:flutter/material.dart';
import 'package:movie_mock_list/screen/homePage/movies/moviesUpcomingList.dart';
import 'package:movie_mock_list/screen/homePage/movies/moviesWatchList.dart';
import 'package:movie_mock_list/const/constants.dart';

class  Movies extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Movies> with TickerProviderStateMixin {
  TabController _tabController;

  final List<Widget> _children = [MoviesWatchList(),MoviesUpcomingList()];
  var index =0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {
      index =_tabController.index;
    });
  }

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 60),
              child: SafeArea(
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.yellow,
                  indicatorWeight: 5,
                  unselectedLabelStyle: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                  labelColor: Colors.yellow,//
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),
                  tabs:
                  [
                    Tab(child:Text(WATCH_LIST,)),
                    Tab(child:Text(UPCOMING))
                  ],

                ),
              ),
            ),
            body:(
            _children.elementAt(index)
            ),
        );


  }

}
