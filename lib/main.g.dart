part of 'main.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchAdapter extends TypeAdapter<SearchResponseModel> {
  @override
  final int typeId = 1;

  @override
  SearchResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchResponseModel(
      text: fields[0] as String,
      url: fields[1] as String,
      image: fields[2] as String,
        category:fields[3] as String,
        isFavourite: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SearchResponseModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.isFavourite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SearchAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}