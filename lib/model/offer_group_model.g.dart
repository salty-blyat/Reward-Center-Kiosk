// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferGroupModel _$OfferGroupModelFromJson(Map<String, dynamic> json) =>
    OfferGroupModel(
      id: (json['id'] as num?)?.toInt(),
      note: json['note'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$OfferGroupModelToJson(OfferGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'note': instance.note,
      'name': instance.name,
      'image': instance.image,
    };
