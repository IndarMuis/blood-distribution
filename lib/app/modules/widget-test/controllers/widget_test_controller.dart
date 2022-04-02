import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class WidgetTestController extends GetxController {
  var lattitude = 0.0.obs;
  var longitude = 0.0.obs;
  var uid = "".obs;
  var isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fire = FirebaseFirestore.instance;
  // -5.1373588,
  // 119.4455718

  void getCurrentLocation() async {
    isLoading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
      print("Permission not given");
    } else {
      Position currentPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      lattitude.value = currentPostion.latitude;
      longitude.value = currentPostion.longitude;
      uid.value = await auth.currentUser!.uid;
      isLoading.value = false;
      // print(longitude.value);
      // print(lattitude.value);

      var locationIMeter = await Geolocator.distanceBetween(
          lattitude.value, longitude.value, -5.2068267, 119.450605);

      // var m = locationIMeter.round().toInt();
      // var km = locationIMeter.round().toInt() / 1000;
      // print("Jarak M ke umi ${m}");
      // print("Jarak KM ke umi ${km}");
    }
  }

  Future<List<Object?>> viewData() async {
    isLoading.value = true;
    LocationPermission permission = await Geolocator.checkPermission();
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await fire.collection('requests').get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    List<Map<String, dynamic>> get = [];

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      LocationPermission asked = await Geolocator.requestPermission();
      print("Permission not given");
    } else {
      Position currentPostion = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      lattitude.value = currentPostion.latitude;
      longitude.value = currentPostion.longitude;
      uid.value = await auth.currentUser!.uid;
      for (int i = 0; i < allData.length; i++) {
        var lat = double.parse(allData[i]['latitude']);
        var lon = double.parse(allData[i]['longitude']);
        var jarak = await Geolocator.distanceBetween(
            lattitude.value, longitude.value, lat, lon);

        var jarakKm = jarak.round().toInt() / 1000;

        if (jarakKm < 20) {
          get.add(allData[i]);
          continue;
        } else {
          print("Tidak ditemukan");
        }
      }
      isLoading.value = false;
    }

    return get;
  }

  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference req = fire.collection('requests');

    return req.snapshots();
  }

  @override
  void onInit() async {
    uid.value = await auth.currentUser!.uid;
    super.onInit();
  }
}
