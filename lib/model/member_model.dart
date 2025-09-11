import 'package:json_annotation/json_annotation.dart';

part 'member_model.g.dart';

@JsonSerializable()
class MemberModel {
  final int? id;
  final String? code;
  final String? name;
  final String? latinName;
  final String? email;
  final String? phone;
  final String? address;
  final String? birthDate;
  final int? memberClassId;
  final String? memberClassName;
  final int? agentId;
  final String? agentName;
  final String? photo;

  MemberModel({
    this.id,
    this.code,
    this.name,
    this.latinName,
    this.email,
    this.phone,
    this.address,
    this.birthDate,
    this.memberClassId,
    this.memberClassName,
    this.agentId,
    this.agentName,
    this.photo,
  });

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this);
}
