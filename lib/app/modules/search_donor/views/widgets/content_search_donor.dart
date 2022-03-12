import 'package:blood_distirbution/theme.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ContentSearchDonor extends StatelessWidget {
  const ContentSearchDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget inputGolonganDarah() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Golongan darah yang dibutuhkan :",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 10,
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
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8, horizontal: defaultMargin),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      );
    }

    Widget inputJumlahDarah() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Banyak darah yang dibutuhkan :",
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownSearch(
            mode: Mode.DIALOG,
            showClearButton: true,
            onChanged: (value) {
              print(value);
            },
            items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
            dropdownSearchDecoration: InputDecoration(
                hintText: "Kantong Darah",
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8, horizontal: defaultMargin),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ],
      );
    }

    Widget buttonProcess() {
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: 10, horizontal: defaultMargin),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Center(
            child: Text(
              "Cari Sukarelawan",
              style: primaryTextStyle.copyWith(
                fontSize: 20,
                color: backgroundColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      );
    }

    Widget miniMap() {
      return Container(
        height: MediaQuery.of(context).size.height / 5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            "MINI MAP",
            style: primaryTextStyle.copyWith(fontSize: 20, fontWeight: medium),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(defaultMargin),
      child: Column(
        children: [
          inputGolonganDarah(),
          SizedBox(
            height: 20,
          ),
          inputJumlahDarah(),
          SizedBox(
            height: 30,
          ),
          buttonProcess(),
          SizedBox(
            height: 40,
          ),
          Align(alignment: Alignment.bottomCenter, child: miniMap())
        ],
      ),
    );
  }
}
