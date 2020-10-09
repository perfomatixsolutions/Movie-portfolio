class ProfileDetailsModel {
  String imgPath;


  ProfileDetailsModel({this.imgPath});


  ///mapping  of data to map object

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (imgPath != null) {
      map['imgpath'] = this.imgPath;
    }
    return map;
  }

  /// fun to  retrieve data from map  to MovieDetailsModel

    ProfileDetailsModel.fromMapObject(Map<String,dynamic> map)
  {
    this.imgPath = map['imgpath'];


  }


}