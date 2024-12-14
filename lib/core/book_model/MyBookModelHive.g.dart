// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyBookModelHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyBookModelHiveAdapter extends TypeAdapter<MyBookModelHive> {
  @override
  final int typeId = 0;

  @override
  MyBookModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyBookModelHive(
      id: fields[0] as String,
      title: fields[1] as String,
      author: fields[2] as String,
      thumbnail: fields[3] as String,
      price: fields[4] as double,
      description: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyBookModelHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyBookModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
