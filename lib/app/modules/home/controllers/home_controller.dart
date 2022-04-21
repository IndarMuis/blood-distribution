import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  final userData = FirebaseFirestore.instance.collection('users').withConverter(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (snapshot, _) => snapshot.toJson(),
      );
  final FirebaseFirestore fire = FirebaseFirestore.instance;
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getData() async {
    isLoading.value = true;
    String uid = await auth.currentUser!.uid;
    var data = fire.collection('users');
    isLoading.value = false;
    return data.doc(uid).get();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
