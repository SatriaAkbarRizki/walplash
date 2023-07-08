import 'package:json_annotation/json_annotation.dart';
import 'package:walplash/model/urls/urls.dart';

part 'imagemodel.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  String id;
  String? alt_description;
  Urls urls;

  ImageModel(
      {required this.id, required this.alt_description, required this.urls});

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      _$ImageModelFromJson(json);
}
