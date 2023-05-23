part of 'input_screen_bloc.dart';

class InputScreenState {
  final bool isImageSelected;
  InputScreenState({ required this.isImageSelected});
}

class InputScreenInitial extends InputScreenState {
  InputScreenInitial() : super( isImageSelected: false);
}
