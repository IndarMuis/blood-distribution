import 'package:blood_distirbution/app/routes/app_pages.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget fullNameInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Nama Lengkap",
          style: primaryTextStyle.copyWith(fontSize: 20, ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "nama lengkap....",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget tempatTanggalLahirInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Tempat, tanggal lahir",
          style: primaryTextStyle.copyWith(fontSize: 20, ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "tempat tanggal lahir....",
            hintStyle: primaryTextStyle.copyWith(fontWeight: light),
            contentPadding: EdgeInsets.all(defaultMargin),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ]);
    }

    Widget golonganDarahInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Golongan Darah",
          style: primaryTextStyle.copyWith(fontSize: 20, ),
        ),
        SizedBox(
          height: 8,
        ),
        DropdownSearch(
          mode: Mode.DIALOG,
          showClearButton: true,
          onChanged: (value) {
            print(value);
          },
          items: ["A", "B", "AB", "O"],
          dropdownSearchDecoration: InputDecoration(
              hintText: "Golongan Darah",
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: defaultMargin),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
        ),
      ]);
    }

    Widget usernameInput() {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Username",
          style: primaryTextStyle.copyWith(fontSize: 20, ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Your username....",
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
          style: primaryTextStyle.copyWith(fontSize: 20, ),
        ),
        SizedBox(
          height: 8,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Your Password....",
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
            onPressed: () {
              Get.toNamed(Routes.HOME);
            },
            child: Text(
              "Register",
              style: primaryTextStyle.copyWith(
                  fontSize: 20, color: backgroundColor, fontWeight: semiBold),
            )),
      );
    }

    Widget gotoSignUp() {
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
      margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin, bottom: 30),
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
          tempatTanggalLahirInput(),
          SizedBox(
            height: 20,
          ),
          golonganDarahInput(),
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
          buttonProcess(),
          SizedBox(
            height: 20,
          ),
          gotoSignUp()
        ],
      ),
    );
  }
}
