// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherDataAdapter extends TypeAdapter<WeatherData> {
  @override
  final int typeId = 0;

  @override
  WeatherData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherData(
      city: fields[0] as String,
      temperature: fields[1] as double,
      condition: fields[2] as String,
      iconUrl: fields[3] as String,
      wind: fields[4] as double,
      humidity: fields[5] as int,
      pressure: fields[6] as double,
      forecast: (fields[7] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, WeatherData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.condition)
      ..writeByte(3)
      ..write(obj.iconUrl)
      ..writeByte(4)
      ..write(obj.wind)
      ..writeByte(5)
      ..write(obj.humidity)
      ..writeByte(6)
      ..write(obj.pressure)
      ..writeByte(7)
      ..write(obj.forecast);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
