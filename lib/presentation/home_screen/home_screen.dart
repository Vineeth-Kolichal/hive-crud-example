import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:student_records/application/home_screen/home_screen_controller.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/infrastructure/home_screen/home_screen_service_implementation.dart.dart';
// import 'package:student_records/presentation/pages/search_page.dart';
import 'package:student_records/presentation/StudentDetials/detailed_view.dart';
import 'package:student_records/presentation/input_form_screen/input_form_screen.dart';
import 'package:student_records/Widgets/input_bottom_sheet.dart';

HomeScreenServicesImplementation dataBaseFuctions =
    HomeScreenServicesImplementation();
HomeScreenController studentListController = Get.put(HomeScreenController());

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      studentListController.getAllStudentsDetails();
    });

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Obx(
            () => AppBar(
              elevation: 0,
              actions: [
                studentListController.isSearching.value
                    ? IconButton(
                        onPressed: () {
                          studentListController.searingFieldOpen(false);
                          studentListController.search('');
                        },
                        icon: const Icon(Icons.close))
                    : IconButton(
                        onPressed: () async {
                          studentListController.searingFieldOpen(true);
                        },
                        icon: const Icon(
                          Icons.search,
                        ),
                      )
              ],
              title: studentListController.isSearching.value
                  ? TextFormField(
                      onChanged: (value) {
                        studentListController.search(value);
                      },
                      cursorColor: const Color.fromARGB(255, 2, 110, 5),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white, fontSize: 17),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                        hintText: 'Search here',
                      ),
                    )
                  : Text('Student List'),
            ),
          )),
      backgroundColor: const Color.fromARGB(241, 243, 241, 241),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(child: Obx(() {
                  if (studentListController.studentList.isEmpty) {
                    return const Center(
                      child: Text('Student list is empty'),
                    );
                  }
                  return ListView.separated(
                    itemBuilder: (ctx, index) {
                      StudentModel stu =
                          studentListController.studentList[index];
                      File? image;
                      if (stu.imgPath != '') {
                        image = File(stu.imgPath!);
                      }
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          onTap: () {
                            Get.to(() =>
                                DetaildView(
                                    name: stu.name,
                                    age: stu.age,
                                    phone: stu.phone,
                                    email: stu.mail,
                                    image: image),
                                transition: Transition.cupertino);
                          },
                          title: Text(stu.name),
                          leading: CircleAvatar(
                            backgroundColor: Colors.black12,
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(20),
                                child: (image != null)
                                    ? Image.file(
                                        image,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/user.png'),
                              ),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    bottomSheet(context, stu);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    deleteAlert(
                                        context,
                                        studentListController
                                            .studentList[index]);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: studentListController.studentList.length,
                  );
                })),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() =>InputPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

Future<dynamic> bottomSheet(BuildContext context, StudentModel student) async {
  return await showModalBottomSheet(
      context: context,
      builder: ((BuildContext ctx) {
        return SizedBox(
          height: 660,
          child: InputBottonSheet(
            student: student,
          ),
        );
      }));
}

Future<void> deleteAlert(BuildContext context, StudentModel student) async {
  Get.dialog(
    AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('If you want to delete click "Yes" or click "No"'),
      actions: [
        TextButton(
            onPressed: () {
              dataBaseFuctions.deleteStudent(student.key);
              Get.back();
            },
            child: const Text('Yes')),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('No'),
        ),
      ],
    ),
  );
}
