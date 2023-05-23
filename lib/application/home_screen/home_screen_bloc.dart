import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_records/domain/home_screen/models/student_model.dart';
import 'package:student_records/infrastructure/home_screen/home_screen_service_implementation.dart.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenServicesImplementation homeScreenServicesImplementation =
      HomeScreenServicesImplementation();
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<GetAllStudents>((event, emit) async {
      final List<StudentModel> result =
          await homeScreenServicesImplementation.getAllData('');
      final newState = HomeScreenState(students: result,isLoading: false);
      emit(newState);
    });
  }
}
