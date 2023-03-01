// import 'dart:io';
// import 'package:hive_samle/db/model/data_model.dart';
// import 'package:hive_samle/db/screens/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import '../Models/studentModel.dart';


// class SearchScreen extends StatefulWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   final _searchController = TextEditingController();

//   List<StudentModel> studentList = Hive.box<StudentModel>('student_db').values.toList();

//   late List<StudentModel> studentDisplay = List<StudentModel>.from(studentList);



//   Widget expanded() {
    
//     return Expanded(
//       child: studentDisplay.isNotEmpty
//           ? ListView.builder(
//               itemCount: studentDisplay.length,
//               itemBuilder: (context, index) {
//                 File img = File(studentDisplay[index].image!);
//                 return ListTile(
//                   leading: CircleAvatar(   
//                     backgroundImage: FileImage(img),
//                     radius: 22,
//                   ),
//                   title: Text(studentDisplay[index].name),
//                   onTap: (() {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => StudentProfile(
//                                   passValue:studentDisplay[index],
//                                   passId: index,
//                                 )));
//                   }),
//                 );
//               },
//             )
//           : const Center(
//               child: Text(
//                 'No match found',
//                 style: TextStyle(fontSize: 20),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//     );
//   }

//   Widget searchTextField() {
//     return TextFormField(
//       autofocus: true,
//       controller: _searchController,
//       cursorColor: Colors.black,
//       style: const TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.search,color: Colors.white),
//         suffixIcon: IconButton(
//           icon: const Icon(Icons.clear,color: Colors.white,),
//           onPressed: () => clearText(),
//         ),
//         filled: true,
//         fillColor: Colors.green[300],
//         border: OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(30)),
//         hintText: 'Search',
//       ),
//       onChanged: (value) {
//         _searchStudent(value);
//       },
//     );
//   }

//   void _searchStudent(String value) {
//     setState(() {
//       studentDisplay = studentList.where((element) =>
//               element.name.toLowerCase().contains(value.trim().toLowerCase()))
//           .toList();
//     });
//   }

//   void clearText() {
//     _searchController.clear();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green[50],
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             children: <Widget>[
//               searchTextField(),
//               expanded(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }