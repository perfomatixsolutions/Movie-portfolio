import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:movie_mock_list/app_screen%20/homePage/moviedetails.dart';
import 'package:movie_mock_list/app_screen%20/login%20/signIn.dart';
import 'package:movie_mock_list/app_screen%20/login%20/signup.dart';
import 'package:movie_mock_list/model/movieModel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  AnimationController controller;
  var _scrollContainer = ScrollController();
  final _height = 100.0;
  Animation<double> animation;
  Timer _timer;
  int _count = 0;
  int _scrollCount = 0;
  var _icon = [Icons.ondemand_video, Icons.thumb_up_alt, Icons.check_circle];
  var _content = [
    'Discover  your new Favourite App',
    'Help them to show even better',
    'Track your shows and Movies',
    'Remember where you left off'
  ];
  var _opacity =1.0;
  var _blurOpacity =false;
  List<Search> _movieViewAllList = List<Search>();
  int _movieViewAllListIndex = 0;


  @override
  Widget build(BuildContext context) {

    var size = MediaQuery
        .of(context)
        .size;
    Timer(
      Duration(seconds: 1),
      () => _scrollContainer.jumpTo(_scrollCount.toDouble() * 10),
    );

    return Scaffold(
      body:  Container(
        height: double.infinity,
        color: Colors.black54,
        child: Stack(children: [
      /*  Container(
      child: StaggeredGridView.countBuilder(
          crossAxisCount: 8,
          controller: _scrollContainer,
          scrollDirection: Axis.vertical,
          itemCount: 80,
          shrinkWrap: true,
          itemBuilder: (context, index) {


              return Image(
                  image:
                  NetworkImage('https://cache.desktopnexus.com/thumbseg/1272/1272680-bigthumbnail.jpg'));

          },
          staggeredTileBuilder: (index) => new StaggeredTile.fit(2)),
        ),*/

        SingleChildScrollView(
          controller: _scrollContainer,
          child: Container(
            height: MediaQuery.of(context).size.height+100,
            width:  double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(5),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/login_background.jpg')))),
          ),
         Visibility(
            visible: _blurOpacity,
             child: BlurryEffect(0.0,0.0,Colors.grey)),
        Opacity(
      opacity: _opacity,
      child: Container(
        color: Colors.black.withOpacity(0.2),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 75),
              FadeTransition(
                //duration: const Duration(seconds: 3),
                opacity: animation,
                child: _createText(_scrollContainer, context,
                    _content[_count], _icon[_count]),
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: RaisedButton(
                    onPressed: () {
                      navigationToSignUpPage();
                    },
                    color: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "GET STARTED",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: ()
                  {
                    navigationToSignInPage();
                  },
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Have an account?',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                        TextSpan(
                            text: ' SIGN IN',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ])
            ]),
      ),
        ),
      ]),
      )
    );
  }

  void _toEnd() {
    // NEW
    new Timer.periodic(
      const Duration(seconds: 11),
      (Timer timer) => setState(
        () {
          if (_count >= 2) {
            timer.cancel();
          } else {
            _count = _count + 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollContainer = new ScrollController(
      // NEW
      initialScrollOffset: 10.0, // NEW
      keepScrollOffset: true, // NEW
    );
    controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (_count < 2) {
          controller.reverse();
        }
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

   /* _fetchPopularList().then((value) {
      setState(() {
        for (var i in value.search) {
          _movieViewAllList.add(i);
          _movieViewAllList.add(i);
          _movieViewAllList.add(i);
        }
        _movieViewAllListIndex = _movieViewAllList.length - 1;
      });
      _scrollContainer.notifyListeners();
    });*/

    controller.forward();
    _timer = new Timer.periodic(
      const Duration(seconds: 11),
      (Timer timer) => setState(
        () {
          _scrollCount = _count + 1;
          if (_count >= 2) {
            timer.cancel();
          } else {
            _count = _count + 1;
          }
        },
      ),
    );

    var _timer2 = new Timer.periodic(
      const Duration(seconds: 6),
      (Timer timer) => setState(() {
        _scrollCount = _scrollCount + 1;
      }),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
  }
  Future navigationToSignUpPage()  async{
    setState(() {
      this._opacity =0.0;
      this._opacity=1.0;
    });
    var result =  await Navigator.of(context).push(PageRouteBuilder(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) => SingUp(),
        transitionsBuilder: (context, animation,
            secondaryAnimation, child) {
          var begin = Offset(1.5,0.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }));

    if(result  == true)
    {
      setState(() {
        this._opacity =1.0;

      });
    }
  }

  Future navigationToSignInPage()  async{
    setState(() {
      this._opacity =0.0;
      this._blurOpacity=true;

    });
    var result =  await Navigator.of(context).push(PageRouteBuilder(
        opaque: false, // set to false
        pageBuilder: (_, __, ___) => SignIn(),
        transitionsBuilder: (context, animation,
            secondaryAnimation, child) {
          var begin = Offset(0.0, 1.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        }));

    if(result  == true)
    {
      setState(() {
        this._opacity =1.0;
        this._blurOpacity =false;
      });
    }
  }
}



Widget _createText(ScrollController scrollController, BuildContext context,
    String data, IconData icon) {
  return Column(
    children: [
      RaisedButton(
          color: Colors.black,
          shape: CircleBorder(side: BorderSide.none),
          onPressed: () {},
          child: Icon(icon, size: 20, color: Colors.white)),
      SizedBox(height: 10),
      Text(
        '$data',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      )
    ],
  );
}

class BlurryEffect extends StatelessWidget {
  final double opacity;
  final double blurry;
  final Color shade;  BlurryEffect(this.opacity,this.blurry,this.shade);    @override  Widget build(BuildContext context) {
    return Container(
      child: ClipRect(
        child:  BackdropFilter(
          filter:  ImageFilter.blur(sigmaX:10, sigmaY:10),
          child:  Container(
            width: double.infinity,
            height:  double.infinity,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
