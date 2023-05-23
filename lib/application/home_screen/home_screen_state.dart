part of 'home_screen_bloc.dart';

class HomeScreenState {
  List<StudentModel> students;
  bool isLoading;
  HomeScreenState({required this.students,required this.isLoading});
}

class HomeScreenInitial extends HomeScreenState {
  HomeScreenInitial() : super(students: [],isLoading: true);
}
