import 'package:blood_distirbution/app/modules/login/views/widgets/login_form.dart';
import 'package:blood_distirbution/app/modules/login/views/widgets/login_header.dart';
import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: LoginHeader()),
            SizedBox(height: 60,),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
