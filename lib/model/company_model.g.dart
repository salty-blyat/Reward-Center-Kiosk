// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyModel _$CompanyModelFromJson(Map<String, dynamic> json) => CompanyModel(
      name: json['name'] as String?,
      address: json['address'] as String?,
      image: json['image'] as String?,
      passcodeThresholdPoint: (json['passcodeThresholdPoint'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CompanyModelToJson(CompanyModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'image': instance.image,
      'passcodeThresholdPoint': instance.passcodeThresholdPoint,
    };
