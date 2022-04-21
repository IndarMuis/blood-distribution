import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class RegisterController extends GetxController {
  TextEditingController inputNamaLengkap = TextEditingController();
  TextEditingController inputTempatLahir = TextEditingController();
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputUsername = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  TextEditingController inputNomorTelepon = TextEditingController();
  var inputTanggalLahir = "".obs;
  var inputGolonganDarah = "".obs;
  var isLoading = false.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  final user = FirebaseFirestore.instance.collection('users');
  final request = FirebaseFirestore.instance.collection('request');

  FirebaseAuth auth = FirebaseAuth.instance;
  void addUser() async {
    if (inputNamaLengkap.text.isNotEmpty &&
        inputTempatLahir.text.isNotEmpty &&
        inputEmail.text.isNotEmpty &&
        inputUsername.text.isNotEmpty &&
        inputPassword.text.isNotEmpty &&
        inputNomorTelepon.text.isNotEmpty &&
        inputTanggalLahir.isNotEmpty &&
        inputGolonganDarah.isNotEmpty) {
      try {
        isLoading.value = true;
        Position currentPostion = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        latitude.value = currentPostion.latitude;
        longitude.value = currentPostion.longitude;
        List<Placemark> placemark =
            await placemarkFromCoordinates(latitude.value, longitude.value);
        var alamat = placemark[0].subLocality! + ', ' + placemark[0].locality!;
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: inputEmail.text, password: inputPassword.text);

        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;
          await user.doc(uid).set({
            "uid": uid,
            "namaLengkap": inputNamaLengkap.text,
            "tempatLahir": inputTempatLahir.text,
            "tanggalLahir": inputTanggalLahir.value,
            "golonganDarah": inputGolonganDarah.value,
            "email": inputEmail.text,
            "nomorTelepon": inputNomorTelepon.text,
            "username": inputUsername.text,
            "lokasiTerkini": {
              "latitude": latitude.value,
              "longitude": longitude.value,
              "alamat": alamat
            }
          });

          QuerySnapshot<Map<String, dynamic>> querySnapshot =
              await request.get();
          final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
          if (allData.isNotEmpty) {
            for (int i = 0; i < allData.length; i++) {
              var lat = allData[i]['latitude'];
              var lon = allData[i]['longitude'];

              var jarak = Geolocator.distanceBetween(
                          latitude.value, longitude.value, lat, lon)
                      .round()
                      .toInt() /
                  1000;
              request.doc(allData[i]['uid']).update({"jarak": jarak});
            }
          }
          print(user.get());
          print(userCredential);
          isLoading.value = false;

          Get.offAllNamed(Routes.HOME);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'week-password') {
          isLoading.value = false;
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
          isLoading.value = false;
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
        isLoading.value = false;
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
    inputNomorTelepon.clear();
    inputPassword.clear();
  }
}
