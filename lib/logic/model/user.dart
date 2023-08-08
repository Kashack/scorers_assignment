import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class UserDetail extends Equatable{
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String? gender;
  final int? age;
  final String? DOB;
  final String? nationality;

  const UserDetail(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.username,
      this.gender,
      this.age,
      this.DOB,
      this.nationality});

  @override
  List<Object?> get props => [firstName,lastName,email];

  factory UserDetail.fromJson(Map<String, dynamic> json) => _$UserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetailToJson(this);
}