// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      transNo: json['transNo'] as String?,
      accountType: (json['accountType'] as num?)?.toInt(),
      transDate: json['transDate'] == null
          ? null
          : DateTime.parse(json['transDate'] as String),
      createdBy: json['createdBy'] as String?,
      note: json['note'] as String?,
      id: (json['id'] as num?)?.toInt(),
      accountId: (json['accountId'] as num?)?.toInt(),
      amount: (json['amount'] as num?)?.toDouble(),
      type: (json['type'] as num?)?.toInt(),
      refNo: json['refNo'] as String?,
      memberId: (json['memberId'] as num?)?.toInt(),
      memberCode: json['memberCode'] as String?,
      typeNameKh: json['typeNameKh'] as String?,
      typeNameEn: json['typeNameEn'] as String?,
      redeemNo: json['redeemNo'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      extData: json['extData'] as String?,
      offerName: json['offerName'] as String?,
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'transNo': instance.transNo,
      'transDate': instance.transDate?.toIso8601String(),
      'accountId': instance.accountId,
      'amount': instance.amount,
      'type': instance.type,
      'refNo': instance.refNo,
      'memberId': instance.memberId,
      'id': instance.id,
      'memberCode': instance.memberCode,
      'createdBy': instance.createdBy,
      'typeNameKh': instance.typeNameKh,
      'typeNameEn': instance.typeNameEn,
      'redeemNo': instance.redeemNo,
      'offerName': instance.offerName,
      'note': instance.note,
      'accountType': instance.accountType,
      'extData': instance.extData,
      'attachments': instance.attachments,
    };
