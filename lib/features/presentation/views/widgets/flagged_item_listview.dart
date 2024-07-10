import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch_app/features/presentation/manager/flagged_cubit.dart';
import 'package:stopwatch_app/features/presentation/views/widgets/flagged_item.dart';

import '../../../data/models/marked_item_model.dart';

class FlaggedItemListView extends StatelessWidget {
  const FlaggedItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlaggedCubit, FlaggedState>(
      listener: (context, state) {
        if (state is FlaggedSuccessState) {}
      },
      builder: (context, state) {
        List<MarkedItemModel> flags =
            BlocProvider.of<FlaggedCubit>(context).flags ?? [];
        return SizedBox(
          height: 300,
          width: double.infinity,
          child: ListView.builder(
              itemCount: flags.length,
              itemBuilder: (BuildContext context, int index) {
                return FlaggedItem(markedItemModel: flags[index]);
              }),
        );
      },
    );
  }
}
