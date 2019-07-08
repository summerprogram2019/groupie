class User {
  final String email;

  User(this.email);

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'];

  Map<String, dynamic> toJson() =>
      {
        'email': email,
      };
}