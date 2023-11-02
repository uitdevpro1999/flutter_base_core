// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoData _$NoDataFromJson(Map<String, dynamic> json) => NoData(
      mess: json['mess'] == null
          ? null
          : MessageData.fromJson(json['mess'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NoDataToJson(NoData instance) => <String, dynamic>{
      'mess': instance.mess,
    };
