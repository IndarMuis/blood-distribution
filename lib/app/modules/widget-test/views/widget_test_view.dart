import 'package:blood_distirbution/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';

import '../controllers/widget_test_controller.dart';

class WidgetTestView extends GetView<WidgetTestController> {
  const WidgetTestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Object?>>(
        future: controller.viewData(),
        builder: (context, snapshot) {
          // var data = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var user = snapshot.data![index] as Map<String, dynamic>;

                return (controller.isLoading.value)
                    ? CircularProgressIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Nama : ${user['namaLengkap']}",
                              style: primaryTextStyle.copyWith(fontSize: 17)),
                          Text("Latitude : ${user['latitude']}",
                              style: primaryTextStyle.copyWith(fontSize: 17)),
                          Text("Longitude : ${user['longitude']}",
                              style: primaryTextStyle.copyWith(fontSize: 17)),
                          ElevatedButton(
                              onPressed: () {
                                print(user['namaLengkap']);
                              },
                              child: Text("View data"))
                        ],
                      );
              });
        },
      ),
    );
  }
}
