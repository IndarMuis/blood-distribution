import 'package:blood_distirbution/app/modules/login/controllers/login_controller.dart';
import 'package:blood_distirbution/app/modules/register/controllers/register_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fire = FirebaseFirestore.instance;
  
  final user = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  Future<DocumentSnapshot<Map<String,dynamic>>> main() async {
    String uid = await auth.currentUser!.uid;
    var data = fire.collection('users');  
    return data.doc(uid).get();
  }
  // Future<QuerySnapshot<Object?>> main2() async {
    // String uid = await auth.currentUser!.uid;
  //   var data = fire.collection('users');
  //   var user = data.doc(uid).get();

  //   print("${user['username']}");
  // }
}
