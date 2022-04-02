import 'package:get/get.dart';

import '../controllers/widget_test_controller.dart';

class WidgetTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WidgetTestController>(
      () => WidgetTestController(),
    );
  }
}
