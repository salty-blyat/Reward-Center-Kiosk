import 'package:json_annotation/json_annotation.dart';

part 'member_detail_model.g.dart';

// TODO: delete this later. 



@JsonSerializable()
class MemberDetailModel {
  final int? id;
  final String? code;
  final String? name;
  final String? latinName;
  final String? email;
  final String? phone;
  final String? address;
  final String? birthDate;
  final int? memberClassId;
  final int? agentId;
  final int? defaultAccountId;
  final String? photo;
  final String? agentName;
  final String? memberClassName;
  final String? memberClassPhoto;
  final DateTime? joinDate;
  final List<MemberAccount>? accounts;

  MemberDetailModel({
    this.id,
    this.code,
    this.name,
    this.latinName,
    this.agentName,
    this.memberClassName,
    this.memberClassPhoto,
    this.email,
    this.phone,
    this.address,
    this.birthDate,
    this.memberClassId,
    this.agentId,
    this.defaultAccountId,
    this.photo,
    this.accounts,
    this.joinDate,
  });

  factory MemberDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MemberDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberDetailModelToJson(this);
}

@JsonSerializable()
class MemberAccount {
  final int? accountId;
  final double? balance;
  final String? accountTypeNameKh;
  final String? accountTypeNameEn;
  final int? accountType;

  MemberAccount({
    this.accountId,
    this.balance,
    this.accountTypeNameKh,
    this.accountTypeNameEn,
    this.accountType,
  });

  factory MemberAccount.fromJson(Map<String, dynamic> json) =>
      _$MemberAccountFromJson(json);

  Map<String, dynamic> toJson() => _$MemberAccountToJson(this);
}
