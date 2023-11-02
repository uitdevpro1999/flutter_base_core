import 'package:json_annotation/json_annotation.dart';

part 'message_data.g.dart';

@JsonSerializable()
class MessageData {
  final String? description;
  final int? code;

  const MessageData({
    this.description,
    this.code,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) =>
      _$MessageDataFromJson(json);
}
