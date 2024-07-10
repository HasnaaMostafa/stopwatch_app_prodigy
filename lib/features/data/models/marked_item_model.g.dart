// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marked_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarkedItemModelAdapter extends TypeAdapter<MarkedItemModel> {
  @override
  final int typeId = 0;

  @override
  MarkedItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarkedItemModel(
      differenceTime: fields[2] as String,
      finalTime: fields[1] as String,
      num: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MarkedItemModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.num)
      ..writeByte(1)
      ..write(obj.finalTime)
      ..writeByte(2)
      ..write(obj.differenceTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarkedItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
