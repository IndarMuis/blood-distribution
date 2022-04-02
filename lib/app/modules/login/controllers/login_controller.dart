import 'package:blood_distirbution/app/modules/register/controllers/register_controller.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../theme.dart';

class LoginController extends GetxController {
  TextEditingController inputEmail = TextEditingController();
  TextEditingController inputPassword = TextEditingController();
  RegisterController regis = Get.put(RegisterController());
  FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  void login() async {
    if (inputEmail.text.isNotEmpty && inputPassword.text.isNotEmpty) {
      try {
        isLoading.value = true;
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: inputEmail.text,
          password: inputPassword.text,
        );

        print(userCredential);
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
