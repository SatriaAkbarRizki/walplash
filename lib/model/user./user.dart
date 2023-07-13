import 'package:json_annotation/json_annotation.dart';
import 'package:walplash/model/user./profile.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String name;
  int total_photos;
  Profile profile_image;

  User(
      {required this.name,
      required this.profile_image,
      required this.total_photos});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
