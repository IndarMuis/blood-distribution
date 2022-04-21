import 'package:blood_distirbution/theme.dart';
import 'package:flutter/material.dart';

class ContentAboutDonor extends StatelessWidget {
  const ContentAboutDonor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '''
      Aplikasi Donor Darah ini adalah aplikasi yang memudahkan dalam kegiatan pencarian sukarelawan  donor darah. Semua pengguna dalam aplikasi ini adalah sukarelawan donor darah. 
      Setiap pengguna dapat melakukan pencarian sukarelawan donor darah sesuai dengan kebutuhan. Aplikasi pencarian sukarelawan pada aplikasi ini akan melakukan pencarian sukarelawan donor darah pada seluruh pengguna aplikasi yang berada pada radius 20 km. 
      Selain itu, pengguna aplikasi akan mendapatkan permohonan atau permintaan donor darah dari pengguna lain dan dapat melakukan konfirmasi kesediaan melakukan donor darah.
                ''';
    return Container(
      margin: EdgeInsets.all(defaultMargin),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "About :",
              style:
                  primaryTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: primaryTextStyle.copyWith(fontSize: 15, fontWeight: medium),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10,),
          Image.asset(
            "assets/logo.png",
            width: 30,
          ),
          
          Text("Version: 1.0", style: primaryTextStyle.copyWith(fontStyle: FontStyle.italic, fontWeight: light)),
        ],
      ),
    );
  }
}
