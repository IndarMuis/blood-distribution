import 'package:blood_distirbution/app/modules/register/controllers/register_controller.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';

class LoginController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  RegisterController regis = Get.put(RegisterController());
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fire = FirebaseFirestore.instance;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;
  var jarak = 0.0.obs;

  void login() async {
    if (inputEmail.text.isNotEmpty && inputPassword.text.isNotEmpty) {
      try {
        isLoading.value = true;

        await auth.signInWithEmailAndPassword(
          email: inputEmail.text,
          password: inputPassword.text,
        );

        Position currentPostion = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        latitude.value = currentPostion.latitude;
        longitude.value = currentPostion.longitude;
        List<Placemark> placemark =
            await placemarkFromCoordinates(latitude.value, longitude.value);
        var alamat = placemark[0].subLocality! + ', ' + placemark[0].locality!;
        await fire.collection('users').doc(auth.currentUser!.uid).update({
          "lokasiTerkini": {
            "latitude": latitude.value,
            "longitude": longitude.value,
            "alamat": alamat
          },
          // "jarak":
        });

        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await fire.collection('requests').get();
        // QuerySnapshot<Map<String, dynamic>> dataUser =
        //     await fire.collection('users').get();
        final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
        // final allUser = dataUser.docs.map((doc) => doc.data()).toList();
        if (allData.isNotEmpty) {
          for (int i = 0; i < allData.length; i++) {
            var lat = allData[i]['lokasi']['latitude'];
            var lon = allData[i]['lokasi']['longitude'];
            print("Lat request ${lat}");
            print("lon request ${lon}");
            var km = Geolocator.distanceBetween(
                latitude.value, longitude.value, lat, lon);
            jarak.value = km.round() / 1000;
            fire
                .collection('requests')
                .doc(allData[i]['uid'])
                .update({"jarak": jarak.value});
            print(allData[i]['uid'] + " berhasil di update");

            fire.collection('users').doc(auth.currentUser!.uid).update({
              "jarak": jarak.value
            });
          }
        }

        // if (allUser.isNotEmpty) {
        //   for (int i = 0; i < allUser.length; i++) {
        //     var km = Geolocator.distanceBetween(
        //         latitude.value, longitude.value, lat, lon);
        //     jarak.value = km.round() / 1000;
        //     print("jarak m ${jarak.value}");
        //     print("jarak km ${jarak.value.round() / 1000}");
        //     print("jarak km-m ${jarak.value * 1000}");
        //     fire
        //         .collection('users')
        //         .doc(allData[i]['uid'])
        //         .update({"jarak": jarak.value});
        //   }
        // }

        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading.value = false;
          Get.snackbar('', '',
              colorText: backgroundColor,
              titleText: Text(
                'Error',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              messageText: Text(
                'Terjadi kesalahan, Email tidak terdaftar',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              backgroundColor: primaryColor.withOpacity(0.7),
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3));
        } else if (e.code == 'wrong-password') {
          isLoading.value = false;
          Get.snackbar('', '',
              colorText: backgroundColor,
              titleText: Text(
                'Error',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              messageText: Text(
                'Terjadi kesalahan, Password salah',
                style: primaryTextStyle.copyWith(
                    fontSize: 17, fontWeight: semiBold, color: backgroundColor),
              ),
              backgroundColor: primaryColor.withOpacity(0.7),
              snackPosition: SnackPosition.TOP,
              duration: Duration(seconds: 3));
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
                'Email/Password salah',
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
              'Email/password salah',
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
    inputEmail.text;
    inputPassword.text;
    super.onInit();
  }

  @override
  void onClose() {
    inputEmail.clear();
    inputPassword.clear();
    super.onClose();
  }
}
