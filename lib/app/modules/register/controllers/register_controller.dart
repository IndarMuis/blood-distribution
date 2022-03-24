import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/models/user_model.dart';

class RegisterController extends GetxController {
  TextEditingController inputNamaLengkap = TextEditingController();
  TextEditingController inputTempatLahir = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputUsername = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  var inputTanggalLahir = "".obs;
  var inputGolonganDarah = "".obs;

  final user = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  FirebaseAuth auth = FirebaseAuth.instance;
  void addUser() async {
    if (inputNamaLengkap.text.isNotEmpty &&
        inputTempatLahir.text.isNotEmpty &&
        inputEmail.text.isNotEmpty &&
        inputUsername.text.isNotEmpty &&
        inputPassword.text.isNotEmpty &&
        inputTanggalLahir.isNotEmpty &&
        inputGolonganDarah.isNotEmpty) {
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: inputEmail.text, password: "password");

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          await user.doc(uid).set(UserModel(
                uid: uid,
                namaLengkap: inputNamaLengkap.text,
                tempatLahir: inputTempatLahir.text,
                tanggalLahir: inputTanggalLahir.value,
                golonganDarah: inputGolonganDarah.value,
                email: inputEmail.text,
                username: inputUsername.text,
              ));
          print(user.get());
          print(userCredential);
          Get.offAllNamed(Routes.HOME);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'week-password') {
          Get.snackbar('', '',
              colorText: backgroundColor,
              titleText: Text(
                'Error',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              messageText: Text(
                'Password yang digunakan terlalu singkat',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              backgroundColor: primaryColor.withOpacity(0.7),
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3));
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('', '',
              colorText: backgroundColor,
              titleText: Text(
                'Error',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              messageText: Text(
                'Email telah digunakan, mohon periksa kembali',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              backgroundColor: primaryColor.withOpacity(0.7),
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3));
        }
      } catch (e) {
        Get.snackbar('', '',
            colorText: backgroundColor,
            titleText: Text(
              'Error',
              style: primaryTextStyle.copyWith(
                  fontSize: 17, fontWeight: semiBold, color: backgroundColor),
            ),
            messageText: Text(
              'Terjadi kesalahan, Gagal menambahkan user',
              style: primaryTextStyle.copyWith(
                  fontSize: 17, fontWeight: semiBold, color: backgroundColor),
            ),
            backgroundColor: primaryColor.withOpacity(0.7),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3));
      }
    }
  }

  @override
  void onInit() {
    inputNamaLengkap.text;
    inputTempatLahir.text;
    inputEmail.text;
    inputUsername.text;
    inputPassword.text;
    super.onInit();
  }

  @override
  void onClose() {
    inputNamaLengkap.clear();
    inputTempatLahir.clear();
    inputEmail.clear();
    inputUsername.clear();
    inputPassword.clear();
  }
}
