import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  final String? code;
  final String? name;
  final int? offerGroupId;
  final int? offerType;
  final String? note;
  final int? maxQty;
  final double? redeemedQty;
  final int? redeemWith;
  final double? redeemCost;
  final double? redeemMinBalance;
  final String? offerStartAt;
  final String? offerEndAt;
  final String? photo;
  final int? id;
  final String? offerGroupName;
  final String? offerTypeNameKh;
  final String? offerTypeNameEn;
  final String? redeemWithNameKh;
  final String? redeemWithNameEn;

  OfferModel({
    this.code,
    this.name,
    this.offerGroupId,
    this.offerType,
    this.note,
    this.maxQty,
    this.redeemedQty,
    this.redeemWith,
    this.redeemCost,
    this.redeemMinBalance,
    this.offerStartAt,
    this.offerEndAt,
    this.photo,
    this.id,
    this.offerGroupName,
    this.offerTypeNameKh,
    this.offerTypeNameEn,
    this.redeemWithNameKh,
    this.redeemWithNameEn,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}
