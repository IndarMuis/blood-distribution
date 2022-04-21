import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/models/user_model.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fire = FirebaseFirestore.instance;
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController username = TextEditingController();
  var tanggalLahir = "".obs;
  var golonganDarah = "".obs;
  var showButton = false.obs;
  var isLoading = false.obs;

  final user = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  void updateProfile() async {
    isLoading.value = true;
    try {
      String uid = await auth.currentUser!.uid;
      user.doc(uid).update({
        "namaLengkap": namaLengkap.text,
        "username": username.text,
        "tanggalLahir": tanggalLahir.value,
        "golonganDarah": golonganDarah.value
      });
      Get.snackbar(
        "Update",
        "user profile has been updated",
        backgroundColor: successColor,
        colorText: backgroundColor,
      );
      isLoading.value = false;
      Get.offAllNamed(Routes.PROFILE);
    } catch (e) {}
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> main() async {
    isLoading.value = true;
    String uid = await auth.currentUser!.uid;
    var data = fire.collection('users');
    isLoading.value = false;
    return data.doc(uid).get();
  }

  @override
  void onInit() async {
    String uid = await auth.currentUser!.uid;
    print("On init");
    var user = await fire.collection('users').doc(uid).get();
    print(user['namaLengkap']);
    print(uid);
    try {
      print("nama user ${user['namaLengkap']}");
      namaLengkap.text = user['namaLengkap'];
      username.text = user['username'];
      golonganDarah.value = user['golonganDarah'];
      tanggalLahir.value = user['tanggalLahir'];
    } catch (e) {}
    super.onInit();
  }
}
