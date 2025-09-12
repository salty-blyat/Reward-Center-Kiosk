import 'package:json_annotation/json_annotation.dart';
import 'package:reward_center_kiosk/model/attachment_model.dart';

part 'redemption_model.g.dart';


@JsonSerializable()
class RedemptionModel {
  final int? accountId;
  final String? redeemNo;
  final DateTime? redeemedDate;
  final String? refNo;
  final int? offerId;
  final double? qty;
  final double? amount;
  final int? status;
  final int? locationId;
  final String? locationName;
  final String? offerName;
  final String? memberName;
  final String? memberCode;
  final String? statusNameKh;
  final String? statusNameEn;
  final String? statusImage;
  final String? createdBy;
  final int? id;
  final String? note;
  final String? extData;
  final List<Attachment>? attachments;
  final int? accountType;
  final int? redeemWith;
  final String? redeemWithNameKh;
  final String? redeemWithNameEn;
  final String? offerPhoto;

  RedemptionModel(
      {this.accountId,
      this.offerPhoto,
      this.redeemNo,
      this.redeemedDate,
      this.refNo,
      this.offerId,
      this.qty,
      this.amount,
      this.status,
      this.locationId,
      this.locationName,
      this.offerName,
      this.statusNameKh,
      this.statusImage,
      this.createdBy,
      this.note,
      this.id,
      this.statusNameEn,
      this.attachments,
      this.extData,
      this.accountType,
      this.redeemWith,
      this.redeemWithNameEn,
      this.redeemWithNameKh,
      this.memberCode,
      this.memberName}); 

  factory RedemptionModel.fromJson(Map<String, dynamic> json) =>
      _$RedemptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$RedemptionModelToJson(this);
}
