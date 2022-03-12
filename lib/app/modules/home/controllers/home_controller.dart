import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllData() async {
    var value = await firebase.collection('user').get();
    var data = value.docs;

    if (data.length > 0) {
      try {
        return data.map((e) {
          UserModel user = UserModel.fromJson(Map<String,dynamic>.from(e.data()));
          print(user.name);
          return user;
        }).toList();
      } catch (e) {
        print(e.toString());
        return [];
      }
    } else {
      return [];
    }
  }
}
