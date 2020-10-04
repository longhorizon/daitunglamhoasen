class User {
  int uid;
  String email;
  String first_name;
  String last_name;
  int su;
  String connection_key;

  User({
    this.uid,
    this.email,
    this.first_name,
    this.last_name,
    this.su,
    this.connection_key,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: int.parse(json['uid']),
      email: json['email'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      su: int.parse(json['su']),
      connection_key: json['connection_key'],
    );
  }
}
