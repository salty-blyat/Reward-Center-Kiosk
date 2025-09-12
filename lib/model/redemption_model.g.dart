// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redemption_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedemptionModel _$RedemptionModelFromJson(Map<String, dynamic> json) =>
    RedemptionModel(
      accountId: (json['accountId'] as num?)?.toInt(),
      offerPhoto: json['offerPhoto'] as String?,
      redeemNo: json['redeemNo'] as String?,
      redeemedDate: json['redeemedDate'] == null
          ? null
          : DateTime.parse(json['redeemedDate'] as String),
      refNo: json['refNo'] as String?,
      offerId: (json['offerId'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toInt(),
      locationId: (json['locationId'] as num?)?.toInt(),
      locationName: json['locationName'] as String?,
      offerName: json['offerName'] as String?,
      statusNameKh: json['statusNameKh'] as String?,
      statusImage: json['statusImage'] as String?,
      createdBy: json['createdBy'] as String?,
      note: json['note'] as String?,
      id: (json['id'] as num?)?.toInt(),
      statusNameEn: json['statusNameEn'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      extData: json['extData'] as String?,
      accountType: (json['accountType'] as num?)?.toInt(),
      redeemWith: (json['redeemWith'] as num?)?.toInt(),
      redeemWithNameEn: json['redeemWithNameEn'] as String?,
      redeemWithNameKh: json['redeemWithNameKh'] as String?,
      memberCode: json['memberCode'] as String?,
      memberName: json['memberName'] as String?,
    );

Map<String, dynamic> _$RedemptionModelToJson(RedemptionModel instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'redeemNo': instance.redeemNo,
      'redeemedDate': instance.redeemedDate?.toIso8601String(),
      'refNo': instance.refNo,
      'offerId': instance.offerId,
      'qty': instance.qty,
      'amount': instance.amount,
      'status': instance.status,
      'locationId': instance.locationId,
      'locationName': instance.locationName,
      'offerName': instance.offerName,
      'memberName': instance.memberName,
      'memberCode': instance.memberCode,
      'statusNameKh': instance.statusNameKh,
      'statusNameEn': instance.statusNameEn,
      'statusImage': instance.statusImage,
      'createdBy': instance.createdBy,
      'id': instance.id,
      'note': instance.note,
      'extData': instance.extData,
      'attachments': instance.attachments,
      'accountType': instance.accountType,
      'redeemWith': instance.redeemWith,
      'redeemWithNameKh': instance.redeemWithNameKh,
      'redeemWithNameEn': instance.redeemWithNameEn,
      'offerPhoto': instance.offerPhoto,
    };
