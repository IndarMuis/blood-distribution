import 'package:blood_distirbution/app/modules/register/controllers/register_controller.dart';
import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterForm extends GetView<RegisterController> {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fullNameInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Nama Lengkap",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: controller.inputNamaLengkap,
          validator: (value) {
            if (value!.isEmpty) {
              return "Form must be filled";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: "_",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget tempatLahir() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Tempat Lahir",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller.inputTempatLahir,
          decoration: InputDecoration(
            hintText: "_",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget tanggalLahir() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Tanggal Lahir",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Obx(() => TextField(
              readOnly: true,
              onTap: () async {
                DateTime? date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1960),
                    lastDate: DateTime.now());

                if (date != null) {
                  print(
                      date); //pickedDate output format => 2021-03-10 00:00:00.000
                  String getDate = DateFormat('dd-MM-yyyy').format(date);
                  controller.inputTanggalLahir.value = getDate;
                }
              },
              decoration: InputDecoration(
                hintStyle: primaryTextStyle.copyWith(fontWeight: light),
                contentPadding: EdgeInsets.all(defaultMargin),
                hintText: controller.inputTanggalLahir.value.isEmpty
                    ? 'Tap Here'
                    : controller.inputTanggalLahir.value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )),
      ]);
    }

    Widget golonganDarahInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Golongan Darah",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        DropdownSearch(
          mode: Mode.DIALOG,
          showClearButton: true,
          onChanged: (value) {
            controller.inputGolonganDarah.value = value.toString();
          },
          items: ["A", "B", "AB", "O"],
          dropdownSearchDecoration: InputDecoration(
              hintText: "Tap Here",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: defaultMargin),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ]);
    }

    Widget emailInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Email",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller.inputEmail,
          decoration: InputDecoration(
            hintText: "example@gmail.com",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light, fontSize: 14, fontStyle: FontStyle.italic),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget usernameInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Username",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller.inputUsername,
          decoration: InputDecoration(
            hintText: "_",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget passwordInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Password",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          controller: controller.inputPassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "min: 8 character",
            hintStyle: primaryTextStyle.copyWith(
                fontWeight: light, fontSize: 14, fontStyle: FontStyle.italic),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget nomorTeleponInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Nomor Telepon",
          style: primaryTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: controller.inputNomorTelepon,
          decoration: InputDecoration(
            hintText: "_",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget buttonProcess() {
      return Container(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: blueColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25))),
            onPressed: () async {
              LocationPermission permission;
              var serviceEnabled = await Geolocator.isLocationServiceEnabled();
              if (!serviceEnabled) {
                Get.snackbar('', '',
                    colorText: backgroundColor,
                    titleText: Text(
                      'Error',
                      style: primaryTextStyle.copyWith(
                          fontSize: 17,
                          fontWeight: semiBold,
                          color: backgroundColor),
                    ),
                    messageText: Text(
                      'Akses lokasi ditolak',
                      style: primaryTextStyle.copyWith(
                          fontSize: 17,
                          fontWeight: semiBold,
                          color: backgroundColor),
                    ),
                    backgroundColor: primaryColor.withOpacity(0.7),
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 3));
                return Get.offAllNamed(Routes.REGISTER);
              }

              permission = await Geolocator.checkPermission();
              if (permission == LocationPermission.denied) {
                permission = await Geolocator.requestPermission();
                permission = await Geolocator.requestPermission();
                if (permission == LocationPermission.denied) {
                  Get.snackbar('', '',
                      colorText: backgroundColor,
                      titleText: Text(
                        'Error',
                        style: primaryTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: semiBold,
                            color: backgroundColor),
                      ),
                      messageText: Text(
                        'Akses lokasi ditolak',
                        style: primaryTextStyle.copyWith(
                            fontSize: 17,
                            fontWeight: semiBold,
                            color: backgroundColor),
                      ),
                      backgroundColor: primaryColor.withOpacity(0.7),
                      snackPosition: SnackPosition.TOP,
                      duration: Duration(seconds: 3));
                  return Get.offAllNamed(Routes.REGISTER);
                }
                controller.addUser();
              }

              if (permission == LocationPermission.deniedForever) {
                Get.snackbar('', '',
                    colorText: backgroundColor,
                    titleText: Text(
                      'Error',
                      style: primaryTextStyle.copyWith(
                          fontSize: 17,
                          fontWeight: semiBold,
                          color: backgroundColor),
                    ),
                    messageText: Text(
                      'Akses lokasi ditolak',
                      style: primaryTextStyle.copyWith(
                          fontSize: 17,
                          fontWeight: semiBold,
                          color: backgroundColor),
                    ),
                    backgroundColor: primaryColor.withOpacity(0.7),
                    snackPosition: SnackPosition.TOP,
                    duration: Duration(seconds: 3));
                return Get.offAllNamed(Routes.REGISTER);
              }
              controller.addUser();
            },
            child: Obx(() => (controller.isLoading.value)
                ? CircularProgressIndicator(
                    color: backgroundColor,
                  )
                : Text(
                    "Register",
                    style: primaryTextStyle.copyWith(
                        fontSize: 20,
                        color: backgroundColor,
                        fontWeight: semiBold),
                  ))),
      );
    }

    Widget gotoSign() {
      return Column(
        children: [
          Text("Do you already have an account?",
              style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: light,
                  fontStyle: FontStyle.italic)),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.LOGIN);
            },
            child: Text("Sign In",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                  color: blueColor,
                )),
          )
        ],
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 40),
      margin: EdgeInsets.only(
          left: defaultMargin, right: defaultMargin, bottom: 30),
      // height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: blueColor,
          blurRadius: 4,
        ),
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          fullNameInput(),
          SizedBox(
            height: 20,
          ),
          tempatLahir(),
          SizedBox(
            height: 20,
          ),
          tanggalLahir(),
          SizedBox(
            height: 20,
          ),
          golonganDarahInput(),
          SizedBox(
            height: 20,
          ),
          emailInput(),
          SizedBox(
            height: 20,
          ),
          usernameInput(),
          SizedBox(
            height: 20,
          ),
          passwordInput(),
          SizedBox(
            height: 40,
          ),
          nomorTeleponInput(),
          SizedBox(
            height: 40,
          ),
          buttonProcess(),
          SizedBox(
            height: 20,
          ),
          gotoSign()
        ],
      ),
    );
  }
}
