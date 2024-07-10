import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stopwatch_app/core/constants.dart';
import 'package:stopwatch_app/features/data/models/marked_item_model.dart';

part 'flagged_state.dart';

class FlaggedCubit extends Cubit<FlaggedState> {
  FlaggedCubit() : super(FlaggedInitial());

  List<MarkedItemModel>? flags;
  fetchFlags() {
    var flagsBox = Hive.box<MarkedItemModel>(kMarkedBox);
    flags = flagsBox.values.toList();
    emit(FlaggedSuccessState());
  }
}
