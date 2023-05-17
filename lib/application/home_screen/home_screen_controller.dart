import 'package:get/get.dart';
import 'package:student_records/presentation/home_screen/home_screen.dart';

class HomeScreenController extends GetxController {
  RxList studentList = [].obs;
  void getAllStudentsDetails() async {
    studentList.clear();
    studentList.addAll(await dataBaseFuctions.getAllData());
  }
}
