// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LetterAdapter extends TypeAdapter<Letter> {
  @override
  final int typeId = 0;

  @override
  Letter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Letter(
      val: fields[0] as String,
      status: fields[1] as LetterStatus,
    );
  }

  @override
  void write(BinaryWriter writer, Letter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.val)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LetterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
