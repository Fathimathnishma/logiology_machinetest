// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Usermodel {
  String? username;
  String? password;
  String? id;
  String? profileImgurl;
  Timestamp? createdAt;
  Usermodel({
    this.username,
    this.password,
    this.id,
    this.profileImgurl,
    this.createdAt,
  });

  Usermodel copyWith({
    String? username,
    String? password,
    String? id,
    String? profileImgurl,
    Timestamp? createdAt,
  }) {
    return Usermodel(
      username: username ?? this.username,
      password: password ?? this.password,
      id: id ?? this.id,
      profileImgurl: profileImgurl ?? this.profileImgurl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'id': id,
      'profileImgurl': profileImgurl,
      'createdAt': createdAt,
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      profileImgurl:
          map['profileImgurl'] != null ? map['profileImgurl'] as String : null,
      createdAt:
          map['createdAt'] != null ? map['createdAt'] as Timestamp : null,
    );
  }
}
