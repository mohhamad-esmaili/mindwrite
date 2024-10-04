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
      id: fields[0] as String?,
      createdDate: fields[1] as DateTime?,
      labelName: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LabelModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
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
