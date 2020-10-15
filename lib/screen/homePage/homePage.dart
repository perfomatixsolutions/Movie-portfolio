import 'package:flutter/material.dart';
import 'package:movie_mock_list/screen/homePage/discoverPage.dart';
import 'package:movie_mock_list/screen/homePage/profilePage.dart';
import 'package:movie_mock_list/screen/homePage/showsPage.dart';
import 'package:movie_mock_list/const/constants.dart';

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
              title: new Text(NAV_SHOWS,style:TextStyle(color: _page == 0? Colors.black:Colors.grey)),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.movie_creation_outlined,color: _page == 1? Colors.black:Colors.grey,size: 30),
              title: new Text(NAV_MOVIE,style:TextStyle(color: _page == 1? Colors.black:Colors.grey)),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,color : _page == 2? Colors.black:Colors.grey,size: 30),
                title: Text(NAV_DISCOVER,style:TextStyle(color:  _page == 2? Colors.black:Colors.grey,))
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,color: _page == 3? Colors.black:Colors.grey,size: 30),
                title: Text(NAV_PROFILE,style:TextStyle(color:  _page == 3? Colors.black:Colors.grey,))
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
