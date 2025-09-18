import 'package:json_annotation/json_annotation.dart';
import 'package:reward_center_kiosk/model/attachment_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  int? id;
  DateTime? transDate;
  int? transType;
  String? note;
  String? location;
  double? point;

  TransactionModel({
    this.id,
    this.transDate,
    this.transType,
    this.note,
    this.location,
    this.point,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
