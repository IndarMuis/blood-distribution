import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  int? age;
  String? address;

  UserModel({this.name, this.age, this.address});

  UserModel.fromJson(Map<String,dynamic> json) {
    name = json['name'];
    age = json['age'];
    address = json['address'];
  }

  // static List<UserModel> toList(List list) {
  //   if (list.length == 0 || list.isEmpty) return [];
    
  // }
}
