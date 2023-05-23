import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'input_screen_event.dart';
part 'input_screen_state.dart';

class InputScreenBloc extends Bloc<InputScreenEvent, InputScreenState> {
  InputScreenBloc() : super(InputScreenInitial()) {
    on<ImagePicked>((event, emit) {
      final newState = InputScreenState(isImageSelected: true);
      emit(newState);
    });
  }
}
