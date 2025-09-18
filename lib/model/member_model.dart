import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  int? id;
  String? code;
  String? name;
  String? junketName;
  String? playerClassName;
  String? cardNumber;
  DateTime? joinDate;
  String? photo;
  int? point;
  int? pointEarnToday;
  DateTime? lastSeenAt;
  bool? hasPassCode;
  bool? active;

  MemberModel({
    this.id,
    this.code,
    this.name,
    this.junketName,
    this.playerClassName,
    this.cardNumber,
    this.joinDate,
    this.photo,
    this.point,
    this.pointEarnToday,
    this.lastSeenAt,
    this.hasPassCode,
    this.active,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
