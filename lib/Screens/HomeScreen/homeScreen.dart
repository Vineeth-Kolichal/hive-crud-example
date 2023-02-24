import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:student_records/Screens/StudentDetials/detailed_view.dart';
import 'package:student_records/Screens/HomeScreen/inputPage.dart';
import 'package:student_records/Widgets/input_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemBuilder: (ctx, index) {
                return Card(
                  color: Color.fromARGB(255, 241, 239, 239),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => DetaildView()));
                    },
                    title: Text('name$index'),
                    leading: CircleAvatar(backgroundColor: Colors.black54),
                    trailing: SizedBox(
                      width: 150,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return SizedBox(
                  height: 5,
                );
              },
              itemCount: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => InputPage(),
          ));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Student List'),
      ),
    );
  }
}

// Future<dynamic> bottomSheet(BuildContext context) async {
//   return await showModalBottomSheet(
//       context: context,
//       builder: ((BuildContext ctx) {
//         return SizedBox(
//           child: InputBottonSheet(),
//           height: 620,
//         );
//       }));
// }
