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
      lightColor: fields[0] as Color?,
      darkColor: fields[1] as Color?,
      lightBackgroundPath: fields[2] as String?,
      darkBackgroundPath: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BackgroundModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.lightColor)
      ..writeByte(1)
      ..write(obj.darkColor)
      ..writeByte(2)
      ..write(obj.lightBackgroundPath)
      ..writeByte(3)
      ..write(obj.darkBackgroundPath);
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
