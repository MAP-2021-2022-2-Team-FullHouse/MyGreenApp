// @dart=2.9

class User {
  String username;
  String password;
  String uid;
  //String token;
  String name;
  String email;
  String phone;

  User({
    this.username = '',
    this.password = '',
    this.uid = '',
    //this.token = '',
    this.name = '',
    this.email = '',
    this.phone = '',
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
            username: json['username'],
            password: json['password'],
            uid: json['uid'],
            //token: json['token'],
            name: json['name'],
            email: json['email'],
            phone: json['phone']);

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'uid': uid,
        //'token': token,
        'name': name,
        'email': email,
        'phone': phone
      };

  copyWith({username, password, uid, token, name, email}) => User(
      username: username ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      //token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone);

  User.copy(from)
      : this(
            uid: from.uid,
            username: from.username,
            password: from.password,
            name: from.name,
            email: from.email,
            phone: from.phone);
}
