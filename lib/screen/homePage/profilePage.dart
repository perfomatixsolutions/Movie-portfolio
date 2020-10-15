
import 'package:flutter/material.dart';
import 'package:movie_mock_list/screen/homePage/profile/cameraWidget.dart';
import 'package:movie_mock_list/screen/login%20/loginPage.dart';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:movie_mock_list/utils/utils.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:movie_mock_list/services/database/dbHelper.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
   var _settingsList = ['Custom Lists','Followers','Following','Comments','Stats'];
   String  _imgPath ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
          children: <Widget>[
          // The containers in the background
          new Column(
          children: <Widget>[
           Container(
            width: double.infinity,
          height: MediaQuery.of(context).size.height * .31,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:AssetImage(
                        'assets/profile_background.jpg')
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children :[
                Align(alignment: Alignment.topLeft,child: Icon(Icons.help,color:Colors.white,size:30)),
                Align(alignment: Alignment.topRight,child: Icon(Icons.notifications,color: Colors.yellow,size:30)),

          ]
              ),
            ),
          ),
          new Container(
          height: MediaQuery.of(context).size.height * .60,
          color: Colors.white,
          ),
    ]
    ),
            Container(
              alignment: Alignment.topCenter,
              padding: new EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .25),
              child: Column(
                children: [
                   GestureDetector(
                     child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _imgPath == null? AssetImage(
                                'assets/default_profile.png'):FileImage(File(_imgPath))
                        ),
                      ),
                      width:100,
                  ),
                     onTap: (){
                       takePicture();
                     },
                   ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 20,
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),

                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    'assets/flag.png')
                            ),
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:5,right:5),
                          child: Text("Anonymous",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),),
                        ),
                       Icon(Icons.ios_share,color: Colors.grey,size:  20,)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 80,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5.0,
                              ),]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Episodes Watch",style: TextStyle(color: Colors.black,fontSize: 15),),
                              Text("0",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
                            ],
                          ),
                        ),
                        onTap: (){
                          showAlertDialogBox(context);
                        },
                      ),
                      GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            height: 80,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Movies Watch",style: TextStyle(color: Colors.black,fontSize: 15),),
                                Text("0",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
                              ],
                            ),
                          ),
                        ),
                        onTap: (){
                          showAlertDialogBox(context);
                        },
                      ),

                    ],
                  ),

                  GestureDetector(
                    child: ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _settingsList.length,itemBuilder: (context,index){

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(visible :(index == _settingsList.length-1)?false:false,
                              child: Container(height:  0.5,color: Colors.grey,)),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_settingsList[index],style: TextStyle(color: Colors.black,fontSize: 20),),
                                Row(
                                  children:[
                                    Text("0",style: TextStyle(color: Colors.black,fontSize: 20),),
                                    Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(height:  0.5,color: Colors.grey,),
                        ],
                      );
                    }),
                    onTap: (){
                      showAlertDialogBox(context);
                    },
                  ),
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: RaisedButton(onPressed: () {
                     logout();
                   },color: Colors.green,shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(30)),
                   child: Text("Logout",style:TextStyle(color:Colors.white,fontSize: 15,fontWeight: FontWeight.bold))),
                 )
                ],
              ),
            )
          ],
          ),
        ),
      ), // set the `alignment` of container to Alignment.bottomCenter
    );

  }

  /// fun to Logout

   void logout()
   {
     Navigator.of(context).pushAndRemoveUntil(
       // the new route
       MaterialPageRoute(
         builder: (BuildContext context) => LoginPage(),
       ),
           (Route route) => false,
     );
   }

   /// fun to take  profile image

   void takePicture()
    async {
       var result = await  Navigator.push(context, MaterialPageRoute(
         builder: (context) => CameraWidget()));
       if(result == true)
         {
           getProfileImagePath();
         }
   }

   @override
  void initState() {
    super.initState();
    getProfileImagePath();
  }

  /// fun to get Image path

  void getProfileImagePath() {
    DatabaseHelper db = DatabaseHelper();
    db.getProfileImagePath().then((value) =>{

      setState(()
      {
        debugPrint("value : ${value.imgPath}");
        _imgPath = value.imgPath;
      })
    });
  }
}
