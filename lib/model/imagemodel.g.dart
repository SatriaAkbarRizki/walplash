// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imagemodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      id: json['id'] as String,
      alt_description: json['alt_description'] as String?,
      created_at: json['created_at'] as String,
      likes: json['likes'] as int,
      urls: Urls.fromJson(json['urls'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alt_description': instance.alt_description,
      'created_at': instance.created_at,
      'likes': instance.likes,
      'urls': instance.urls.toJson(),
      'user': instance.user.toJson(),
    };
