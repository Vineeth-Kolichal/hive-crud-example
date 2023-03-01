// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:student_records/database/functions/db_functions.dart';

// class SearchBar extends StatefulWidget {
//   const SearchBar({super.key});

//   @override
//   State<SearchBar> createState() => _SearchBarState();
// }

// class _SearchBarState extends State<SearchBar> {
//   TextEditingController SearchTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 70,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: AnimSearchBar(
//           rtl: true,
//           onSubmitted: (p0) {
//             search(SearchTextController.text);
//           },
//           width: 400,
//           textController: SearchTextController,
//           onSuffixTap: () {
//             setState(() {
//               SearchTextController.clear();
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
