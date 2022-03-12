import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../theme.dart';
import '../controllers/register_controller.dart';
import 'widgets/register_form.dart';
import 'widgets/register_header.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: ListView(
          children: [
            Align(alignment: Alignment.topCenter, child: RegisterHeader()),
            SizedBox(
              height: 60,
            ),
            RegisterForm(),
          ],
        ),
      ),
    );
  }
}
