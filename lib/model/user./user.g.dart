// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String,
      profile_image:
          Profile.fromJson(json['profile_image'] as Map<String, dynamic>),
      total_photos: json['total_photos'] as int,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'total_photos': instance.total_photos,
      'profile_image': instance.profile_image.toJson(),
    };
