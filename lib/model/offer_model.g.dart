// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      code: json['code'] as String?,
      name: json['name'] as String?,
      offerGroupId: (json['offerGroupId'] as num?)?.toInt(),
      offerType: (json['offerType'] as num?)?.toInt(),
      note: json['note'] as String?,
      maxQty: (json['maxQty'] as num?)?.toInt(),
      redeemedQty: (json['redeemedQty'] as num?)?.toDouble(),
      redeemWith: (json['redeemWith'] as num?)?.toInt(),
      redeemCost: (json['redeemCost'] as num?)?.toDouble(),
      redeemMinBalance: (json['redeemMinBalance'] as num?)?.toDouble(),
      offerStartAt: json['offerStartAt'] as String?,
      offerEndAt: json['offerEndAt'] as String?,
      photo: json['photo'] as String?,
      id: (json['id'] as num?)?.toInt(),
      offerGroupName: json['offerGroupName'] as String?,
      offerTypeNameKh: json['offerTypeNameKh'] as String?,
      offerTypeNameEn: json['offerTypeNameEn'] as String?,
      redeemWithNameKh: json['redeemWithNameKh'] as String?,
      redeemWithNameEn: json['redeemWithNameEn'] as String?,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'offerGroupId': instance.offerGroupId,
      'offerType': instance.offerType,
      'note': instance.note,
      'maxQty': instance.maxQty,
      'redeemedQty': instance.redeemedQty,
      'redeemWith': instance.redeemWith,
      'redeemCost': instance.redeemCost,
      'redeemMinBalance': instance.redeemMinBalance,
      'offerStartAt': instance.offerStartAt,
      'offerEndAt': instance.offerEndAt,
      'photo': instance.photo,
      'id': instance.id,
      'offerGroupName': instance.offerGroupName,
      'offerTypeNameKh': instance.offerTypeNameKh,
      'offerTypeNameEn': instance.offerTypeNameEn,
      'redeemWithNameKh': instance.redeemWithNameKh,
      'redeemWithNameEn': instance.redeemWithNameEn,
    };
