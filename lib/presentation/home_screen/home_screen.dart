import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_records/application/home_screen/home_screen_bloc.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/infrastructure/home_screen/home_screen_service_implementation.dart.dart';
import 'package:student_records/presentation/StudentDetials/detailed_view.dart';
import 'package:student_records/presentation/input_form_screen/input_form_screen.dart';
import 'package:student_records/presentation/Widgets/input_bottom_sheet.dart';

HomeScreenServicesImplementation dataBaseFuctions =
    HomeScreenServicesImplementation();
ValueNotifier<bool> searchEnable = ValueNotifier(false);

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      context.read<HomeScreenBloc>().add(GetAllStudents());
    });

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ValueListenableBuilder(
            valueListenable: searchEnable,
            builder: (context, open, _) {
              return AppBar(
                elevation: 0,
                actions: [
                  open
                      ? IconButton(
                          onPressed: () {
                            searchEnable.value = false;
                            context
                                .read<HomeScreenBloc>()
                                .add(GetAllStudents());
                            // studentListController.searchingFieldOpen(false);
                            // studentListController.search('');
                          },
                          icon: const Icon(Icons.close))
                      : IconButton(
                          onPressed: () async {
                            searchEnable.value = true;
                            context
                                .read<HomeScreenBloc>()
                                .add(GetAllStudents());
                            //studentListController.searchingFieldOpen(true);
                          },
                          icon: const Icon(
                            Icons.search,
                          ),
                        )
                ],
                title: open
                    ? TextFormField(
                        onChanged: (value) {
                          //studentListController.search(value);
                        },
                        cursorColor: const Color.fromARGB(255, 2, 110, 5),
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintStyle:
                              TextStyle(color: Colors.white, fontSize: 17),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                          hintText: 'Search here',
                        ),
                      )
                    : const Text('Student List'),
              );
            }),
      ),
      backgroundColor: const Color.fromARGB(241, 243, 241, 241),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
              builder: (context, state) {
                print(state.students);
                if (state.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                }
                if (state.students.isEmpty) {
                  return Center(
                    child: Text('No students found'),
                  );
                }
                return ListView.separated(
                  itemBuilder: (ctx, index) {
                    StudentModel stu = state.students[index];
                    //studentListController.studentList[index];
                    File? image;
                    if (stu.imgPath != '') {
                      image = File(stu.imgPath!);
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: ((ctx) => DetaildView(
                                  name: stu.name,
                                  age: stu.age,
                                  phone: stu.phone,
                                  email: stu.mail,
                                  image: image))));
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
                                  deleteAlert(context, state.students[index]);
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
                  itemCount: state.students.length,
                );
              },
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
            return InputPage();
          }));
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
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content:
              const Text('If you want to delete click "Yes" or click "No"'),
          actions: [
            TextButton(
                onPressed: () {
                  dataBaseFuctions.deleteStudent(student.key);
                  context.read<HomeScreenBloc>().add(GetAllStudents());
                  Navigator.of(ctx).pop();
                },
                child: const Text('Yes')),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      });
}
