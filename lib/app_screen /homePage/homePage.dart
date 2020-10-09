import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:movie_mock_list/app_screen%20/DiscoverPage.dart';
import 'package:movie_mock_list/app_screen%20/homePage/ProfilePage.dart';
import 'package:movie_mock_list/app_screen%20/homePage/ShowsPage.dart';
import 'package:movie_mock_list/app_screen%20/homePage/favouritemovies.dart';

import 'moviesPage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _children = [Shows(),Movies(),DiscoverPage(),Profile()];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv,color: _page == 0? Colors.black:Colors.grey,size: 30,),
              title: new Text('Shows',style:TextStyle(color: _page == 0? Colors.black:Colors.grey)),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.movie_creation_outlined,color: _page == 1? Colors.black:Colors.grey,size: 30),
              title: new Text('Movies',style:TextStyle(color: _page == 1? Colors.black:Colors.grey)),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,color : _page == 2? Colors.black:Colors.grey,size: 30),
                title: Text('Discover',style:TextStyle(color:  _page == 2? Colors.black:Colors.grey,))
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,color: _page == 3? Colors.black:Colors.grey,size: 30),
                title: Text('Profile',style:TextStyle(color:  _page == 3? Colors.black:Colors.grey,))
            )
          ],
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
        ),
        body: Container(
          child: Center(child: _children[_page]),
        ),
      ),
    );
  }
}
