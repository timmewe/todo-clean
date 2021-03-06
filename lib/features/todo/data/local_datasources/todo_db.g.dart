// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoDbAdapter extends TypeAdapter<TodoDb> {
  @override
  final int typeId = 0;

  @override
  TodoDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoDb(
      id: fields[0] as int,
      title: fields[1] as String,
      completed: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TodoDb obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDbAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
