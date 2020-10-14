


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/app_screen%20/login%20/loginPage.dart';
import 'package:splashscreen/splashscreen.dart';


Widget splash()
{
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