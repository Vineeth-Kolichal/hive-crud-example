import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'input_screen_event.dart';
part 'input_screen_state.dart';

class InputScreenBloc extends Bloc<InputScreenEvent, InputScreenState> {
  InputScreenBloc() : super(InputScreenInitial()) {
    on<InputScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
