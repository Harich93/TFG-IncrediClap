
import 'dart:convert';

class User {
    User({
      this.uid,
      this.name,
      this.email,
      this.password
    });

    String? uid;
    String? name;
    String? email;
    String? password;


    factory User.fromJson(String str) => User.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());
    String toJsonLogin() => json.encode(toMapLogin());

    factory User.fromMap(Map<String, dynamic> json) => User(
        uid: json["uid"],
        name: json["name"],
        email: json["email"],
        password: json["password"]
    );

    Map<String, dynamic> toMap() => {
        "uid": uid,
        "name": name,
        "email": email,
        "password": password
    };

    Map<String, dynamic> toMapLogin() => {
        "email": email,
        "password": password
    };
}