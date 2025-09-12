import 'package:json_annotation/json_annotation.dart';

part 'offer_group_model.g.dart';

@JsonSerializable()
class OfferGroupModel {
  final int? id;
  final String? note;
  final String? name;
  final String? image;

  OfferGroupModel({
    this.id,
    this.note,
    this.name,
    this.image,
  });

  factory OfferGroupModel.fromJson(Map<String, dynamic> json) =>
      _$OfferGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferGroupModelToJson(this);
}
