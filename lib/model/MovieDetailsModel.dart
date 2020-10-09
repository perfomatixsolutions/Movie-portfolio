class MovieDetailsModel
{String Title;
String year;
int id;
String rated;
String category;
String released;
String runtime;
String genre;
String director;
String writer;
String actors;
String plot;
int watched;
String language;
String country;
String awards;
String poster;
List<Ratings> ratings;
String metascore;
String imdbRating;
String imdbVotes;
String imdbID;
String type;
String dVD;
String boxOffice;
String production;
String website;
String response;

MovieDetailsModel(
    {
      this.Title,
      this.year,
      this.id,
      this.rated,
      this.released,
      this.category,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.watched,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.ratings,
      this.metascore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.type,
      this.dVD,
      this.boxOffice,
      this.production,
      this.website,
      this.response});

MovieDetailsModel.fromJson(Map<String, dynamic> json) {
Title = json['Title'];
year = json['Year'];
id =json['id'];
watched =json['watched'];
rated = json['Rated'];
released = json['Released'];
category = json['category'];
runtime = json['Runtime'];
genre = json['Genre'];
director = json['Director'];
writer = json['Writer'];
actors = json['Actors'];
plot = json['Plot'];
language = json['Language'];
country = json['Country'];
awards = json['Awards'];
poster = json['Poster'];
if (json['Ratings'] != null) {
ratings = new List<Ratings>();
json['Ratings'].forEach((v) {
ratings.add(new Ratings.fromJson(v));
});
}
metascore = json['Metascore'];
imdbRating = json['imdbRating'];
imdbVotes = json['imdbVotes'];
imdbID = json['imdbID'];
type = json['Type'];
dVD = json['DVD'];
boxOffice = json['BoxOffice'];
production = json['Production'];
website = json['Website'];
response = json['Response'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Title'] = this.Title;
  data['Year'] = this.year;
  data['id'] = this.id;
  data['watched']=this.watched;
  data['Rated'] = this.rated;
  data['Released'] = this.released;
  data['category'] = this.category;
  data['Runtime'] = this.runtime;
  data['Genre'] = this.genre;
  data['Director'] = this.director;
  data['Writer'] = this.writer;
  data['Actors'] = this.actors;
  data['Plot'] = this.plot;
  data['Language'] = this.language;
  data['Country'] = this.country;
  data['Awards'] = this.awards;
  data['Poster'] = this.poster;
  if (this.ratings != null) {
    data['Ratings'] = this.ratings.map((v) => v.toJson()).toList();
  }
  data['Metascore'] = this.metascore;
  data['imdbRating'] = this.imdbRating;
  data['imdbVotes'] = this.imdbVotes;
  data['imdbID'] = this.imdbID;
  data['Type'] = this.type;
  data['DVD'] = this.dVD;
  data['BoxOffice'] = this.boxOffice;
  data['Production'] = this.production;
  data['Website'] = this.website;
  data['Response'] = this.response;
  return data;
}
Map<String,dynamic> toMap()
{
  var map =Map<String,dynamic>();
  if(id != null) {
    map['id'] = id;
  }
  map['Title'] =Title;
  map['Plot'] =plot;
  map ['Poster'] = poster;
  map ['Year'] = year;
  map ['category'] = category;

  return map;
}
// Extract a MovieObject from Map
MovieDetailsModel.fromMapObject(Map<String,dynamic> map)
{
  this.id = map['id'];
  this.Title = map['Title'];
  this.plot = map['plot'];
  this.poster = map['poster'];
  this.year = map['year'];
  this.watched = map['watched'];
  this.category = map ['category'];

}
}

class Ratings {
  String source;
  String value;

  Ratings({this.source, this.value});

  Ratings.fromJson(Map<String, dynamic> json) {
    source = json['Source'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Source'] = this.source;
    data['Value'] = this.value;
    return data;
  }

}