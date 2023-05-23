import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_records/application/home_screen/home_screen_bloc.dart';
import 'package:student_records/application/input_screen/input_screen_bloc.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/presentation/home_screen/home_screen.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const StudentRecord());
}

class StudentRecord extends StatelessWidget {
  const StudentRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBloc>(create: (context) => HomeScreenBloc()),
        BlocProvider<InputScreenBloc>(create: (context) => InputScreenBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: HomeScreen(),
      ),
    );
  }
}
