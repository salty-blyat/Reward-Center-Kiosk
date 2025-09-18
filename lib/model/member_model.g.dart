// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      junketName: json['junketName'] as String?,
      playerClassName: json['playerClassName'] as String?,
      cardNumber: json['cardNumber'] as String?,
      joinDate: json['joinDate'] == null
          ? null
          : DateTime.parse(json['joinDate'] as String),
      photo: json['photo'] as String?,
      point: (json['point'] as num?)?.toInt(),
      pointEarnToday: (json['pointEarnToday'] as num?)?.toInt(),
      lastSeenAt: json['lastSeenAt'] == null
          ? null
          : DateTime.parse(json['lastSeenAt'] as String),
      hasPassCode: json['hasPassCode'] as bool?,
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'junketName': instance.junketName,
      'playerClassName': instance.playerClassName,
      'cardNumber': instance.cardNumber,
      'joinDate': instance.joinDate?.toIso8601String(),
      'photo': instance.photo,
      'point': instance.point,
      'pointEarnToday': instance.pointEarnToday,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
      'hasPassCode': instance.hasPassCode,
      'active': instance.active,
    };
