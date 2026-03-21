// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'excercise.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExcerciseAdapter extends TypeAdapter<Excercise> {
  @override
  final int typeId = 1;

  @override
  Excercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Excercise(
      name: fields[1] as String,
      description: fields[2] as String,
      records: (fields[3] as List).cast<Record_>(),
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, Excercise obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.records);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExcerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
