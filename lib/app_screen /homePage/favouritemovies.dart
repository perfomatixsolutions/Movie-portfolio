import 'package:flutter/material.dart';


class FavouriteMovies extends StatefulWidget {
  @override
  _FavouriteMoviesState createState() => _FavouriteMoviesState();
}

class _FavouriteMoviesState extends State<FavouriteMovies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Favourite Movies')
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(height: 500,
              padding: const EdgeInsets.all(10),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://m.media-amazon.com/images/M/MV5BYjA5YjA2YjUtMGRlNi00ZTU4LThhZmMtNDc0OTg4ZWExZjI3XkEyXkFqcGdeQXVyNjUyNjI3NzU@._V1_UY1200_CR165,0,630,1200_AL_.jpg')
                              )
                          ),

                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Blood Shoot", style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,),),
                            SizedBox(width: 10),
                            Container(
                                width: 200,
                                child: Text(
                                  "Ray Garrison, an elite soldier who was killed in battle, is brought back to life by an advanced technology that gives him the ability of super human strength  ",
                                  style: TextStyle(fontSize: 12),)),
                          ],
                        )
                      ],
                    ),

                  ),
                  Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://m.media-amazon.com/images/M/MV5BYjA5YjA2YjUtMGRlNi00ZTU4LThhZmMtNDc0OTg4ZWExZjI3XkEyXkFqcGdeQXVyNjUyNjI3NzU@._V1_UY1200_CR165,0,630,1200_AL_.jpg')
                              )
                          ),

                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Blood Shoot", style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,),),
                            SizedBox(width: 10),
                            Container(
                                width: 200,
                                child: Text(
                                  "Ray Garrison, an elite soldier who was killed in battle, is brought back to life by an advanced technology that gives him the ability of super human strength  ",
                                  style: TextStyle(fontSize: 12),)),
                          ],
                        )
                      ],
                    ),

                  ),
                  Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          height: 150,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      'https://m.media-amazon.com/images/M/MV5BYjA5YjA2YjUtMGRlNi00ZTU4LThhZmMtNDc0OTg4ZWExZjI3XkEyXkFqcGdeQXVyNjUyNjI3NzU@._V1_UY1200_CR165,0,630,1200_AL_.jpg')
                              )
                          ),

                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Blood Shoot", style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,),),
                            SizedBox(width: 10),
                            Container(
                                width: 200,
                                child: Text(
                                  "Ray Garrison, an elite soldier who was killed in battle, is brought back to life by an advanced technology that gives him the ability of super human strength  ",
                                  overflow: TextOverflow.ellipsis,maxLines: 2,)),
                          ],
                        )
                      ],
                    ),

                  )
                ],
              ),)
          ],
        ),
      ),
    );
  }
}
