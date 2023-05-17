import 'package:get/get.dart';

class InputFormScreenController extends GetxController {
  RxString imagePath = ''.obs;
  RxBool isPicked = false.obs;
  void setPickedImage(String imgPath, bool isPick) {
    imagePath.value = imgPath;
    isPicked.value = isPick;
  }
}
