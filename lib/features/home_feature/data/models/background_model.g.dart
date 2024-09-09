// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BackgroundModelAdapter extends TypeAdapter<BackgroundModel> {
  @override
  final int typeId = 2;

  @override
  BackgroundModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BackgroundModel(
      color: fields[0] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, BackgroundModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BackgroundModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
