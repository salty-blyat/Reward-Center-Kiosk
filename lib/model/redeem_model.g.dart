// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redeem_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedeemModel _$RedeemModelFromJson(Map<String, dynamic> json) => RedeemModel(
      id: (json['id'] as num?)?.toInt(),
      redeemDate: json['redeemDate'] == null
          ? null
          : DateTime.parse(json['redeemDate'] as String),
      playerId: (json['playerId'] as num?)?.toInt(),
      locationId: (json['locationId'] as num?)?.toInt(),
      giftId: (json['giftId'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toDouble(),
      unitCost: (json['unitCost'] as num?)?.toDouble(),
      totalPoint: (json['totalPoint'] as num?)?.toDouble(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$RedeemModelToJson(RedeemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'redeemDate': instance.redeemDate?.toIso8601String(),
      'playerId': instance.playerId,
      'locationId': instance.locationId,
      'giftId': instance.giftId,
      'quantity': instance.quantity,
      'unitCost': instance.unitCost,
      'totalPoint': instance.totalPoint,
      'note': instance.note,
    };
