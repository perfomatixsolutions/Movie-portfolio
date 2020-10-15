import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/const/constants.dart';
import 'package:movie_mock_list/screen/login%20/loginPage.dart';
import 'package:splashscreen/splashscreen.dart';


void main()
{
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: APP_NAME,
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



