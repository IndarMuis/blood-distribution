import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: defaultMargin, right: defaultMargin, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: primaryTextStyle.copyWith(
                      fontSize: 30, fontWeight: medium),
                ),
                Text(
                  "Your Account",
                  style: primaryTextStyle.copyWith(
                      fontSize: 25, fontWeight: medium),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/logo.png"))),
          ),
        ],
      ),
    );
  }
}
