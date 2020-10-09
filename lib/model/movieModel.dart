class MovieModel{
  List<Search> search;
  String totalResults;
  String response;

  MovieModel({this.search, this.totalResults, this.response});

  MovieModel.fromJson(Map<String, dynamic> json) {
    if (json['Search'] != null) {
      search = new List<Search>();
      json['Search'].forEach((v) {
        search.add(new Search.fromJson(v));
      });
    }
    totalResults = json['totalResults'];
    response = json['Response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.search != null) {
      data['Search'] = this.search.map((v) => v.toJson()).toList();
    }
    data['totalResults'] = this.totalResults;
    data['Response'] = this.response;
    return data;
  }
}

class Search {

  String Title;
  String year;
  String imdbID;
  String type;
  String poster;

  Search({this.Title, this.year, this.imdbID, this.type, this.poster});

  Search.fromJson(Map<String, dynamic> json) {
    Title = json['Title'];
    year = json['Year'];
    imdbID = json['imdbID'];
    type = json['Type'];
    poster = json['Poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.Title;
    data['Year'] = this.year;
    data['imdbID'] = this.imdbID;
    data['Type'] = this.type;
    data['Poster'] = this.poster;
    return data;
  }
}




