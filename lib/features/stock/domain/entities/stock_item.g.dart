// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StockItemAdapter extends TypeAdapter<StockItem> {
  @override
  final int typeId = 6;

  @override
  StockItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StockItem(
      merchId: fields[1] as String,
      quantity: fields[2] as int,
      festivalId: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StockItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.festivalId)
      ..writeByte(1)
      ..write(obj.merchId)
      ..writeByte(2)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StockItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
