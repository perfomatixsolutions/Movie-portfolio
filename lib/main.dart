import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/const/constants.dart';
import 'package:movie_mock_list/widgets/SplashScreen.dart';

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
    return splash();
  }
}



