// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    TransactionModel(
      id: (json['id'] as num?)?.toInt(),
      transDate: json['transDate'] == null
          ? null
          : DateTime.parse(json['transDate'] as String),
      transType: (json['transType'] as num?)?.toInt(),
      note: json['note'] as String?,
      location: json['location'] as String?,
      point: (json['point'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transDate': instance.transDate?.toIso8601String(),
      'transType': instance.transType,
      'note': instance.note,
      'location': instance.location,
      'point': instance.point,
    };
