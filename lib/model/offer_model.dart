import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  int? id;
  String? code;
  String? name;
  double? cost;
  String? image;
  bool? canRedeem;

  OfferModel({
    this.id,
    this.code,
    this.name,
    this.cost,
    this.image,
    this.canRedeem,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
