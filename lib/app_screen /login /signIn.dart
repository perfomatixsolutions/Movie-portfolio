import 'package:flutter/material.dart';
import 'package:movie_mock_list/app_screen%20/homePage/homePage.dart';
import 'package:movie_mock_list/utils/Utils.dart';


class SignIn extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignIn> {
  var _formkey = GlobalKey<FormState>();
  var _minPadding = 5.0;
  FocusNode fieldNode = FocusNode();
  TextEditingController username =TextEditingController();
  TextEditingController password =TextEditingController();
  FocusNode _userFocus = new FocusNode();
  FocusNode _passwordFocus = new FocusNode();
  List<Color> _color = [Colors.grey,Colors.white];
  Color _userIcon = Colors.grey;
  Color _passwordIcon = Colors.grey;
  var _mMaskedPasswordDisabled = true;
  var _mMaskedPasswordIcon = Icons.remove_red_eye;




  @override
  void initState() {
    _userIcon = _color[0];
    _passwordIcon = _color[0];
    _userFocus.addListener(_onUserNameFocusChange);
    _passwordFocus.addListener(_onPasswordFocusChange);
  }
  void _onUserNameFocusChange(){
    setState(() {
      _passwordIcon =_color[0];
    if(_userFocus.hasFocus == true)
      {

          _userIcon =_color[1];

      }
    });
  }
  void _onPasswordFocusChange(){
    setState(() {
      _userIcon =_color[0];
    if(_passwordFocus.hasFocus == true)
    {

        _passwordIcon =_color[1];

    }
    });

  }
     passwordVisibility()
   {
     setState(() {
       if(_mMaskedPasswordDisabled)
         {
           _mMaskedPasswordIcon =Icons.remove_red_eye;

         }
       else
         {
           _mMaskedPasswordIcon =Icons.remove_red_eye_outlined;
         }
       _mMaskedPasswordDisabled = ! _mMaskedPasswordDisabled;

     });
   }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(elevation :1.0,backgroundColor:Colors.transparent,title:  Text("Sign in"),centerTitle: true ,leading: GestureDetector(child: Icon(Icons.arrow_circle_down),onTap: (){
              moveToLastScreen();
            },),),
            backgroundColor: Colors.black.withOpacity(0.5),
            //color: Colors.transparent,
            body: SingleChildScrollView(

              child: Column(
                children: [
                  Container(height: 0.9,color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.only(top:20,bottom: 20),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundImage:
                              AssetImage('assets/apple_logo.png'),
                              radius: 30,
                              backgroundColor: Colors.white,
                            ),
                            onTap: ()
                            {
                              showAlertDialogBox(context);
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                                backgroundImage:
                                AssetImage('assets/google_logo.png'),
                                radius: 30),
                            onTap: ()
                            {
                              showAlertDialogBox(context);
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                                backgroundImage:
                                AssetImage('assets/facebook_logo.png'),
                                radius: 30),
                            onTap: ()
                            {
                              showAlertDialogBox(context);
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                                backgroundImage:
                                AssetImage('assets/twitter_logo.png'),
                                radius: 30),
                            onTap: ()
                            {
                              showAlertDialogBox(context);
                            },
                          ),
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: Container(height:0.5,color: Colors.white,),flex: 3,),
                      Flexible(child: Text(" OR ",style: TextStyle(color: Colors.white)),flex: 1,),
                      Flexible(child: Container(height:0.5,color: Colors.white,),flex: 3,)
                    ],
                  ),
                  Form(
                    key: _formkey,
                    child: ListView(
                        shrinkWrap: true,
                        children:[
                          SizedBox(height: 70,),
                          Padding(
                          padding: EdgeInsets.all(20),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            controller: username,
                            focusNode: _userFocus,
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.white),

                            validator: (String value) {
                              if(value.isEmpty) {return "Username or Email";}
                              else{
                                return value;
                              }


                            },
                            decoration: InputDecoration(
                                hintText: "Username or Email",
                                errorStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                                hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                                labelStyle: TextStyle(color: Colors.white, fontSize: 15.0),

                                prefixIcon: Icon(Icons.mail,color: _userIcon),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),  ),

                          ),

                        ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: TextFormField(

                              controller: password,
                              obscureText: _mMaskedPasswordDisabled,
                              focusNode: _passwordFocus,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              validator: (String value) {
                                if(value.isEmpty) {return "Password";}
                                else{
                                  return value;
                                }


                              },
                              decoration: InputDecoration(

                                  hintText: 'Password',
                                  errorStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                                  labelStyle: TextStyle(color: Colors.white, fontSize: 15.0),
                                  prefixIcon: Icon(Icons.lock,color:_passwordIcon,),
                                suffixIcon: IconButton(icon: Icon(_mMaskedPasswordIcon,color: Colors.white,),onPressed: (){
                                  passwordVisibility();
                                },),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),

                                  )),
                            ),
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              child: Text(
                                "forget Password?",
                                textAlign: TextAlign.end,
                                style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                              ),
                            onTap: (){
                                showAlertDialogBox(context);
                            },
                            ),

                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: RaisedButton(
                              onPressed: () {
                                moveToHomeScreen();
                              },
                              color: Colors.amber,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            )
          //body: Text("ih"),
        ),
        onWillPop: (){
          return moveToLastScreen();}
    );
  }

  @override
  void dispose() {
    _userFocus.dispose();
    _passwordFocus.dispose();
  }

  moveToLastScreen() {

    Navigator.pop(context,true);
  }
  moveToHomeScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainScreen();
    }),);
  }
}
