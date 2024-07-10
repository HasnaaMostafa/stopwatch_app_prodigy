part of 'add_flags_cubit.dart';

abstract class AddFlagsState {}

class AddFlagsInitial extends AddFlagsState {}

class AddFlagsLoadingState extends AddFlagsState {}

class AddFlagsSuccessState extends AddFlagsState {}

class AddFlagsErrorState extends AddFlagsState {
  final String error;

  AddFlagsErrorState({required this.error});
}
