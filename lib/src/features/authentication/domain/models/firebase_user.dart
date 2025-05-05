import 'package:json_annotation/json_annotation.dart';

part 'firebase_user.g.dart';

@JsonSerializable()
class FbUserModel {
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final String phoneNumber;
  final bool isAnonymous;
  final bool isEmailVerified;
  final String creationTime;
  final String lastSignInTime;
  final String tenantId;
  final String refreshToken;

  const FbUserModel({
    this.uid = '',
    this.email = '',
    this.displayName = '',
    this.photoUrl = '',
    this.phoneNumber = '',
    this.isAnonymous = false,
    this.isEmailVerified = false,
    this.creationTime = '',
    this.lastSignInTime = '',
    this.tenantId = '',
    this.refreshToken = '',
  });

  factory FbUserModel.fromJson(Map<String, dynamic> json) => _$FbUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$FbUserModelToJson(this);
}
