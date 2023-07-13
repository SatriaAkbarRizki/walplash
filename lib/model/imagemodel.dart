import 'package:json_annotation/json_annotation.dart';
import 'package:walplash/model/urls/urls.dart';
import 'package:walplash/model/user./user.dart';

part 'imagemodel.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  String id;
  String? alt_description;
  String created_at;
  int likes;
  Urls urls;
  User user;

  ImageModel(
      {required this.id,
      required this.alt_description,
      required this.created_at,
      required this.likes,
      required this.urls,
      required this.user});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}
