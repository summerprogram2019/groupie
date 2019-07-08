class User {
  final int _id;
  String givenName;
  String familyName;
  String country;
  String city;
  DateTime dob;
  String sex;
  String pictureId;

  int get id => _id;

  User(this._id);

  User.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        givenName = json['given_name'],
        familyName = json['family_name'],
        country = json['country'],
        city = json['city'],
        dob = DateTime.parse(json['birthday']),
        sex = json['sex'],
        pictureId = json['picture_id'];

  Map<String, dynamic> toJson() =>
      {
        'given_name': givenName,
        'family_name': familyName,
        'country': country,
        'city': city,
        'birthday': dob,
        'sex': sex,
        'picture_id': pictureId
      };
}