import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:stopwatch_app/features/data/models/marked_item_model.dart';
import 'package:stopwatch_app/features/presentation/manager/add_flags_cubit/add_flags_cubit.dart';
import 'package:stopwatch_app/features/presentation/manager/flagged_cubit.dart';
import 'package:stopwatch_app/features/presentation/views/stopwatch_view.dart';

import 'core/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MarkedItemModelAdapter());
  await Hive.openBox<MarkedItemModel>(kMarkedBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => FlaggedCubit()..fetchFlags()),
        BlocProvider(create: (BuildContext context) => AddFlagsCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const StopwatchView(),
      ),
    );
  }
}
