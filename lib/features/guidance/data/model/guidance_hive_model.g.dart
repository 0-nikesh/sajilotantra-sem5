// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guidance_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GuidanceHiveModelAdapter extends TypeAdapter<GuidanceHiveModel> {
  @override
  final int typeId = 1;

  @override
  GuidanceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GuidanceHiveModel(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String,
      thumbnail: fields[3] as String,
      category: fields[4] as String,
      documentsRequired: (fields[5] as List?)?.cast<String>(),
      costRequired: fields[6] as String?,
      governmentProfileId: fields[7] as String?,
      userId: fields[8] as String?,
      createdAt: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, GuidanceHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.documentsRequired)
      ..writeByte(6)
      ..write(obj.costRequired)
      ..writeByte(7)
      ..write(obj.governmentProfileId)
      ..writeByte(8)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GuidanceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
