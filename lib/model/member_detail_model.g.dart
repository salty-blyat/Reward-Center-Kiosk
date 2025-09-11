// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberDetailModel _$MemberDetailModelFromJson(Map<String, dynamic> json) =>
    MemberDetailModel(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      name: json['name'] as String?,
      latinName: json['latinName'] as String?,
      agentName: json['agentName'] as String?,
      memberClassName: json['memberClassName'] as String?,
      memberClassPhoto: json['memberClassPhoto'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      birthDate: json['birthDate'] as String?,
      memberClassId: (json['memberClassId'] as num?)?.toInt(),
      agentId: (json['agentId'] as num?)?.toInt(),
      defaultAccountId: (json['defaultAccountId'] as num?)?.toInt(),
      photo: json['photo'] as String?,
      accounts: (json['accounts'] as List<dynamic>?)
          ?.map((e) => MemberAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
      joinDate: json['joinDate'] == null
          ? null
          : DateTime.parse(json['joinDate'] as String),
    );

Map<String, dynamic> _$MemberDetailModelToJson(MemberDetailModel instance) =>
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
      'agentId': instance.agentId,
      'defaultAccountId': instance.defaultAccountId,
      'photo': instance.photo,
      'agentName': instance.agentName,
      'memberClassName': instance.memberClassName,
      'memberClassPhoto': instance.memberClassPhoto,
      'joinDate': instance.joinDate?.toIso8601String(),
      'accounts': instance.accounts,
    };

MemberAccount _$MemberAccountFromJson(Map<String, dynamic> json) =>
    MemberAccount(
      accountId: (json['accountId'] as num?)?.toInt(),
      balance: (json['balance'] as num?)?.toDouble(),
      accountTypeNameKh: json['accountTypeNameKh'] as String?,
      accountTypeNameEn: json['accountTypeNameEn'] as String?,
      accountType: (json['accountType'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MemberAccountToJson(MemberAccount instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'balance': instance.balance,
      'accountTypeNameKh': instance.accountTypeNameKh,
      'accountTypeNameEn': instance.accountTypeNameEn,
      'accountType': instance.accountType,
    };
