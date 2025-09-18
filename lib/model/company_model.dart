import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@JsonSerializable()
class CompanyModel {
  String? name;
  String? address;
  String? image;
  int? passcodeThresholdPoint;
  CompanyModel({
    this.name,
    this.address,
    this.image,
    this.passcodeThresholdPoint,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyModelToJson(this);
}
