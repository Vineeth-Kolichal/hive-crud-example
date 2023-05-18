import 'package:get/get.dart';
import 'package:student_records/presentation/home_screen/home_screen.dart';

class HomeScreenController extends GetxController {
  RxBool isSearching = false.obs;
  RxList studentList = [].obs;
  RxString query = ''.obs;
  RxString updateImagePath = ''.obs;
  RxBool isImageSelected = false.obs;
  void getAllStudentsDetails() async {
    studentList.clear();
    studentList.addAll(await dataBaseFuctions.getAllData(query.value));
  }

  void searchingFieldOpen(bool isOpen) {
    isSearching.value = isOpen;
  }

  void search(String searchQuery) {
    query.value = searchQuery;
    getAllStudentsDetails();
  }

  void updateImage(String imagePath, bool isSelected) {
    updateImagePath.value = imagePath;
    isImageSelected.value = isSelected;
    update();
  }
}
