import 'package:json_annotation/json_annotation.dart';
import 'package:walplash/model/links/links.dart';
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
  Links links;

  ImageModel(
      {required this.id,
      required this.alt_description,
      required this.created_at,
      required this.likes,
      required this.urls,
      required this.user,
      required this.links});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}
