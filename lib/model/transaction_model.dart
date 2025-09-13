import 'package:json_annotation/json_annotation.dart';
import 'package:reward_center_kiosk/model/attachment_model.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class TransactionModel {
  final String? transNo;
  final DateTime? transDate;
  final int? accountId;
  final double? amount;
  final int? type;
  final String? refNo;
  final int? memberId;
  final int? id;
  final String? memberCode;
  final String? createdBy;
  final String? typeNameKh;
  final String? typeNameEn;
  final String? redeemNo;
  final String? offerName;
  final String? note;
  final int? accountType;
  final String? extData;
  final List<Attachment>? attachments;

  TransactionModel(
      {this.transNo,
      this.accountType,
      this.transDate,
      this.createdBy,
      this.note,
      this.id,
      this.accountId,
      this.amount,
      this.type,
      this.refNo,
      this.memberId,
      this.memberCode,
      this.typeNameKh,
      this.typeNameEn,
      this.redeemNo,
      this.attachments,
      this.extData,
      this.offerName});

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
}
