// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'label_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LabelModelAdapter extends TypeAdapter<LabelModel> {
  @override
  final int typeId = 3;

  @override
  LabelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LabelModel(
      labelName: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LabelModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.labelName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LabelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
