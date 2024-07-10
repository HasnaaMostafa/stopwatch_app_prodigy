import 'package:hive/hive.dart';

part 'marked_item_model.g.dart';

@HiveType(typeId: 0)
class MarkedItemModel extends HiveObject {
  @HiveField(0)
  int num;
  @HiveField(1)
  String finalTime;
  @HiveField(2)
  String differenceTime;

  MarkedItemModel(
      {required this.differenceTime,
      required this.finalTime,
      required this.num});
}

//flutter packages pub run build_runner build
