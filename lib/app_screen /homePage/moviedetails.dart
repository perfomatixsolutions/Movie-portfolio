import 'package:flutter/material.dart';
import 'package:movie_mock_list/model/MovieDetailsModel.dart';
import 'package:movie_mock_list/utils/Utils.dart';
import 'package:movie_mock_list/utils/api/api.dart';
import 'package:movie_mock_list/utils/dbHelper.dart';


class MovieDetails extends StatefulWidget {
  String movie;
  bool _dataFromApi;
  String category;
  MovieDetails(this.movie,this._dataFromApi,this.category);
  @override
  _MovieDetailsState createState() => _MovieDetailsState(this.movie,this._dataFromApi,this.category);
}

class _MovieDetailsState extends State<MovieDetails> {
  DatabaseHelper db = new DatabaseHelper();
  String movie ;
  bool _dataFromApi;
  int watchList  = 0;
  String category;
  var fetchMovieList = new Api();
  MovieDetailsModel _moviePopularList = new MovieDetailsModel();
  Future<MovieDetailsModel > futureAlbum;
  _MovieDetailsState(movie11,data,category){
    debugPrint("movies from api :$movie11");
    this.movie = movie11;
    this._dataFromApi =data;
    this.category =category;
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
     onWillPop: (){
       return  moveToLastScreen();
     },
      child: Scaffold(
        body: SafeArea(
          child: FutureBuilder<MovieDetailsModel>(
            future: futureAlbum,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.response != "False") {
                  _moviePopularList =snapshot.data;
                 return  NestedScrollView(
                    headerSliverBuilder: (BuildContext context,
                        bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          actions: [
                                  Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.black,
                                      backgroundColor: Colors.transparent
                                    ),
                                    child: DropdownButton<String>(
                                      underline: SizedBox(),
                                      icon:Icon(
                      Icons.more_vert, color: Colors.white, size: 20,) ,
                                      items: <String>[_dataFromApi?'Add to WatchList':'Remove from WatchList'].map((String value) {
                                        return new DropdownMenuItem<String>(
                                          value: value,
                                          child: new Text(value,style: TextStyle(color: Colors.white,fontSize: 15),),
                                        );
                                      }).toList(),
                                      onChanged: (_) async{

                                        if(_dataFromApi) {
                                        await db.insertMovie(
                                        _moviePopularList,category);
                                        setState(() {
                                        watchList = 1;
                                        });
                                        moveToLastScreen();
                                        }
                                        else{
                                        db.deleteMovie(_moviePopularList.id);
                                        moveToLastScreen();
                                        }}
                                      ,
                                    ),
                                  )],
                          backgroundColor: Colors.black,
                          expandedHeight: 250.0,
                          floating: false,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(

                              title: Text(_moviePopularList.Title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  )),
                              background: Image.network(_moviePopularList.poster,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ];
                    },
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(width: 10,),
                                      Icon(Icons.calendar_today, color: Colors.grey,
                                        size: 20,),
                                      SizedBox(width: 10,),
                                      Text(_moviePopularList.year, style: TextStyle(
                                          color: Colors.black, fontSize: 20),),
                                    ]
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      Icon(Icons.remove_red_eye_outlined,
                                        color: Colors.grey, size: 20,),
                                      SizedBox(width: 10,),
                                      Text("Not watched", style: TextStyle(
                                          color: Colors.black, fontSize: 20),)
                                    ]
                                ),
                              ),
                              Spacer(),
                              Flexible(
                                flex: 1,
                                child: IconButton(icon: Icon(Icons.verified,
                                    color: Colors.grey, size: 25), onPressed: () {

                                }),
                              )

                            ],
                          ),
                        ),
                        Container(height: 0.5,color: Colors.grey,),
                        Padding(
                          padding: const EdgeInsets.only( left :10,top: 10,bottom: 2),
                          child: Text("PLOT",textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(_moviePopularList.plot,
                              style: TextStyle(color: Colors.black, fontSize: 18,),),
                          ),
                        )
                      ],
                    ),
                  );
                }
                    return Center(child: CircularProgressIndicator());
              /*  else
                  {
                    return CircularProgressIndicator();
                  }
*/

              }
          ),
        ),
      ),

    );

  }
   moveToLastScreen() {

    Navigator.pop(context,true);
  }

  @override
  void initState() {
    super.initState();

     if(_dataFromApi) {
       setState(() {
       futureAlbum = fetchMovieList.fetchMovieDetails(movie);
       });
     }
     else {
       db.getCount().then((value) {
         debugPrint("value :$value");
         if (value != 0) {
           setState(() {
             futureAlbum = db.getDetails(movie);
           });

         }
         else {
           setState(() {
             futureAlbum = fetchMovieList.fetchMovieDetails(movie);
           });
         }
       });
   }



  }

}
