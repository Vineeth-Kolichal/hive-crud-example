import 'package:get/get.dart';
import 'package:student_records/presentation/home_screen/home_screen.dart';

class HomeScreenController extends GetxController {
  RxBool isSearching = false.obs;
  RxList studentList = [].obs;
  RxString query = ''.obs;
  void getAllStudentsDetails() async {
    studentList.clear();
    studentList.addAll(await dataBaseFuctions.getAllData(query.value));
  }

  void searingFieldOpen(bool isOpen) {
    isSearching.value = isOpen;
  }

  void search(String searchQuery) {
    query.value = searchQuery;
    getAllStudentsDetails();
  }
}
