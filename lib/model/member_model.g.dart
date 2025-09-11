// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberModel _$MemberModelFromJson(Map<String, dynamic> json) => MemberModel(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      latinName: json['latinName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      birthDate: json['birthDate'] as String?,
      memberClassId: (json['memberClassId'] as num?)?.toInt(),
      memberClassName: json['memberClassName'] as String?,
      agentId: (json['agentId'] as num?)?.toInt(),
      agentName: json['agentName'] as String?,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$MemberModelToJson(MemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'latinName': instance.latinName,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'birthDate': instance.birthDate,
      'memberClassId': instance.memberClassId,
      'memberClassName': instance.memberClassName,
      'agentId': instance.agentId,
      'agentName': instance.agentName,
      'photo': instance.photo,
    };
