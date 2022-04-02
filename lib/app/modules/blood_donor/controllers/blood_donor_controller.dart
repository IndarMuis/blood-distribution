import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class BloodDonorController extends GetxController {
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var isLoading = false.obs;
  var number = "".obs;
  var uid = "".obs;

  FirebaseFirestore fire = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<List<Object?>> dataRequests() async {
    isLoading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await fire.collection('requests').get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> data = [];

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      
      print("Permission not given");
    } else {
      Position currentPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      latitude.value = currentPostion.latitude;
      longitude.value = currentPostion.longitude;
      uid.value = await auth.currentUser!.uid;
      for (int i = 0; i < allData.length; i++) {
        var lat = double.parse(allData[i]['latitude']);
        var lon = double.parse(allData[i]['longitude']);
        var jarak = await Geolocator.distanceBetween(
            latitude.value, longitude.value, lat, lon);

        var jarakKm = jarak.round().toInt() / 1000;

        if (jarakKm < 20) {
          data.add(allData[i]);
          continue;
        } else {
          print("Tidak ditemukan");
        }
      }
      isLoading.value = false;
    }

    return data;
  }

  _callNumber() async {
    // var number = "${data['nomor telepon']}";
    // bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}
