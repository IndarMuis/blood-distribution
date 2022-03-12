import 'package:flutter/material.dart';

import '../../../../../theme.dart';

class CardMenu extends StatelessWidget {
  String? menuName;
  String? menuImage;
  CardMenu({Key? key, this.menuName, this.menuImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultMargin),
      height: 160,
      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 10,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.5, color: primaryColor),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "${menuImage}",
            width: 60,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${menuName}",
            style: primaryTextStyle.copyWith(
                fontSize: 18, fontWeight: semiBold, color: primaryColor),
          )
        ],
      ),
    );
  }
}
