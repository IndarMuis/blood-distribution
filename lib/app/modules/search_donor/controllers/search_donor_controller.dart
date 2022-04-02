import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/user_model.dart';

class SearchDonorController extends GetxController {
  var golonganDarah = "".obs;
  var banyakDarah = "".obs;
  var longitude = "".obs;
  var latitude = "".obs;
  TextEditingController inputNomorTelepon = TextEditingController();

  var isLoading = false.obs;

  final requests = FirebaseFirestore.instance.collection('requests');
  final firestore = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  var exist = false.obs;
  

  @override
  void onInit() async {
    String uid = auth.currentUser!.uid;
    isLoading.value = true;
    await requests
        .doc(uid)
        .get()
        .then((value) => {value.exists ? exist.value = true : false});
    print("On init");
    isLoading.value = false;
    print(exist);
  }

  void searchDonor() async {
    String uid = auth.currentUser!.uid;
    // LocationPermission permission = await Geolocator.checkPermission();

    isLoading.value = true;
    DocumentSnapshot<Map<String, dynamic>?> data =
        await firestore.doc(uid).get();
    Map<String, dynamic> user = data.data()!;

    if (golonganDarah.value != "" &&
        banyakDarah.value != "" &&
        golonganDarah.isNotEmpty &&
        banyakDarah.isNotEmpty &&
        inputNomorTelepon.text.isNotEmpty &&
        !exist.value) {
      Position currentPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude.value = currentPostion.latitude.toString();
      longitude.value = currentPostion.longitude.toString();

      try {
        await requests.doc(uid).set({
          "namaLengkap": user['namaLengkap'],
          "tempatLahir": user['tempatLahir'],
          "tanggalLahir": user['tanggalLahir'],
          "email": user['email'],
          "nomor telepon": inputNomorTelepon.text,
          "permintaan": banyakDarah.value + " Kantong Darah",
          "golongan": golonganDarah.value,
          "latitude": latitude.value,
          "longitude": longitude.value,
          "tanggal": DateFormat('dd-MM-yyyy').format(DateTime.now()).toString()
        });

        isLoading.value = false;
        exist.value = true;
        Get.defaultDialog(
            title: "Berhasil",
            titlePadding:
                EdgeInsets.only(top: defaultMargin, bottom: defaultMargin),
            contentPadding: EdgeInsets.only(bottom: defaultMargin),
            titleStyle: primaryTextStyle.copyWith(fontSize: 25),
            confirm: Container(
              margin: EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    primary: successColor),
                onPressed: () {
                  Get.offAllNamed(Routes.SEARCH_DONOR);
                },
                child: Text(
                  "OK",
                  style: primaryTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: semiBold,
                      color: backgroundColor),
                ),
              ),
            ),
            backgroundColor: backgroundColor,
            confirmTextColor: backgroundColor,
            content: Image.asset(
              "assets/success.png",
              width: 100,
            ));
      } catch (e) {
        isLoading.value = false;
        Get.snackbar('', '',
            colorText: backgroundColor,
            titleText: Text(
              'Error',
              style: primaryTextStyle.copyWith(
                  fontSize: 17, fontWeight: semiBold, color: backgroundColor),
            ),
            messageText: Text(
              'Mohon Periksa Kembali Inputan Anda',
              style: primaryTextStyle.copyWith(
                  fontSize: 17, fontWeight: semiBold, color: backgroundColor),
            ),
            backgroundColor: primaryColor.withOpacity(0.7),
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 3));
      }
    } else {
      isLoading.value = false;
      Get.snackbar('', '',
          colorText: backgroundColor,
          titleText: Text(
            'Error',
            style: primaryTextStyle.copyWith(
                fontSize: 17, fontWeight: semiBold, color: backgroundColor),
          ),
          messageText: Text(
            'Mohon Periksa Kembali Inputan Anda',
            style: primaryTextStyle.copyWith(
                fontSize: 17, fontWeight: semiBold, color: backgroundColor),
          ),
          backgroundColor: primaryColor.withOpacity(0.7),
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3));
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getUser() async {
    String uid = await auth.currentUser!.uid;
    return requests.doc(uid).get();
  }

  @override
  void onClose() {
    inputNomorTelepon.clear();
    super.onClose();
  }
}
