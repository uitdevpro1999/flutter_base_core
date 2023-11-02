// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthInfo _$AuthInfoFromJson(Map<String, dynamic> json) => AuthInfo(
      accessToken: json['access_token'] as String?,
      expiresIn: json['expires_in'] as int?,
      refreshToken: json['refresh_token'] as String?,
      refreshExpiresIn: json['refresh_expires_in'] as int?,
      tokenType: json['token_type'] as String?,
      sessionState: json['session_state'] as String?,
      scope: json['scope'] as String?,
      isEtc: json['is_etc'] as bool?,
    );

Map<String, dynamic> _$AuthInfoToJson(AuthInfo instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'expires_in': instance.expiresIn,
      'refresh_token': instance.refreshToken,
      'refresh_expires_in': instance.refreshExpiresIn,
      'token_type': instance.tokenType,
      'session_state': instance.sessionState,
      'scope': instance.scope,
      'is_etc': instance.isEtc,
    };

AuthMessage _$AuthMessageFromJson(Map<String, dynamic> json) => AuthMessage(
      error: json['error'] as String?,
      errorDescription: json['error_description'] as String?,
    );

Map<String, dynamic> _$AuthMessageToJson(AuthMessage instance) =>
    <String, dynamic>{
      'error': instance.error,
      'error_description': instance.errorDescription,
    };
