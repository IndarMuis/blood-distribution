import 'package:get/get.dart';

import '../controllers/search_donor_controller.dart';

class SearchDonorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchDonorController>(
      () => SearchDonorController(),
    );
  }
}
