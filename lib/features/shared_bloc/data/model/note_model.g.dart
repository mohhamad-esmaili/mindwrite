// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModelAdapter extends TypeAdapter<NoteModel> {
  @override
  final int typeId = 1;

  @override
  NoteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModel(
      id: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      lastUpdate: fields[3] as DateTime,
      labels: (fields[4] as List?)?.cast<LabelModel>(),
      noteBackground: fields[5] as BackgroundModel?,
      pin: fields[6] as bool,
      archived: fields[7] as bool,
      drawingsList: (fields[9] as List?)?.cast<Uint8List>(),
      isDeleted: fields[10] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.lastUpdate)
      ..writeByte(4)
      ..write(obj.labels)
      ..writeByte(5)
      ..write(obj.noteBackground)
      ..writeByte(6)
      ..write(obj.pin)
      ..writeByte(7)
      ..write(obj.archived)
      ..writeByte(9)
      ..write(obj.drawingsList)
      ..writeByte(10)
      ..write(obj.isDeleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
