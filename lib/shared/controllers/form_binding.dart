import 'package:get/get.dart';
import 'form_controllers.dart';

class FormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FormControllers>(() => FormControllers());
  }
}
