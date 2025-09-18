// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MerchAdapter extends TypeAdapter<Merch> {
  @override
  final int typeId = 0;

  @override
  Merch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Merch(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String?,
      price: fields[3] as double,
      purchasePrice: fields[4] as double?,
      image: fields[5] as Uint8List?,
      categoryId: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Merch obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.purchasePrice)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MerchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
