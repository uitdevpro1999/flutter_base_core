// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      data: json['data'] == null
          ? null
          : WeatherModel.fromJson(json['data'] as Map<String, dynamic>),
      mess: json['mess'] == null
          ? null
          : MessageData.fromJson(json['mess'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'mess': instance.mess,
    };
