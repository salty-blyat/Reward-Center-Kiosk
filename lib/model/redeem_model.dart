import 'package:json_annotation/json_annotation.dart';

part 'redeem_model.g.dart';

@JsonSerializable()
class RedeemModel {
  int? id;
  DateTime? redeemDate;
  int? playerId;
  int? locationId;
  int? giftId;
  double? quantity;
  double? unitCost;
  double? totalPoint;
  String? note;

  RedeemModel({
    this.id,
    this.redeemDate,
    this.playerId,
    this.locationId,
    this.giftId,
    this.quantity,
    this.unitCost,
    this.totalPoint,
    this.note,
  });

  factory RedeemModel.fromJson(Map<String, dynamic> json) =>
      _$RedeemModelFromJson(json);

  Map<String, dynamic> toJson() => _$RedeemModelToJson(this);
}
