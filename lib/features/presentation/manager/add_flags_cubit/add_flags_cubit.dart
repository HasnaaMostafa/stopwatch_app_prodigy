import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:stopwatch_app/core/constants.dart';
import 'package:stopwatch_app/features/data/models/marked_item_model.dart';

part 'add_flags_state.dart';

class AddFlagsCubit extends Cubit<AddFlagsState> {
  AddFlagsCubit() : super(AddFlagsInitial());

  addFlags(MarkedItemModel flagModel) async {
    emit(AddFlagsLoadingState());
    try {
      var flagsBox = Hive.box<MarkedItemModel>(kMarkedBox);

      await flagsBox.add(flagModel);
      emit(AddFlagsSuccessState());
    } catch (error) {
      emit(AddFlagsErrorState(error: error.toString()));
    }
  }
}
