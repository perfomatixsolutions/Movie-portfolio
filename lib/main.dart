import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/app_screen%20/login%20/loginPage.dart';
import 'package:splashscreen/splashscreen.dart';

import 'app_screen /homePage/homePage.dart';


void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Movie Mock List App',
      color: Colors.white,
      home :MovieApp()));
}
class MovieApp extends StatefulWidget {
  @override
  _MovieAppState createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SplashScreen(
        seconds: 5,
        backgroundColor: Colors.white,
        image: Image.asset('assets/movie_mock_list_launching.gif'),
        photoSize: 200.0,
        loadingText: Text("Loading"),
        navigateAfterSeconds: LoginPage(),
      ),
    );
  }
}



