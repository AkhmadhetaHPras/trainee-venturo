// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_cart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuCartAdapter extends TypeAdapter<MenuCart> {
  @override
  final int typeId = 0;

  @override
  MenuCart read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuCart(
      idMenu: fields[0] as int,
      harga: fields[1] as int,
      level: fields[2] as int,
      topping: (fields[3] as List).cast<int>(),
      jumlah: fields[4] as int,
      nama: fields[8] as String,
      kategori: fields[9] as String,
      catatan: fields[5] as String?,
      deskripsi: fields[7] as String?,
      foto: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MenuCart obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.idMenu)
      ..writeByte(1)
      ..write(obj.harga)
      ..writeByte(2)
      ..write(obj.level)
      ..writeByte(3)
      ..write(obj.topping)
      ..writeByte(4)
      ..write(obj.jumlah)
      ..writeByte(5)
      ..write(obj.catatan)
      ..writeByte(6)
      ..write(obj.foto)
      ..writeByte(7)
      ..write(obj.deskripsi)
      ..writeByte(8)
      ..write(obj.nama)
      ..writeByte(9)
      ..write(obj.kategori);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuCartAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
